//
//  YHCommunityMainViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/5/14.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHCommunityMainViewController.h"
#import "YHScrollView.h"
#import "YHProfileView.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"
#import "YHBasePopView.h"
#import "YHRefreshNormalHeader.h"
#import "YHSegmentedSlideSwitch.h"
#import "YHShotArticleViewController.h"
#import "YHAnswerViewController.h"
#import "YHArticleShowViewController.h"
#import "PresentTransitionAnimated.h"
#import "DismissTransitionAnimated.h"
#import "YHArticleViewController.h"


@interface YHCommunityMainViewController ()<YHSlideSwitchDelegate, YHShotArticleScrollDelegate, YHAnswerScrollDelegate, UIViewControllerTransitioningDelegate>{
    YHSegmentedSlideSwitch *_slideSwitch;
}

@property (nonatomic, strong) UIView *oneView;
@property (nonatomic, strong) YHShotArticleViewController *articleVC;
@property (nonatomic, strong) UIViewController *answerVC;
@property (nonatomic, strong) YHProfileView *ProfileView;
@property (nonatomic, strong) UISegmentedControl *segmentC;
@property (nonatomic, assign) Boolean isShow;
@property (nonatomic, assign) Boolean isSubShow;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *showButton;
@property (nonatomic, assign) Boolean isArticle;
@property (nonatomic, strong) YHArticleViewController *upArticleVC;
//计时器属性
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int timeCount;
//
@property (retain, nonatomic) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation YHCommunityMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
    [self setUI];
    [self initLeftMenu];
}

- (void)buildUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *viewControllers = [NSMutableArray new];
    NSArray *titles = @[@"文章",@"问答"];
    for (int i = 0 ; i<titles.count; i++) {
        UIViewController *vc = [self viewControllerOfIndex:i];
        [viewControllers addObject:vc];
    }
    _slideSwitch = [[YHSegmentedSlideSwitch alloc] initWithFrame:CGRectMake(0, 0, YHScreenWidth, YHScreenHeight) Titles:titles viewControllers:viewControllers];
    _slideSwitch.delegate = self;
    _slideSwitch.tintColor = [UIColor whiteColor];
    [_slideSwitch showInNavigationController:self.navigationController];
}


#pragma mark SlideSwitchDelegate
- (void)slideSwitchDidselectAtIndex:(NSInteger)index {
    NSLog(@"切换到了第%ld个视图",(long)index);
}

#pragma mark 自定义方法
- (id)viewControllerOfIndex:(NSInteger)index {
    if (index == 0) {
        YHShotArticleViewController *vc = [[YHShotArticleViewController alloc] init];
        vc.delegate = self;
        return vc;
    }else {
        YHAnswerViewController *vc1 = [[YHAnswerViewController alloc] init];
        vc1.delegate = self;
        return vc1;
    }
}

- (void)setUI {
    //
    UIButton *leftbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    [leftbutton setTitle:@"个人" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont fontWithName:YHFont size:18];
    [leftbutton addTarget:self action:@selector(pushSideView) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = leftItem;
    //
    UIButton *rightbutton = [[UIButton alloc] initWithFrame:CGRectMake(YHScreenWidth-60, 0, 60, 20)];
    [rightbutton setTitle:@"富豪答" forState:UIControlStateNormal];
    rightbutton.titleLabel.font = [UIFont fontWithName:YHFont size:18];
    [rightbutton addTarget:self action:@selector(showViewInfo) forControlEvents:UIControlEventTouchDown];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(-5, 8, 1, 20)];
    line.backgroundColor = YHColor_PureGray;
    [rightbutton addSubview:line];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightItem;
    //设置页面计时器
    _isSubShow = YES;
//    if (self.timer) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//    self.timeCount = 0;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(repeatCountTime:) userInfo:@"admin" repeats:YES];
}

- (void)repeatCountTime:(NSTimer *)tempTimer {
    self.timeCount++;
    if (self.timeCount >= 1 && _isShow == NO) {
        [self ShowTabSubView];
    }
}

