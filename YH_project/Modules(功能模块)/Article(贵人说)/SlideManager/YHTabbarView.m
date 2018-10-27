//
//  YHTabbarView.m
//  YH_project
//
//  Created by Angzeng on 2018/6/11.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHTabbarView.h"
#import "YHTabbarCollectionCell.h"

static CGFloat const topBarHeight = 35; //顶部标签条的高度

@interface YHTabbarView () <UICollectionViewDataSource,UICollectionViewDelegate,YHTopBarDelegate>

@property (nonatomic,strong) NSMutableArray *subViewControllers;
@property (nonatomic,strong) UICollectionView *contentView;
@property (nonatomic,assign) CGFloat tabbarWidth; //顶部标签条的宽度

@end

@implementation YHTabbarView

#pragma mark - 重写构造方法

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubview];
    }
    return self;
}

#pragma mark - UI处理
//添加子控件
- (void)setUpSubview{
    [self addSubview:self.contentView];
    self.tabbar = [[YHTopBar alloc] initWithFrame:CGRectMake(0, 0, YHScreenW, topBarHeight)];
    //self.tabbar.layer.cornerRadius = 5;
    [self addSubview:self.tabbar];
    self.tabbar.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    self.tabbar.topBarDelegate = self;
}

#pragma mark - 代理方法
//CollectionViewDataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.subViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YHTabbarCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YHTabbarCollectionCell" forIndexPath:indexPath];
    cell.subVc = self.subViewControllers[indexPath.row] ;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger index = (collectionView.contentOffset.x + collectionView.bounds.size.width * 0.5) / collectionView.bounds.size.width;
    [self.tabbar setSelectedItem:index];
}


//YHTopBarDelegate方法
- (void)YHTopBarChangeSelectedItem:(YHTopBar *)topbar selectedIndex:(NSInteger)index {
    
    self.contentView.contentOffset = CGPointMake(YHScreenW * index, 0);
}

#pragma mark - 对外接口
//外界传个控制器,添加一个栏目
- (void)addSubItemWithViewController:(UIViewController *)viewController{
    
    [self.tabbar addTitleBtn:viewController.title];
    [self.tabbar setSelectedItem:0];
    [self.subViewControllers addObject:viewController];
    [self.contentView reloadData];
}

- (void)selectNewItem{
    
    NSInteger index = self.subViewControllers.count - 1;
    self.contentView.contentOffset = CGPointMake(YHScreenW * (index - 1), 0);
    [self.contentView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

#pragma mark - 懒加载

- (NSMutableArray *)subViewControllers{
    
    if (!_subViewControllers) {
        _subViewControllers = [NSMutableArray array];
    }
    return _subViewControllers;
}

- (UICollectionView *)contentView {
    
    if (!_contentView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //设置layout 属性
        layout.itemSize = (CGSize){self.bounds.size.width,(self.bounds.size.height - topBarHeight)};
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        //mark
        _contentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, YHScreenW, YHScreenH - 64) collectionViewLayout:layout];
        
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.bounces = NO;
        _contentView.dataSource = self;
        _contentView.delegate = self;
        //注册cell
        [_contentView registerClass:[YHTabbarCollectionCell class] forCellWithReuseIdentifier:@"YHTabbarCollectionCell"];
    }
    return _contentView;
}
@end
