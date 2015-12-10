//
//  UIView+DMW_Extension.swift
//  DMWMutableViewController
//
//  Created by WangZHW on 15/12/9.
//  Copyright © 2015年 XYLXI. All rights reserved.
//

import UIKit


extension UIView{
    
    var dmw_x: CGFloat{
        get {
            return CGRectGetMinX(self.frame)
        }
        set{
            var frame         = self.frame
            frame.origin.x    = newValue
            self.frame        = frame
        }
    }

    var dmw_y: CGFloat{
        get {
            return CGRectGetMinY(self.frame)
        }
        set{
            var frame         = self.frame
            frame.origin.y    = newValue
            self.frame        = frame
        }
    }

    var dmw_width: CGFloat{
        get {
            return CGRectGetWidth(self.frame)
        }
        set{
            var frame         = self.frame
            frame.size.width  = newValue
            self.frame        = frame
        }
    }

    var dmw_height: CGFloat{
        get {
            return CGRectGetHeight(self.frame)
        }
        set{
            var frame         = self.frame
            frame.size.height = newValue
            self.frame        = frame
        }
    }

    var dmw_centerx: CGFloat{
        get{
            return self.center.x
        }
        set{
            var point         = self.center
            point.x           = newValue
            self.center       = point
        }
    }

    var dmw_centery: CGFloat{
        get{
            return self.center.y
        }
        set{
            var point         = self.center
            point.y           = newValue
            self.center       = point
        }
    }

}