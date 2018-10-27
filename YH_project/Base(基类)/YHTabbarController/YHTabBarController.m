//
//  YHTabBarController.m
//  YH_project
//
//  Created by Angzeng on 2018/5/14.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHTabBarController.h"
#import "YHNavigationController.h"
#import "YHHomeMainViewController.h"
#import "YHArticleMainViewController.h"
#import "YHChatMainViewController.h"
#import "YHCommunityMainViewController.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "setViewManager.h"

@interface YHTabBarController ()

@end

@implementation YHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

//修改tabbar形状，悬浮框
- (void)viewWillLayoutSubviews{
//    if (IS_IPHONE_X) {
//        return;
//    }
//    CGRect tabFrame = self.tabBar.frame;
//    tabFrame.origin.x = 5;
//    tabFrame.origin.y = YHScreenHeight - 49 - (IS_IPHONE_X?44:10);
//    tabFrame.size.width = YHScreenWidth - 10;
//    tabFrame.size.height = 49;
//
//    self.tabBar.layer.cornerRadius = IS_IPHONE_X?0.02*YHScreenWidth:0.03*YHScreenWidth;
//    self.tabBar.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
//    //视图边界阴影
//    self.tabBar.layer.shadowOpacity = 0.3;
//    self.tabBar.layer.shadowColor = YHColor_Black.CGColor;
//    self.tabBar.layer.shadowRadius = 3;
//    self.tabBar.layer.shadowOffset = CGSizeMake(1, 1);
//    //
//    self.tabBar.frame = tabFrame;
    self.tabBar.backgroundColor = YHColor_WhiteGray;
}

- (void)setUI {
    self.view.backgroundColor = YHColor_LightGray;
    //tabbar分割线
    //[[UITabBar appearance] setShadowImage:[UIImage new]];
    //[[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    //[[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    //
    CGRect rect = CGRectMake(0, 0, YHScreenWidth, 0.1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[UIColor grayColor].CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[UITabBar appearance] setShadowImage:img];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    //设置tabbar子页面
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //set YHHomeMainView
    YHHomeMainViewController *YHHomeVC = [[YHHomeMainViewController alloc] init];
    YHNavigationController *YHHomeNavVC = [[YHNavigationController alloc] initWithRootViewController:YHHomeVC];
    [self setTabBarItem:YHHomeNavVC.tabBarItem Title:@"财贵人" withTitleSize:10 andFoneName:YHFont selectedImage:@"tabbar_Home_selected" withTitleColor:YHColor_ChineseRed unselectedImage:@"tabbar_Home" withTitleColor:[UIColor grayColor]];
    dict[NSForegroundColorAttributeName] = YHColor_tabBar_DarkRed;
    [YHHomeNavVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    //set YHArticleMainView
    YHArticleMainViewController *YHArticleVC = [[YHArticleMainViewController alloc] init];
    YHNavigationController *YHArticleNavVC = [[YHNavigationController alloc] initWithRootViewController:YHArticleVC];
    [self setTabBarItem:YHArticleNavVC.tabBarItem Title:@"贵人说" withTitleSize:10 andFoneName:YHFont selectedImage:@"tabbar_Article_selected" withTitleColor:YHColor_ChineseRed unselectedImage:@"tabbar_Article" withTitleColor:[UIColor grayColor]];
    dict[NSForegroundColorAttributeName] = YHColor_tabBar_DarkRed;
    [YHArticleNavVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    //set YHCommunityMainView
    YHCommunityMainViewController *YHCommunityVC = [[YHCommunityMainViewController alloc] init];
    YHNavigationController *YHCommunityNavVC = [[YHNavigationController alloc] initWithRootViewController:YHCommunityVC];
    [self setTabBarItem:YHCommunityNavVC.tabBarItem Title:@"富豪答" withTitleSize:10 andFoneName:YHFont selectedImage:@"tabbar_Community_selected" withTitleColor:YHColor_ChineseRed unselectedImage:@"tabbar_Community" withTitleColor:[UIColor grayColor]];
    dict[NSForegroundColorAttributeName] = YHColor_tabBar_DarkRed;
    [YHCommunityNavVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    //set YHChatMainView
    YHChatMainViewController *YHChatVC = [[YHChatMainViewController alloc] init];
    YHNavigationController *YHChatNavVC = [[YHNavigationController alloc] initWithRootViewController:YHChatVC];
    [self setTabBarItem:YHChatNavVC.tabBarItem Title:@"孕富圈" withTitleSize:10 andFoneName:YHFont selectedImage:@"tabbar_Chat_selected" withTitleColor:YHColor_ChineseRed unselectedImage:@"tabbar_Chat" withTitleColor:[UIColor grayColor]];
    dict[NSForegroundColorAttributeName] = YHColor_tabBar_DarkRed;
    [YHChatNavVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    //设置viewcontroller
    self.viewControllers = @[YHHomeNavVC, YHArticleNavVC, YHCommunityNavVC, YHChatNavVC];
}

- (void)setTabBarItem:(UITabBarItem *)tabbarItem Title:(NSString *)title withTitleSize:(CGFloat)size andFoneName:(NSString *)foneName selectedImage:(NSString *)selectedImage withTitleColor:(UIColor *)selectColor unselectedImage:(NSString *)unselectedImage withTitleColor:(UIColor *)unselectColor{
    //设置图片
    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateNormal];
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateSelected];
}

- (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
