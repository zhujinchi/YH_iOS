//
//  YHArticleMainViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/5/14.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "YHArticleMainViewController.h"
#import "YHProfileView.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"
#import "YHArticleUploadViewController.h"
#import "YHBasePopView.h"
#import "setViewManager.h"
#import "YHTabbarView.h"
#import "YHArticleContentViewController.h"
#import "YHArticleViewController.h"
#import "YHArticleShowViewController.h"
#import "PresentTransitionAnimated.h"
#import "DismissTransitionAnimated.h"

@interface YHArticleMainViewController ()<YHDidScrollViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) YHProfileView *ProfileView;
@property (nonatomic, assign) Boolean isShow;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *showButton;
@property (nonatomic, strong) UIButton *addArticleButton;
@property (nonatomic, strong) YHArticleUploadViewController *uploadVC;
//
@property (nonatomic, strong) YHArticleViewController *upArticleVC;
@property (nonatomic, strong) YHArticleShowViewController *upArticleVC2;
//
@property (nonatomic, strong) UIView *slidebackView;
@property (nonatomic, strong) UIView *coverview;
@property (nonatomic, strong) setViewManager *ViewManager;
//
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) YHTabbarView *tabbarView;
//计时器属性
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int timeCount;
//push页面
@property (retain, nonatomic) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation YHArticleMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setTopTabBar];
    [self initLeftMenu];
    [self setUploadButton];
}

- (void)setUI {
    //
    _ViewManager = [[setViewManager alloc] init];
    //
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    [leftbutton setTitle:@"个人" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont fontWithName:YHFont size:18];
    [leftbutton addTarget:self action:@selector(pushSideView) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem=leftItem;
    //
    UIButton *rightbutton = [[UIButton alloc] initWithFrame:CGRectMake(YHScreenWidth-60, 0, 60, 20)];
    [rightbutton setTitle:@"贵人说" forState:UIControlStateNormal];
    rightbutton.titleLabel.font = [UIFont fontWithName:YHFont size:18];
    [rightbutton addTarget:self action:@selector(showViewInfo) forControlEvents:UIControlEventTouchDown];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(-5, 8, 1, 20)];
    line.backgroundColor = YHColor_PureGray;
    [rightbutton addSubview:line];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightItem;
    //设置页面计时器
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timeCount = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(repeatCountTime:) userInfo:@"admin" repeats:YES];
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
    //[self setSelectedView];
    //
    [self.view addSubview:_ProfileView];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backClick)];
    [self.view addGestureRecognizer:tapGesture1];
    
    UISwipeGestureRecognizer *dismissProfile = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [dismissProfile setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_ProfileView addGestureRecognizer:dismissProfile];
    //
}

- (void)setTopTabBar {
    [self.view addSubview:self.tabbarView];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.index = 0;
    
}

- (YHTabbarView *)tabbarView{
    
    if (!_tabbarView) {
        _tabbarView = ({
            
            YHTabbarView *tabbarV = [[YHTabbarView alloc]initWithFrame:CGRectMake(0, 0, YHScreenWidth, YHScreenHeight)];
            
            YHArticleContentViewController *vc0 = [[YHArticleContentViewController alloc]init];
            vc0.delegate = self;
            vc0.title = @"推荐";
            vc0.articleType = 0;
            [tabbarV addSubItemWithViewController:vc0];
            
            YHArticleContentViewController *vc1 = [[YHArticleContentViewController alloc]init];
            vc1.delegate = self;
            vc1.title = @"热门";
            vc1.articleType = 1;
            [tabbarV addSubItemWithViewController:vc1];
            
            YHArticleContentViewController *vc2 = [[YHArticleContentViewController alloc]init];
            vc2.delegate = self;
            vc2.title = @"关注";
            vc2.articleType = 2;
            [tabbarV addSubItemWithViewController:vc2];
            
            YHArticleContentViewController *vc3 = [[YHArticleContentViewController alloc]init];
            vc3.delegate = self;
            vc3.title = @"财经";
            vc3.articleType = 3;
            [tabbarV addSubItemWithViewController:vc3];
            
            YHArticleContentViewController *vc4 = [[YHArticleContentViewController alloc]init];
            vc4.delegate = self;
            vc4.title = @"财讯";
            vc4.articleType = 4;
            [tabbarV addSubItemWithViewController:vc4];
            
            YHArticleContentViewController *vc5 = [[YHArticleContentViewController alloc]init];
            vc5.delegate = self;
            vc5.title = @"财观";
            vc5.articleType = 5;
            [tabbarV addSubItemWithViewController:vc5];
            
            tabbarV;
        });
    }
    return _tabbarView;
}


