//
//  YHSegmentedSlideSwitch.h
//  YH_project
//
//  Created by Angzeng on 2018/7/10.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHSlideSwitchDelegate <NSObject>

- (void)slideSwitchDidselectAtIndex:(NSInteger)index;

@end


@interface YHSegmentedSlideSwitch : UIView
/**
 * 需要显示的视图
 */
@property (nonatomic, strong) NSArray *viewControllers;
/**
 * 标题
 */
@property (nonatomic, strong) NSArray *titles;
/**
 * 选中位置
 */
@property (nonatomic, assign) NSInteger selectedIndex;
/**
 * Segmented高亮颜色
 */
@property (nonatomic, strong) UIColor *tintColor;
/**
 * segment水平缩进
 */
@property (nonatomic, assign) NSInteger horizontalInset;

/**
 代理方法
 */
@property (nonatomic, weak) id <YHSlideSwitchDelegate>delegate;
/**
 * 初始化方法
 */
-(instancetype)initWithFrame:(CGRect)frame Titles:(NSArray <NSString *>*)titles viewControllers:(NSArray <UIViewController *>*)viewControllers;
/**
 * 标题显示在ViewController中
 */
-(void)showInViewController:(UIViewController *)viewController;
/**
 * 标题显示在NavigationBar中
 */
-(void)showInNavigationController:(UINavigationController *)navigationController;
@end
