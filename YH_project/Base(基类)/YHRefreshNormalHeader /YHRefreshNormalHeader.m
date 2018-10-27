//
//  YHRefreshNormalHeader.m
//  YH_project
//
//  Created by Angzeng on 2018/7/6.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHRefreshNormalHeader.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "setViewManager.h"

@implementation YHRefreshNormalHeader

/** 初始化设置 */
- (void)prepare
{
    [super prepare];
    //创建UIImageView
    UIImageView *logoView = [[UIImageView alloc] init];
    //添加图片
    logoView.image = [UIImage imageNamed:@"icon_logo"];
    logoView.layer.cornerRadius = 5;
    logoView.clipsToBounds = YES;
    //将该UIImageView添加到当前header中
    [self addSubview:logoView];
    self.logoView = logoView;
    //logoView设置阴影
    setViewManager *manager = [[setViewManager alloc] init];
    [manager setViewShadow:logoView];
    //
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    //根据拖拽的情况自动切换透明度
    self.automaticallyChangeAlpha = YES;
    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    //设置文字
    self.stateLabel.font = [UIFont fontWithName:YHFont size:14];
    self.stateLabel.textColor = YHColor_Black;
    
}
/**
 *  摆放子控件
 */

- (void)placeSubviews
{
    [super placeSubviews];
    CGRect frame = CGRectMake(50*YHpx+42, 16, 22, 22);
    self.logoView.frame = frame;
}

@end
