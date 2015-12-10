//
//  DMWDisplayConst.swift
//  DMWMutableViewController
//
//  Created by WangZHW on 15/12/9.
//  Copyright © 2015年 XYLXI. All rights reserved.
//

import UIKit


public let DMWNavBarH: CGFloat = 64

/// 标题栏高度
public let DMWTitleScrollViewH:CGFloat = 44
/// 标题默认字体
public let DMWTitleFont = {
    return UIFont.systemFontOfSize(15)
}()
/// 标题间距
public let DMWMargin: CGFloat = 20
/// 字体缩放大小
public let DMWTitleScale: CGFloat = 1.3

/// 屏幕宽度
public let DMWScreenWidth = {
   return UIScreen.mainScreen().bounds.size.width
}()
/// 屏幕高度
public let DMWScreenheight = {
    return UIScreen.mainScreen().bounds.size.height
}()


