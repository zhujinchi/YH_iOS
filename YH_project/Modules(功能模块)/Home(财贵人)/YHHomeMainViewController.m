//
//  YHHomeMainViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/5/14.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHHomeMainViewController.h"
#import "YHMatchViewController.h"
#import "YHUser.h"
#import "YHScrollView.h"
#import "YHPickModel.h"
#import "YHView.h"
#import "YHProfileView.h"
#import "YHModelView.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"
#import "YHAlertView.h"
#import "YHBasePopView.h"
#import "YHAdsView.h"
#import "MJRefresh.h"
#import "YHRefreshNormalHeader.h"
#import "URLMacros.h"
#import "YHDataManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface YHHomeMainViewController ()

@property (nonatomic, strong) YHScrollView *HomeMainScrollView;
@property (nonatomic, strong) YHModelView *ModelVTop;
@property (nonatomic, strong) YHProfileView *ProfileView;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) YHAdsView *AdsTopView;
@property (nonatomic, strong) UIView *AdsBottomView;
@property (nonatomic, assign) Boolean isShow;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *showButton;

@end

@implementation YHHomeMainViewController

#pragma mark Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLeftMenu];
    [self setMJRefresh];
    [self setUI];
    [self setData];
}

#pragma mark View Set

- (void)setUI {
    //
    _ModelVTop = [[YHModelView alloc] initWithFrame:CGRectMake(2*YHpx, 2*YHpx, 96*YHpx, 35*YHpx)];
    [_HomeMainScrollView addSubview:_ModelVTop];
    //
    YHPickModel *PickV = [[YHPickModel alloc] initWithFrame:CGRectMake(2*YHpx, 38*YHpx, 96*YHpx, 35*YHpx)];
    [_HomeMainScrollView addSubview:PickV];
    //
    [self setNavBar];
    [self setAds];
    [self setSlogan];
}

- (void)setNavBar {
    //
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    [leftbutton setTitle:@"个人" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont fontWithName:YHFont size:18];
    [leftbutton addTarget:self action:@selector(pushSideView) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem=leftItem;
    //
    UIButton *rightbutton = [[UIButton alloc] initWithFrame:CGRectMake(YHScreenWidth-60, 0, 60, 20)];
    [rightbutton setTitle:@"财贵人" forState:UIControlStateNormal];
    rightbutton.titleLabel.font = [UIFont fontWithName:YHFont size:18];
    [rightbutton addTarget:self action:@selector(showViewInfo) forControlEvents:UIControlEventTouchDown];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(-5, 8, 1, 20)];
    line.backgroundColor = YHColor_PureGray;
    [rightbutton addSubview:line];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setAds {
    YHAdsView *pagerView = [[YHAdsView alloc] initWithFrame:CGRectMake(2*YHpx, 74*YHpx, 96*YHpx, 60*YHpx)];
    pagerView.backgroundColor = YHColor_LightGray;
    pagerView.layer.cornerRadius = 1*YHpx;
    [_HomeMainScrollView addSubview:pagerView];
    _AdsTopView = pagerView;
    //
}

- (void)setSlogan {
    UIView *selfAdsView = [[UIView alloc] initWithFrame:CGRectMake(2*YHpx, 135*YHpx, 96*YHpx, 20*YHpx)];
    selfAdsView.backgroundColor = YHColor_LightGray;
    selfAdsView.layer.cornerRadius = 1*YHpx;
    UILabel *sloganLabel = [[UILabel alloc] initWithFrame:CGRectMake(8*YHpx, 3*YHpx, 80*YHpx, 14*YHpx)];
    sloganLabel.text = @"找对人，走对路，财务更自由。";
    sloganLabel.textColor = YHColor_Black;
    sloganLabel.font = [UIFont fontWithName:YHFont size:14*FontPx];
    sloganLabel.textAlignment = NSTextAlignmentCenter;
    [selfAdsView addSubview:sloganLabel];
    [_HomeMainScrollView addSubview:selfAdsView];
    _AdsBottomView = selfAdsView;
}

- (void)setData {
    [_ModelVTop.AvatarV.AvatarImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[YHUser shareInstance].userAvater]] placeholderImage:[UIImage imageNamed:@"imfomation_icon_default"]];
    NSDictionary *parameters = @{@"type":@"1",@"uid":[YHUser shareInstance].userId,@"muid":[YHUser shareInstance].userId};
    [[YHDataManager manager] postDataWithUrl:YHurl_feature Parameters:parameters Block:^(id dict) {
        if ([dict[@"code"] isEqual:@200]) {
            [self->_ModelVTop setDateForInfoViewWithDict:dict[@"data"]];//
        }else {
            NSLog(@"请求失败");
        }
    }];
}

