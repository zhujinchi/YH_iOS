//
//  YHTopBar.h
//  YH_project
//
//  Created by Angzeng on 2018/6/11.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YHScreenW [UIScreen mainScreen].bounds.size.width
#define YHScreenH [UIScreen mainScreen].bounds.size.height

@class YHTopBar;

@protocol YHTopBarDelegate <NSObject>

- (void)YHTopBarChangeSelectedItem:(YHTopBar *)topbar selectedIndex:(NSInteger)index;

@end

@interface YHTopBar : UIScrollView
/**
 *  lable目前是否在视图上
 */
@property (nonatomic, assign) BOOL isOnView;

@property (nonatomic,weak) id<YHTopBarDelegate> topBarDelegate;

- (void)addTitleBtn:(NSString *)title;
- (void)setSelectedItem:(NSInteger)index;



@end
