//
//  UtilsMacros.h
//  YH_project
//  定义工具宏
//  Created by Angzeng on 2018/5/14.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

//判断手机型号
#define IS_IPHONE                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X                 (IS_IPHONE && YHScreenHeight == 812.0f)
#define IS_IPHONE_6                 (IS_IPHONE && YHScreenHeight == 667.0f)
#define IS_IPHONE_6P                (IS_IPHONE && YHScreenHeight == 736.0f)
#define IS_IPHONE_5                 (IS_IPHONE && YHScreenHeight == 568.0f)
#define IS_IPHONE_4                 (IS_IPHONE && YHScreenHeight == 480.0f)
#define IS_LITTLE                   (IS_IPHONE && (IS_IPHONE_4 || IS_IPHONE_5))
//基础单位
#define YHpx                        0.01*[[UIScreen mainScreen] bounds].size.width
#define FontPx                      0.3125*YHpx
//屏幕尺寸
#define YHScreenWidth               [[UIScreen mainScreen] bounds].size.width
#define YHScreenHeight              [[UIScreen mainScreen] bounds].size.height
//定义居中时左初始位置
#define YHLeftPoint(w)              [[UIScreen mainScreen] bounds].size.width/2-w/2
//状态栏高度
#define YHStatusRectHeight          [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define YHNavigationRectHeight      44
//状态栏和导航栏高度
#define YHTopHeight                 YHNavigationRectHeight+YHStatusRectHeight
//Tableview向下空缺距离
#define YHTableLackHeight           (IS_IPHONE_X?172:114)

//基础图标尺寸
#define YHIcontx                     0.06*[[UIScreen mainScreen] bounds].size.height

#endif /* UtilsMacros_h */