- (void)setMJRefresh {
    __weak typeof(self) weakSelf = self;
    YHRefreshNormalHeader *header = [YHRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf setData];
        [weakSelf endRefresh];
    }];
    self.HomeMainScrollView.mj_header = header;
}

- (void)endRefresh{
    if ([self.HomeMainScrollView.mj_header isRefreshing]) {
        [self.HomeMainScrollView.mj_header endRefreshing];
    }
}

- (void)initLeftMenu{
    _isShow = NO;
    _HomeMainScrollView = [[YHScrollView alloc] initWithFrame:CGRectMake(0, 0, YHScreenWidth, YHScreenHeight-YHTableLackHeight)];
    _HomeMainScrollView.backgroundColor = [UIColor whiteColor];
    _HomeMainScrollView.contentSize = CGSizeMake(YHScreenWidth, 157*YHpx);/*有navigationbar提升后scrollView偏移64pt的bug*/
    _HomeMainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;/*修复偏移bug*/
    //
    _ProfileView = [[YHProfileView alloc]initWithFrame:CGRectMake(-0.85*YHScreenWidth, 0, 0.85*YHScreenWidth, YHScreenHeight)];
    _coverView = [[UIView alloc] initWithFrame:CGRectMake(YHScreenWidth, 0, 0.15*YHScreenWidth, YHScreenHeight)];
    //
    [self.view addSubview:_HomeMainScrollView];
    [self.view addSubview:_ProfileView];
    [self.view addSubview:_coverView];
    //
    _HomeMainScrollView.alwaysBounceVertical = YES;
    _HomeMainScrollView.userInteractionEnabled = YES;
    _HomeMainScrollView.showsHorizontalScrollIndicator = NO;
    _HomeMainScrollView.showsVerticalScrollIndicator = NO;
    //
    UITapGestureRecognizer *dismissGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backClick)];
    [_HomeMainScrollView addGestureRecognizer:dismissGesture];
    //
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backClick)];
    [_coverView addGestureRecognizer:tapGesture];
    //
    UISwipeGestureRecognizer *dismissProfile = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [dismissProfile setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_ProfileView addGestureRecognizer:dismissProfile];
}

- (void)pushSideView {
    [UIView animateWithDuration:0.5 animations:^{
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self->_ProfileView setTransform:CGAffineTransformMakeTranslation(0.85*YHScreenWidth, 0)];
        [self->_coverView setTransform:CGAffineTransformMakeTranslation(-0.15*YHScreenWidth, 0)];
    }completion:^(BOOL finished){
        [self->_ProfileView pushAvatarV];
    }];
    _isShow = YES;
}

- (void)dismissSideView {
    [UIView animateWithDuration:0.3 animations:^{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self->_ProfileView setTransform:CGAffineTransformMakeTranslation(-0.85*YHScreenWidth, 0)];
        [self->_coverView setTransform:CGAffineTransformMakeTranslation(0.15*YHScreenWidth, 0)];
    }completion:^(BOOL finished){
        [self->_ProfileView pullAvatarV];
        self.tabBarController.tabBar.hidden = NO;
    }];
    _isShow = NO;
}

- (void)backClick {
    if(_isShow == YES)
        [self performSelector:@selector(dismissSideView)];
}

- (void)showViewInfo {
    //[YHAlertView initAlertViewWithText:@"请检查网络连接" Second:2];
    [YHBasePopView initIntroViewWithText:@"此页面是财贵人页面，可以..."];
}

-(void)TraverseAllSubviews:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if (subView.subviews.count) {
            [self TraverseAllSubviews:subView];
        }
        NSLog(@"111%@",subView);
    }
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
