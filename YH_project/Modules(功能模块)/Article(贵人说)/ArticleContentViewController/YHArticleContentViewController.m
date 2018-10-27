//
//  YHArticleContentViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/6/11.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHArticleContentViewController.h"
#import "YHTableView.h"
#import "YHTableViewCell.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"
#import "URLMacros.h"
#import "YHUser.h"
#import "YHDataManager.h"
#import "YHRefreshNormalHeader.h"
#import "YHArticleModel.h"

@interface YHArticleContentViewController ()<UITableViewDelegate, UITableViewDataSource, YHSelectContentDelegate>
{
    YHTableView *tableView;
}

@property (readwrite) int count;
@property (readwrite) int page;
@property (nonatomic, strong) NSMutableArray *CellItems;
@property (nonatomic, strong) UIView *readHeader;
@property (nonatomic, strong) NSIndexPath *headIndex;

@end

@implementation YHArticleContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUI];
    [self setModel];
    [self setBackTableView];
    [self setMJRefresh];
    //[tableView.mj_header beginRefreshing];
}


-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = self.view.bounds;
    frame.size.height -= IS_IPHONE_X?113:64;
    tableView.frame = frame;
}

- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _readHeader = [[UIView alloc] initWithFrame:CGRectMake(58*YHpx, -2*YHpx, 44*YHpx, 12*YHpx)];
    //_readHeader.layer.cornerRadius = 2*YHpx;
    _readHeader.backgroundColor = [UIColor clearColor];
    UILabel *readLabel = [[UILabel alloc] initWithFrame:CGRectMake(1*YHpx, 2*YHpx, 40*YHpx, 8*YHpx)];
    readLabel.text = @"刚刚读到这里，点击刷新";
    readLabel.backgroundColor = [UIColor colorWithRed:52/255.0 green:53/255.0 blue:44/255.0 alpha:0.8];;
    readLabel.layer.cornerRadius = 2*YHpx;
    readLabel.clipsToBounds = YES;
    readLabel.textAlignment = NSTextAlignmentCenter;
    readLabel.textColor = YHColor_DarkGray;
    readLabel.font = [UIFont fontWithName:YHFont size:10*FontPx];
    [_readHeader addSubview:readLabel];
    UITapGestureRecognizer *clickAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(freshAction)];
    [_readHeader addGestureRecognizer:clickAction];
}

- (void)freshAction {
    [tableView.mj_header beginRefreshing];
}

- (void)setModel {
    self.articleModel = [[YHArticleModel alloc] init];
}

- (void)setBackTableView {
    tableView = [[YHTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(52, 0, 0, 0);
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (void)initData {
    _count = 0;
    _page = 0;
    _CellItems = [NSMutableArray array];
    [self setData];
}

#pragma mark setMJRefresh

- (void)setMJRefresh {
    __weak typeof(self) weakSelf = self;
    YHRefreshNormalHeader *header = [YHRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf addReadHeadInCell];
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

- (void)setData {
    NSDictionary *parameters = @{@"type":@(self.articleType),@"page":@(self.page),@"pageSize":@"5",@"uid":[YHUser shareInstance].userId};
    [[YHDataManager manager] postDataWithUrl:YHurl_article Parameters:parameters Block:^(id dict) {
        if ([dict[@"code"] isEqual:@200]) {
            for (int i = 0; i < sizeof(dict[@"data"]); i++) {
                NSLog(@"%@",dict[@"data"][i][@"title"]);
                YHArticleModel *model = [[YHArticleModel alloc] init];
                [model setHoleDataWithDict:dict[@"data"][i]];
                [self->_CellItems insertObject:model atIndex:0];
            }
            self->_count += sizeof(dict[@"data"]);
            self->_page += 1;
            [self->tableView reloadData];
        }else {
            NSLog(@"请求失败");
        }
    }];
}

- (void)addReadHeadInCell {
    [_readHeader removeFromSuperview];
    //NSIndexPath *judgePath = [[NSIndexPath alloc] initWithIndexes:0 length:2];
    //NSArray * array = [tableView cellForRowAtIndexPath:judgePath];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:_headIndex];
    //[cell addSubview:_readHeader];
    //[array[0] addSubview:_readHeader];
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
    if ((int)(long)indexPath.section == 0) {
        _headIndex = indexPath;
    }
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
    YHTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];;
    if (cell == nil) {
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[YHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [cell cellSetDataWithDict:self.CellItems[indexPath.section]];
    cell.delegate = self;
    return cell;
}

#pragma mark selectdelegate
- (void)ViewSelectContentWithId:(NSString *)articleId {
    [self.delegate ViewSelectedTableWithId:(NSString *)articleId];
}

#pragma mark scrolldelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.delegate ViewDidScrollisDismiss:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
