//
//  YHChatMainViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/5/14.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHChatMainViewController.h"
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
#import "YHProfileView.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"
#import "URLMacros.h"
#import "YHDataManager.h"
#import "YHUser.h"
#import "YHBasePopView.h"
#import "YHSegmentedSlideSwitch.h"
#import "messageListViewController.h"
#import "friendListViewController.h"
#import "groupListViewController.h"
#import "YHConversationViewController.h"
#import "YHGroupConversationViewController.h"

@interface YHChatMainViewController ()<YHSlideSwitchDelegate, RCIMUserInfoDataSource, RCIMGroupInfoDataSource, messageDelegate, FriendDelegate, GroupDelegate>{
    YHSegmentedSlideSwitch *_slideSwitch;
}

@property(nonatomic, strong) YHProfileView *ProfileView;
@property(nonatomic, strong) UIView *coverView;
@property(nonatomic, assign) Boolean isShow;
@property(nonatomic, strong) UIButton *backButton;
@property(nonatomic, strong) UIButton *showButton;
//计时器属性
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int timeCount;
@property (nonatomic, readwrite) Boolean isOnView;

@end

@implementation YHChatMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRongYunLogin];
    [self buildUI];
    [self setUI];
    [self initLeftMenu];
}

- (void)setRongYunLogin {
    NSDictionary *parameters = @{@"uid":[YHUser shareInstance].userId};
    [[YHDataManager manager] postDataWithUrl:YHurl_getToken Parameters:parameters Block:^(id dict) {
        if ([dict[@"code"] isEqual:@200]) {
            [self RongyunLoginConnectWithToken:dict[@"data"]];
        }
    }];
}

- (void)RongyunLoginConnectWithToken:(NSString *)token {
    [[RCIM sharedRCIM] initWithAppKey:@"c9kqb3rdcx94j"];
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        [[RCIM sharedRCIM] setGroupInfoDataSource:self];
        [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[YHUser shareInstance].userId name:[YHUser shareInstance].userName portrait:[NSString stringWithFormat:@"http://%@",[YHUser shareInstance].userAvater]];
        [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
        [RCIM sharedRCIM].enableMessageRecall = YES;
        [RCIM sharedRCIM].enableTypingStatus = YES;
        [self sendLoginMessage];
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token错误");
    }];
}

- (void)sendLoginMessage {
    RCContactNotificationMessage *textMessage = [[RCContactNotificationMessage alloc] init];
    textMessage.extra = @"0";
    [[RCIMClient sharedRCIMClient] sendMessage:ConversationType_PRIVATE targetId:@"10000" content:textMessage pushContent:@"login" success:^(long messageId) {
        NSLog(@"success == %ld",messageId);
    } error:^(RCErrorCode nErrorCode, long messageId) {
        NSLog(@"nErrorCode== %ld",messageId);
    }];
}

#pragma mark RongYunDelegate

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion{
    if ([userId isEqualToString:[YHUser shareInstance].userId]) {
        [self showViewInfo];
    }
    if ([userId isEqualToString:@"10000"]) {
        RCUserInfo *userInfo = [[RCUserInfo alloc] init];
        userInfo.userId = userId;
        userInfo.name = @"新消息";
        userInfo.portraitUri = [NSString stringWithFormat:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3141894857,4122422296&fm=117&gp=0.jpg"];
        return completion(userInfo);
    }else {
        NSDictionary *parameters = @{@"uid":userId};
        [[YHDataManager manager] postDataWithUrl:YHurl_getUserById Parameters:parameters Block:^(id dict) {
            if ([dict[@"code"] isEqual:@200]) {
                NSLog(@"%@",dict[@"data"]);
                RCUserInfo *userInfo = [[RCUserInfo alloc] init];
                userInfo.userId = userId;
                userInfo.name = dict[@"data"][@"uname"];
                userInfo.portraitUri = [NSString stringWithFormat:@"http://%@",dict[@"data"][@"avatar"]];
                return completion(userInfo);
            }else {
                NSLog(@"请求失败");
                return completion(nil);
            }
        }];
    }
    return completion(nil);
}

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion{
    NSDictionary *parameters = @{@"tid":groupId};
    [[YHDataManager manager] postDataWithUrl:YHurl_getTeamInfo Parameters:parameters Block:^(id dict) {
        if ([dict[@"code"] isEqual:@200]) {
            RCGroup *groupInfo = [[RCGroup alloc] init];
            groupInfo.groupId = groupId;
            groupInfo.groupName = dict[@"data"][0][@"tname"];
            groupInfo.portraitUri = [NSString stringWithFormat:@"http://%@",dict[@"data"][0][@"tavatar"]];
            return completion(groupInfo);
        }else {
            NSLog(@"请求失败");
            return completion(nil);
        }
    }];
    return completion(nil);
}

- (void)buildUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *viewControllers = [NSMutableArray new];
    NSArray *titles = @[@"消息",@"好友",@"群组"];
    for (int i = 0 ; i<titles.count; i++) {
        UIViewController *vc = [self viewControllerOfIndex:i];
        [viewControllers addObject:vc];
    }
    _slideSwitch = [[YHSegmentedSlideSwitch alloc] initWithFrame:CGRectMake(0, 0, YHScreenWidth, YHScreenHeight) Titles:titles viewControllers:viewControllers];
    _slideSwitch.delegate = self;
    _slideSwitch.tintColor = [UIColor whiteColor];
    [_slideSwitch showInNavigationController:self.navigationController];
}

