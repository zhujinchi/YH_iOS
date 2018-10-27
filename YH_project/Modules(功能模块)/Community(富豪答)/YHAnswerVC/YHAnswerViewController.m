//
//  YHAnswerViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/7/16.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHAnswerViewController.h"
#import "AnswerTableViewCell.h"
#import "YHTableView.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "YHRefreshNormalHeader.h"

@interface YHAnswerViewController ()<UITableViewDelegate, UITableViewDataSource>{
    YHTableView *tableView;
}

@end

@implementation YHAnswerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUI];
    [self setBackTableView];
    [self setMJRefresh];
    
}

- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setBackTableView {
    tableView = [[YHTableView alloc] initWithFrame:CGRectMake(0, 0, YHScreenWidth, YHScreenHeight-YHTableLackHeight) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:tableView];
}

- (void)initData {
    [self setData];
}

- (void)setData {
//    NSDictionary *parameters = @{<#parameters#>};
//    [[YHDataManager manager] postDataWithUrl:<#url#> Parameters:parameters Block:^(id dict) {
//        if ([dict[@"code"] isEqual:@200]) {
//            <#yourcode#>
//        }else {
//            NSLog(@"请求失败");
//        }
//    }];
}

#pragma mark setMJRefresh

- (void)setMJRefresh {
    __weak typeof(self) weakSelf = self;
    YHRefreshNormalHeader *header = [YHRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf endRefresh];
        [self->tableView reloadData];
    }];
    tableView.mj_header = header;
}

- (void)endRefresh{
    if ([tableView.mj_header isRefreshing]) {
        [tableView.mj_header endRefreshing];
    }
}

#pragma mark TableViewDelegate&DataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YHScreenWidth, 50)];
    [view setBackgroundColor:YHColor_LightGray];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(YHScreenWidth/2-40, 28, 16, 16)];
    [img setImage:[UIImage imageNamed:@"@icon_logo"]];
    [view addSubview:img];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(YHScreenWidth/2-20, 20, 100, 30)];
    label.textColor = YHColor_DarkGray;
    label.backgroundColor = [UIColor clearColor];
    [label setFont:[UIFont fontWithName:YHFont size:13]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:label];
    return view;
}

//指定列表头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //return 50;
    return 0;
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    //return 44;
}

//指定特定分区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

//指定表视图的分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    AnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[AnswerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark scrolldelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.delegate ViewDidScroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
