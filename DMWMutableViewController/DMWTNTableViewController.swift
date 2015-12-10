//
//  DMWTNTableViewController.swift
//  DMWMutableViewController
//
//  Created by WangZHW on 15/12/10.
//  Copyright © 2015年 XYLXI. All rights reserved.
//

import UIKit

class DMWTNTableViewController: UITableViewController {

    let colors = [
        UIColor.redColor(),
        UIColor.grayColor(),
        UIColor.greenColor(),
        UIColor.blueColor()
    ];
    
    private lazy var indictorLabe:UILabel = {
        let lable = UILabel(frame: CGRectMake(-50,0,50,20))
        lable.backgroundColor = UIColor.orangeColor()
        return lable
    }()
    var scrollIndicator:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
    
        
        if self.navigationController != nil {
            tableView.contentInset = UIEdgeInsetsMake(DMWNavBarH + 44, 0, 0, 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "reuseIdentifier")
        }
        cell?.contentView.backgroundColor = colors[indexPath.row % 4]
        cell?.textLabel?.text = "\(self.title ?? "tableViewVC")->\(indexPath.row)"
        return cell!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.navigationController?.pushViewController(
            UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChildVC"),
            animated: true
        )
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        var point = CGPointZero;
        if let iView = scrollIndicator{
            point = iView.center
        }
        if let indexPath = tableView .indexPathForRowAtPoint(point) {
            indictorLabe.text = "\(indexPath.row)  "
        }
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollIndicator = scrollView.valueForKey("verticalScrollIndicator") as? UIView
        var point = indictorLabe.center
        point.y = CGRectGetHeight(scrollIndicator!.bounds) * 0.5
        indictorLabe.center = point
        scrollIndicator!.addSubview(indictorLabe)
    }
    
}