#pragma mark scrolldelegate

//代理方法(上滑;下滑)
- (void)ViewDidScrollisDismiss:(BOOL)isDismiss {
    isDismiss?[self DismissTabSubView]:[self ShowTabSubView];
    [self backClick];
}

//隐藏各副视图方法
- (void)DismissTabSubView {
    self.timeCount = 0;
    if (_tabbarView.tabbar.isOnView) {
        [UIView animateWithDuration:0.5 animations:^{
            [self dismissUploadBtn];
            [self->_tabbarView.tabbar setTransform:CGAffineTransformMakeTranslation(0, -50)];
            //self.tabBarController.tabBar.hidden = YES;
        }completion:^(BOOL finished){
            self->_tabbarView.tabbar.isOnView = NO;
        }];
    }
}

//显示各副视图方法
- (void)ShowTabSubView {
    if (!_tabbarView.tabbar.isOnView) {
        [UIView animateWithDuration:0.3 animations:^{
            [self pushUploadBtn];
            //self.tabBarController.tabBar.hidden = NO;
            [self->_tabbarView.tabbar setTransform:CGAffineTransformMakeTranslation(0, 0)];
        }completion:^(BOOL finished){
            self->_tabbarView.tabbar.isOnView = YES;
        }];
    }
}

#pragma mark sideViewMethod

- (void)pushSideView {
    [self dismissUploadBtn];
    [UIView animateWithDuration:0.5 animations:^{
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self->_ProfileView setTransform:CGAffineTransformMakeTranslation(0.85*YHScreenWidth, 0)];
    }completion:^(BOOL finished){
        [self->_ProfileView pushAvatarV];
    }];
    _isShow = YES;
}

- (void)dismissSideView {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_ProfileView setTransform:CGAffineTransformMakeTranslation(-0.85*YHScreenWidth, 0)];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }completion:^(BOOL finished){
        [self->_ProfileView pullAvatarV];
        self.tabBarController.tabBar.hidden = NO;
        [self pushUploadBtn];
    }];
    _isShow = NO;
}

-(void)backClick{
    if(_isShow == YES)
        [self performSelector:@selector(dismissSideView)];
}

#pragma mark 上传文章动作集合

- (void)setUploadButton {
    _addArticleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addArticleButton setImage:[UIImage imageNamed:@"icon_font_write"] forState:UIControlStateNormal];
    _addArticleButton.frame = CGRectMake(0, 0, 40, 40);
    [_addArticleButton addTarget:self action:@selector(uploadClick) forControlEvents:UIControlEventTouchUpInside];
    _coverview= [[UIView alloc]initWithFrame:CGRectMake(YHScreenWidth-50,IS_IPHONE_X?YHScreenHeight-235 :YHScreenHeight-175, 40, 40)];
    _coverview.backgroundColor = YHColor_ChineseRed;
    _coverview.layer.cornerRadius = 20;
    _coverview.layer.masksToBounds = YES;
    //
    [_ViewManager setViewShadow:_addArticleButton];
    //
    [_coverview addSubview:_addArticleButton];
    
    [self.view addSubview:_coverview];
}

- (void)dismissUploadBtn {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_coverview setTransform:CGAffineTransformMakeTranslation(YHScreenWidth, 0)];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        //self.tabBarController.tabBar.hidden = NO;
    }completion:^(BOOL finished){
        //nil
    }];
}

- (void)pushUploadBtn {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_coverview setTransform:CGAffineTransformMakeTranslation(0, 0)];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        //self.tabBarController.tabBar.hidden = NO;
    }completion:^(BOOL finished){
        //nil
    }];
}

- (void)uploadClick {
    _uploadVC = [[YHArticleUploadViewController alloc] init];
    [self presentViewController:_uploadVC animated:YES completion:nil];
}

#pragma mark selectdelegate

- (void)ViewSelectedTableWithId:(NSString *)articleId {
    if (!_isShow) {
        _upArticleVC = [[YHArticleViewController alloc] init];
        _upArticleVC.transitioningDelegate = self;
        _upArticleVC.articleId = articleId;
        _upArticleVC.view.backgroundColor = [UIColor whiteColor];
        [self addScreenLeftEdgePanGestureRecognizer:_upArticleVC.view];
        [self presentViewController:_upArticleVC animated:YES completion:nil];
    }else {
        [self dismissSideView];
    }
}

- (void)showViewInfo {
    [YHBasePopView initIntroViewWithText:@"此页面是贵人说页面，可以..."];
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