- (void)initLeftMenu{
    _isShow = NO;
    _ProfileView=[[YHProfileView alloc]initWithFrame:CGRectMake(-0.85*YHScreenWidth, 0, 0.85*YHScreenWidth, YHScreenHeight)];
    [self.view addSubview:_ProfileView];
    
    UISwipeGestureRecognizer *dismissProfile = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [dismissProfile setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_ProfileView addGestureRecognizer:dismissProfile];
}

#pragma mark scrolldelegate

- (void)ViewDidScroll {
    [self DismissTabSubView];
    [self backClick];
}

- (void)ShotViewSelectedTable {
    if (!_isShow) {
        _upArticleVC = [[YHArticleViewController alloc] init];
        _upArticleVC.transitioningDelegate = self;
        _upArticleVC.view.backgroundColor = [UIColor redColor];
        [self addScreenLeftEdgePanGestureRecognizer:_upArticleVC.view];
        [self presentViewController:_upArticleVC animated:YES completion:nil];
    }else {
        [self dismissSideView];
    }
}

//隐藏各副视图方法
- (void)DismissTabSubView {
    self.timeCount = 0;
    if (_isSubShow) {
        [UIView animateWithDuration:0.5 animations:^{
            //self.tabBarController.tabBar.hidden = YES;
        }completion:^(BOOL finished){
            self->_isSubShow = NO;
        }];
    }
}

//显示各副视图方法
- (void)ShowTabSubView {
    if (!_isSubShow) {
        [UIView animateWithDuration:0.3 animations:^{
            //self.tabBarController.tabBar.hidden = NO;
        }completion:^(BOOL finished){
            self->_isSubShow = YES;
        }];
    }
}

#pragma mark sideViewMethod

- (void)pushSideView {
    if (!_isShow) {
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBarController.tabBar.hidden = YES;
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            [self->_ProfileView setTransform:CGAffineTransformMakeTranslation(0.85*YHScreenWidth, 0)];
        }completion:^(BOOL finished){
            [self->_ProfileView pushAvatarV];
        }];
        _isShow = YES;
    }
}

- (void)dismissSideView {
    if (_isShow) {
        [UIView animateWithDuration:0.3 animations:^{
            [self->_ProfileView setTransform:CGAffineTransformMakeTranslation(-0.85*YHScreenWidth, 0)];
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }completion:^(BOOL finished){
            [self->_ProfileView pullAvatarV];
            self.tabBarController.tabBar.hidden = NO;
        }];
        _isShow = NO;
    }
}

-(void)backClick{
    [self performSelector:@selector(dismissSideView)];
}

#pragma mark showInfo

- (void)showViewInfo {
    [YHBasePopView initIntroViewWithText:@"此页面是富豪答页面，可以..."];
}

#pragma mark 自定义转场动画
- (void)addScreenLeftEdgePanGestureRecognizer:(UIView *)view{
    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    screenEdgePan.edges = UIRectEdgeLeft;
    [view addGestureRecognizer:screenEdgePan];
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePan{
    CGFloat progress = fabs([edgePan translationInView:[UIApplication sharedApplication].keyWindow].x/[UIApplication sharedApplication].keyWindow.bounds.size.width);
    if (edgePan.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        if (edgePan.edges == UIRectEdgeLeft) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else if (edgePan.state == UIGestureRecognizerStateChanged){
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if (edgePan.state == UIGestureRecognizerStateEnded || edgePan.state == UIGestureRecognizerStateCancelled){
        if (progress > 0.5) {
            [_percentDrivenTransition finishInteractiveTransition];
        }else{
            [_percentDrivenTransition cancelInteractiveTransition];
        }
        _percentDrivenTransition = nil;
    }
}

#pragma Mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[PresentTransitionAnimated alloc] init];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DismissTransitionAnimated alloc] init];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _percentDrivenTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _percentDrivenTransition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
