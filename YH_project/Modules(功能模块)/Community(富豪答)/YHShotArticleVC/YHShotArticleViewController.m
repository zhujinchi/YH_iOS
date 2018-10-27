//
//  YHShotArticleViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/7/16.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHShotArticleViewController.h"
#import "ShotArticleTableViewCell.h"
#import "YHTableView.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "YHRefreshNormalHeader.h"
#import "YHDataManager.h"
#import "URLMacros.h"
#import "YHShotArticleModel.h"
#import "UtilsMacros.h"

@interface YHShotArticleViewController ()<UITableViewDelegate, UITableViewDataSource, ShotViewDelegate>{
    YHTableView *tableView;
}

@property (readwrite) int count;
@property (readwrite) int page;
@property (nonatomic, strong) NSMutableArray *CellItems;

@end

@implementation YHShotArticleViewController

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
    _count = 0;
    _page = 0;
    _CellItems = [NSMutableArray array];
    [self setData];
}

- (void)setData {
    NSDictionary *parameters = @{@"type":@0,@"page":@0,@"pageSize":@30};
    [[YHDataManager manager] getDataWithUrl:YHurl_CelebrityArticle Parameters:parameters Block:^(id dict) {
        if ([dict[@"code"] isEqual:@200]) {
            NSArray *array = [NSArray arrayWithArray:dict[@"data"]];
            for (int i = 0; i < array.count; i++) {
                YHShotArticleModel *model = [[YHShotArticleModel alloc] init];
                [model setHoleDataWithDict:dict[@"data"][0]];
                [self->_CellItems insertObject:model atIndex:0];
            }
            NSLog(@"%@",self->_CellItems);
            self->_count += array.count;
            self->_page += 1;
            [self->tableView reloadData];
        }else {
            NSLog(@"请求失败");
        }
    }];
}

#pragma mark setMJRefresh

- (void)setMJRefresh {
    __weak typeof(self) weakSelf = self;
    YHRefreshNormalHeader *header = [YHRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf setData];
        [weakSelf endRefresh];
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
}

//指定特定分区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//指定表视图的分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ShotArticleTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[ShotArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [cell cellSetDataWithDict:self.CellItems[indexPath.section]];
    cell.delegate = self;
    return cell;
}

#pragma mark selectdelegate
- (void)ShotVSelectContent {
    [self.delegate ShotViewSelectedTable];
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
