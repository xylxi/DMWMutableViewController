//
//  DMWMutViewController.swift
//  DMWMutableViewController
//
//  Created by WangZHW on 15/12/9.
//  Copyright © 2015年 XYLXI. All rights reserved.
//

import UIKit

class DMWMutViewController: UIViewController,UIScrollViewDelegate {
    // public
    /// 是否需要内容是否全屏
    var isfullScreen: Bool = false
    /// 标题背景的颜色
    var titleScrollViewBackgroundImage: UIImage?
    /// 标题背景的图片
    var titleScrollViewBacgroundColor : UIColor?
    /// 标题Label高度
    var titleHeight: CGFloat = DMWTitleScrollViewH
    /// 标题正常字体颜色
    var titleNorColor: UIColor = UIColor.blackColor()
    /// 标题选中字体颜色
    var titleSelColor: UIColor = UIColor.redColor()
    /// 标题的字体样式
    var titleFont: UIFont = DMWTitleFont
    /// 标题的间距...这个现在还没有处理好
    var titleMargin:CGFloat = DMWMargin
    /// 是否缩放
    var isTitleScale: Bool = true
    /// 是否大小
    var titleScale: CGFloat!
    
    private var titleScrollView: UIScrollView!
    private var titleLabels = [UILabel]()
    private var titleWidths:[CGFloat]!
    private var contentScrollView: UIScrollView!
    private var lastSelectIndex: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //标题栏
        setUptitleScrollView()
        //内容栏
        setUpContentScrollView()
        self.automaticallyAdjustsScrollViewInsets = false
        self.contentScrollView.pagingEnabled = true
        self.contentScrollView.bounces = false
        lastSelectIndex = 0
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if titleLabels.count == 0 {
            setUpTitleWidth()
            setUpAllTitle()
        }
    }
    
    // private
    /**
    添加顶部标题栏
    */
    private func setUptitleScrollView(){
        titleScrollView = UIScrollView()
        titleScrollView.backgroundColor = titleScrollViewBacgroundColor ?? UIColor.whiteColor()
        
        // frame
        let y = self.navigationController != nil ? DMWNavBarH : 0
        let titleH = titleHeight
        titleScrollView.frame = CGRectMake(0, y, DMWScreenWidth, titleH)
        self.view.addSubview(titleScrollView);
    }
    /**
     存放控制器的scrollView
     */
    private func setUpContentScrollView(){
        contentScrollView = UIScrollView()
        // frame
        var y = CGRectGetMaxY(titleScrollView.frame)
        if isfullScreen {
            y = 0
            contentScrollView.frame = CGRectMake(0, y, DMWScreenWidth, DMWScreenheight - y)
        }
        //再标标题栏下面
        self.view.insertSubview(contentScrollView, belowSubview: titleScrollView)
        contentScrollView.delegate = self
    }
    
    private func setUp() {
        
    }
    
    private func setUpTitleWidth() {
        let titles:[NSString] = (self.childViewControllers as NSArray).valueForKey("title") as! [NSString]
        
        var totlaWidth:CGFloat = 0.0
        titleWidths = [CGFloat]()
        // 计算宽度
        for title in titles{
            let titleBounds = title.boundingRectWithSize(
                CGSizeMake(1000.0, 0),
                options: NSStringDrawingOptions(rawValue:1 << 0),
                attributes: [NSFontAttributeName : DMWTitleFont],
                context: nil)

            let width = CGRectGetWidth(titleBounds)
            titleWidths.append(width)
            totlaWidth += width
        }
        
//        if totlaWidth > DMWScreenWidth {
//            titleMargin = DMWMargin
//            return
//        }
//        
//        let margin = (DMWScreenWidth - totlaWidth)/CGFloat((count - 1))
//        titleMargin = margin < DMWMargin ? margin : DMWMargin
    }
    private func setUpAllTitle() {
        // 计算frame
        var x:CGFloat = 0.0
        let y:CGFloat = 0.0
        var w:CGFloat = 0.0
        let h:CGFloat = titleHeight
        
        var lastLabel:UILabel!
        
        for (index,value) in self.childViewControllers.enumerate() {
            
            let label = UILabel()
            label.tag = index
            label.font = titleFont
            label.textColor = titleNorColor
            label.text = value.title
            
            w = titleWidths[index]
            x = lastLabel != nil ? CGRectGetMaxX(lastLabel.frame) + titleMargin : titleMargin
            label.frame = CGRectMake(x, y, w, h)
            lastLabel = label
            titleLabels.append(label)
            titleScrollView.addSubview(label)
            
            let tap = UITapGestureRecognizer.init(target: self, action: "titleClick:")
            label.userInteractionEnabled = true
            label.addGestureRecognizer(tap)
            if index == 0 {
                titleClick(tap)
            }
        }
        
        titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame) + 20.0, 0);
        titleScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.contentSize = CGSizeMake(CGFloat(titleLabels.count) * DMWScreenWidth, 0)
    }
    /// 
    @objc private func titleClick(tap:UITapGestureRecognizer) {
        // 处理label的文字颜色和位置
        let label = tap.view as! UILabel
        let index = label.tag
        // 改变字体样式
        selectLabelIndex(index)
        // 处理标题的位置
        handleTitleLabelPosition(index)

        // 如果没有添加过VC.view
        setUpvcWithIndex(index)
        // 移动contentScrollView
        contentScrollView.contentOffset = CGPointMake(
            CGFloat(index) * CGRectGetWidth(contentScrollView.bounds), 0
        )
    }
    private func selectLabelIndex(index: Int) {
        let lastIndex = lastSelectIndex
        lastSelectIndex = index
        // 上次选择的
        var lastLabel = titleLabels[lastIndex]
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            lastLabel.transform = CGAffineTransformIdentity
            },completion: nil
        )
        lastLabel.textColor = titleNorColor
        
        // 当前选中的
        lastLabel = titleLabels[index];
        if isTitleScale {
            let scale = titleScale ?? DMWTitleScale
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                lastLabel.transform = CGAffineTransformMakeScale(scale, scale)
            },completion: nil
            )
        }
        lastLabel.textColor = titleSelColor
    }
    private func handleTitleLabelPosition(index: Int){
        /// 计算出当前lable相对于中心点的距离
        var offsetX: CGFloat = titleLabels[index].center.x - DMWScreenWidth * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        /// 计算出内容宽度和屏幕宽度的距离
        var maxOffsetX = titleScrollView.contentSize.width - DMWScreenWidth
        if maxOffsetX < 0 {
            maxOffsetX = 0
        }
        
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        
        titleScrollView .setContentOffset(CGPointMake(offsetX, 0), animated: true)
    }
    
    private func setUpvcWithIndex(index: Int) {
        let vc = self.childViewControllers[index]
        if vc.viewIfLoaded == nil {
            vc.view.frame = CGRectMake(CGRectGetWidth(contentScrollView.bounds) * CGFloat(index), 0, CGRectGetWidth(contentScrollView.bounds), CGRectGetHeight(contentScrollView.bounds))
            contentScrollView.addSubview(vc.view)
        }
    }
    
    /// scrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds))
        let label = titleLabels[index]
        titleClick(label.gestureRecognizers?.first as! UITapGestureRecognizer)
    }
}
