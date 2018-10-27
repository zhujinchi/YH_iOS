//
//  YHTabbarView.h
//  YH_project
//
//  Created by Angzeng on 2018/6/11.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTopBar.h"

@interface YHTabbarView : UIView

@property (nonatomic,strong) YHTopBar *tabbar;

/**
 *  添加一个子控制器
 */
- (void)addSubItemWithViewController:(UIViewController *)viewController;

//选中新增的item
- (void)selectNewItem;

@end
