//
//  messageListViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/7/19.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "messageListViewController.h"
#import "YHRefreshNormalHeader.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"

@interface messageListViewController()

@end

@implementation messageListViewController

- (id)init {
    self = [super init];
    if (self) {
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP)]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setMJRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)setUI {
    self.conversationListTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.conversationListTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YHScreenWidth, YHScreenHeight)];
    emptyView.backgroundColor = YHColor_LightGray;
    UILabel *NoMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(YHScreenWidth/2-100, YHScreenHeight/2-80, 200, 30)];
    NoMessageLabel.text = @"无信息,请下拉刷新。";
    NoMessageLabel.textAlignment = NSTextAlignmentCenter;
    NoMessageLabel.font = [UIFont fontWithName:YHFont size:16*FontPx];
    [emptyView addSubview:NoMessageLabel];
    //
    self.emptyConversationView = emptyView;
    //
    self.isShowNetworkIndicatorView = NO;
    //
    self.conversationListTableView.userInteractionEnabled = YES;
    self.conversationListTableView.showsHorizontalScrollIndicator = NO;
    self.conversationListTableView.showsVerticalScrollIndicator = NO;
    //
    CGRect frame = self.view.bounds;
    frame.size.height -= YHTableLackHeight;
    self.conversationListTableView.frame = frame;
}

- (void)setMJRefresh {
    __weak typeof(self) weakSelf = self;
    YHRefreshNormalHeader *header = [YHRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf refreshConversationTableViewIfNeeded];
            [weakSelf endRefresh];
        });
    }];
    self.conversationListTableView.mj_header = header;
    [self.conversationListTableView.mj_header beginRefreshing];
}

- (void)endRefresh{
    if ([self.conversationListTableView.mj_header isRefreshing]) {
        [self.conversationListTableView.mj_header endRefreshing];
    }
}

#pragma mark scrollDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //self.conversationListTableView.contentSize = CGSizeMake(0, 1.2*YHScreenHeight);
    [self.delegate ViewdidScroll];
}

#pragma mark RCConversation Delegate

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath{
    if ([model.targetId isEqualToString:@"10000"]) {
        //
    }else {
        if (model.conversationType == 1) {
            NSDictionary *data = @{@"conversationType":@1,@"conversationTargetId":model.targetId,@"conversationTitle":model.conversationTitle};
            if (_conversationBlock) {
                _conversationBlock(data);
            }
        }else if (model.conversationType == 3) {
            NSDictionary *data = @{@"conversationType":@3,@"conversationTargetId":model.targetId,@"conversationTitle":model.conversationTitle};
            if (_gconversationBlock) {
                _gconversationBlock(data);
            }
        }
    }
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    //[self onRCIMReceiveMessage:notification.object left:notification.userInfo[@"left"]];
}

- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
//    if ([message.objectName isEqualToString:@"RC:ContactNtf"]) {
//        RCMessageContent *content = [[RCMessageContent alloc] init];
//        content = message.content;
//        RCContactNotificationMessage *addmessage = (RCContactNotificationMessage*)content;
//        YHnewId = addmessage.sourceUserId;
//        [self initarray:YHnewId];
//    }
}

- (void)initChacheArrayWithUserId:(NSString *)sourceUserId {
//    NSArray *temparry = [[NSArray alloc] init];
//    temparry = [defaultlist objectForKey:@"mujun"];
//    if (temparry[0] != nil) {
//        CellsourceUserId = [[NSMutableArray alloc] initWithArray:temparry];
//        for(int i=0;i<temparry.count;i++){
//            if(![temparry[i] isEqualToString:sourceUserId]){
//                [CellsourceUserId addObject:sourceUserId];
//                defaultlist = [NSUserDefaults standardUserDefaults];
//                [defaultlist setObject:CellsourceUserId  forKey:@"mujun"];
//                [defaultlist synchronize];
//            }
//        }
//    }else {
//        NSArray *defaultinit = [[NSArray alloc] initWithObjects:sourceUserId, nil];
//        defaultlist = [NSUserDefaults standardUserDefaults];
//        [defaultlist setObject:defaultinit  forKey:@"mujun"];
//        [defaultlist synchronize];
//    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCConversationModel *model = [self.conversationListDataSource objectAtIndex:indexPath.row];
    if([model.targetId isEqualToString:@"10000"]){
        return UITableViewCellEditingStyleNone;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}

#pragma mark - change cell font
- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    RCConversationModel *model = [self.conversationListDataSource objectAtIndex:indexPath.row];
    if(model.conversationModelType != RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION){
        RCConversationCell *RCcell = (RCConversationCell *)cell;
        RCcell.contentView.backgroundColor = YHColor_LightGray;
        RCcell.conversationTitle.font = [UIFont fontWithName:YHFont size:16*FontPx];
        RCcell.messageContentLabel.font = [UIFont fontWithName:YHPingFangFont size:12*FontPx];
        RCcell.messageCreatedTimeLabel.font = [UIFont fontWithName:YHPingFangFont size:12*FontPx];
        if ([model.targetId isEqualToString:@"10000"]) {
            RCcell.contentView.backgroundColor = YHColor_PureGray;
            RCcell.model.isTop = YES;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
