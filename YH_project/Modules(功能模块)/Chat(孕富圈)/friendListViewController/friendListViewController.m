//
//  friendListViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/7/19.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "friendListViewController.h"
#import "YHRefreshNormalHeader.h"
#import "YHDataManager.h"
#import "URLMacros.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "YHUser.h"
#import "YHconversationTableViewCell.h"
#import "YHConversationViewController.h"
#import "friendListModel.h"

@interface friendListViewController ()

@property (nonatomic, strong)       NSMutableArray *cellsItems;
@property (nonatomic, readwrite)    NSInteger numberofsection;

@end

@implementation friendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setMJRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)setUI {
    _cellsItems = [[NSMutableArray alloc] init];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.userInteractionEnabled = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    CGRect frame = self.tableView.bounds;
    frame.size.height -= YHTableLackHeight;
    self.tableView.frame = frame;
}

- (void)getFriendListData {
    NSDictionary *parameters = @{@"uid":[YHUser shareInstance].userId};
    [[YHDataManager manager] postDataWithUrl:YHurl_friendList Parameters:parameters Block:^(id dict) {
        if ([dict[@"code"] isEqual:@200]) {
            for (int i = 0; i < sizeof(dict[@"data"]); i++) {
                NSLog(@"%@",dict[@"data"][i]);
                friendListModel *friendModel = [[friendListModel alloc] init];
                friendModel.uid = dict[@"data"][i][@"uid"];
                friendModel.uname = dict[@"data"][i][@"uname"];
                friendModel.avatar = dict[@"data"][i][@"avatar"];
                //NSLog(@"%@",friendModel);
                //NSLog(@"%@",);
            }
            self->_cellsItems = [dict objectForKey:@"data"];
            self->_numberofsection = [dict[@"data"] count];
            [self.tableView reloadData];
        }else {
            NSLog(@"请求失败");
        }
    }];
}

- (void)setMJRefresh {
    __weak typeof(self) weakSelf = self;
    YHRefreshNormalHeader *header = [YHRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getFriendListData];
        [weakSelf endRefresh];
    }];
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}

- (void)endRefresh{
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark scrollDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //self.tableView.contentSize = CGSizeMake(0,206*YHpx);
    [self.delegate ViewdidScroll];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _numberofsection;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHconversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendListCellId"];
    if (cell == nil) {
        cell = [[YHconversationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"friendListCellId"];
        [cell setUI];
        [self setTouchForCell:cell];
    }
    if (_cellsItems) {
        [cell setCellUIWithImageUrl:[[_cellsItems objectAtIndex:indexPath.row] objectForKey:@"avatar"] Name:[[_cellsItems objectAtIndex:indexPath.row] objectForKey:@"uname"] Id:[[_cellsItems objectAtIndex:indexPath.row] objectForKey:@"uid"] Type:1];
    }
    return cell;
}

- (void)setTouchForCell:(YHconversationTableViewCell *)cell {
    UITapGestureRecognizer *touchGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(conversationAction:)];
    [cell addGestureRecognizer:touchGesture];
}

- (void)conversationAction:(id)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    YHconversationTableViewCell *cell = (YHconversationTableViewCell *)tap.view;
    NSDictionary *data = @{@"conversationType":@1,@"conversationTargetId":cell.cellId,@"conversationTitle":cell.cellName};
    if (_conversationBlock) {
        _conversationBlock(data);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
