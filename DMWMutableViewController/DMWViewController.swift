//
//  DMWViewController.swift
//  DMWMutableViewController
//
//  Created by WangZHW on 15/12/10.
//  Copyright © 2015年 XYLXI. All rights reserved.
//

import UIKit

class DMWViewController: DMWMutViewController {

    override func viewDidLoad() {
        setUpAllViewController()
        titleScrollViewBacgroundColor = UIColor.grayColor()
        titleMargin = 25.0
        isfullScreen = true
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpAllViewController() {
        let titles = ["推荐","热点","北京","视频","订阅","社会","娱乐","汽车","体育","财经","军事","国际"]
        for title in titles {
            let vc = DMWTNTableViewController()
            vc.title = title
            self.addChildViewController(vc)
        }
    }
    
}