- (void)PushToConversationViewControllerWithDic:(NSDictionary *)conversationData {
    NSLog(@"%@",conversationData);
    YHConversationViewController *conversationVC = [[YHConversationViewController alloc] init];
    conversationVC.conversationType = ConversationType_PRIVATE;
    conversationVC.targetId = [conversationData objectForKey:@"conversationTargetId"];
    conversationVC.title = [conversationData objectForKey:@"conversationTitle"];
    [self.navigationController pushViewController:conversationVC animated:YES];
}

- (void)PushToGroupConversationViewControllerWithDic:(NSDictionary *)gconversationData {
    YHGroupConversationViewController *gconversationVC = [[YHGroupConversationViewController alloc] init];
    gconversationVC.conversationType = ConversationType_GROUP;
    gconversationVC.targetId = [gconversationData objectForKey:@"conversationTargetId"];
    gconversationVC.title = [gconversationData objectForKey:@"conversationTitle"];
    [self.navigationController pushViewController:gconversationVC animated:YES];
}

#pragma mark Group Delegate
- (void)GroupConversationWithDic:(NSDictionary *)gconversationData {
    [self PushToGroupConversationViewControllerWithDic:gconversationData];
}

#pragma mark SlideSwitchDelegate
- (void)slideSwitchDidselectAtIndex:(NSInteger)index {
    //NSLog(@"切换到了第%ld个视图",(long)index);
}

#pragma mark scroll Delegate
- (void)ViewdidScroll {
    [self DismissTabSubView];
}

#pragma mark 自定义方法
- (id)viewControllerOfIndex:(NSInteger)index {
    if (index == 0) {
        messageListViewController *vc = [[messageListViewController alloc] init];
        vc.delegate = self;
        vc.conversationBlock = ^(NSDictionary *conversationData) {
            [self PushToConversationViewControllerWithDic:conversationData];
        };
        vc.gconversationBlock = ^(NSDictionary *gconversationData) {
            [self PushToGroupConversationViewControllerWithDic:gconversationData];
        };
        return vc;
    }else if(index == 1){
        friendListViewController *vc1 = [[friendListViewController alloc] init];
        vc1.delegate = self;
        vc1.conversationBlock = ^(NSDictionary *conversationData) {
            [self PushToConversationViewControllerWithDic:conversationData];
        };
        return vc1;
    }else {
        groupListViewController *vc2 = [[groupListViewController alloc] init];
        vc2.delegate = self;
        vc2.gconversationBlock = ^(NSDictionary *gconversationData) {
            [self PushToGroupConversationViewControllerWithDic:gconversationData];
        };
        return vc2;
    }
}

- (void)setUI {
    //
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    [leftbutton setTitle:@"个人" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont fontWithName:YHFont size:18];
    [leftbutton addTarget:self action:@selector(pushSideView) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem=leftItem;
    //
    UIButton *rightbutton = [[UIButton alloc] initWithFrame:CGRectMake(YHScreenWidth-60, 0, 60, 20)];
    [rightbutton setTitle:@"孕富圈" forState:UIControlStateNormal];
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

//隐藏各副视图方法
- (void)DismissTabSubView {
    self.timeCount = 0;
    if (_isOnView) {
        [UIView animateWithDuration:0.5 animations:^{
            //self.tabBarController.tabBar.hidden = YES;
        }completion:^(BOOL finished){
            self->_isOnView = NO;
        }];
    }
}

//显示各副视图方法
- (void)ShowTabSubView {
    if (!_isOnView) {
        [UIView animateWithDuration:0.3 animations:^{
            //self.tabBarController.tabBar.hidden = NO;
        }completion:^(BOOL finished){
            self->_isOnView = YES;
        }];
    }
}

-(void)initLeftMenu{
    _isShow = NO;
    
    _ProfileView = [[YHProfileView alloc] initWithFrame:CGRectMake(-0.85*YHScreenWidth, 0, 0.85*YHScreenWidth, YHScreenHeight)];
    _coverView = [[UIView alloc] initWithFrame:CGRectMake(YHScreenWidth, 0, 0.15*YHScreenWidth, YHScreenHeight)];
    
    [self.view addSubview:_ProfileView];
    [self.view addSubview:_coverView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backClick)];
    [_coverView addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer *dismissProfile = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [dismissProfile setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_ProfileView addGestureRecognizer:dismissProfile];
}

#pragma mark Addition Action

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
        [self->_ProfileView setTransform:CGAffineTransformMakeTranslation(-0.85*YHScreenWidth, 0)];
        [self->_coverView setTransform:CGAffineTransformMakeTranslation(0.15*YHScreenWidth, 0)];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }completion:^(BOOL finished){
        [self->_ProfileView pullAvatarV];
        self.tabBarController.tabBar.hidden = NO;
    }];
    _isShow = NO;
}

- (void)backClick{
    if(_isShow == YES)
        [self performSelector:@selector(dismissSideView)];
}

- (void)showViewInfo {
    [YHBasePopView initIntroViewWithText:@"此页面是孕富圈页面，可以..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
