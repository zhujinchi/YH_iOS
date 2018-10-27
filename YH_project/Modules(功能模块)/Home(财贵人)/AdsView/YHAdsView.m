//
//  YHAdsView.m
//  YH_project
//
//  Created by Angzeng on 2018/7/4.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHAdsView.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"

@interface YHAdsView()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;


@end

@implementation YHAdsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self addPagerView];
    [self addPageControl];
    [self loadData];
}

- (void)addPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc] initWithFrame:CGRectMake(0, 0, 96*YHpx, 60*YHpx)];
    pagerView.backgroundColor = [UIColor clearColor];
    pagerView.dataSource = self;
    pagerView.delegate = self;
    pagerView.layer.borderWidth = 0;
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 100.0;
    //pagerView.layout.layoutType = TYCyclePagerTransformLayoutCoverflow;
    
    [self addSubview:pagerView];
    _pagerView = pagerView;
    [_pagerView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"AdsPagerView"];
}

- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc] initWithFrame:CGRectMake(48*YHpx, 56*YHpx, 0, 0)];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
    [pageControl addTarget:self action:@selector(pageControlValueChangeAction) forControlEvents:UIControlEventValueChanged];
    //[_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)pageControlValueChangeAction {
    
}

- (void)loadData {
    //_pageControl.numberOfPages = _datas.count;
    _pageControl.numberOfPages = 8;
    [_pagerView reloadData];
}

#pragma mark TYCyclePagerViewDataSource


- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return 1;
}

- (__kindof UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"AdsPagerView" forIndex:index];
    cell.backgroundColor = [UIColor grayColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [imgView setImage:[UIImage imageNamed:@"@TEST_ads"]];
    [cell.contentView addSubview:imgView];
    //cell.contentView.backgroundColor = [UIColor blueColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 20)];
    NSIndexPath *path = [pagerView.collectionView indexPathForCell:cell];
    label.text = [NSString stringWithFormat:@"示例广告页面:%ld",(long)path];
    label.font = [UIFont fontWithName:YHFont size:18];
    label.textColor = [UIColor whiteColor];
    //[cell.contentView addSubview:label];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc] init];
    CGRect tabFrame = self.frame;
    tabFrame.size.width = 94*YHpx;
    tabFrame.size.height = 58*YHpx;
    layout.itemSize = tabFrame.size;
    layout.itemSpacing = 10.0;
    return layout;
}

#pragma mark TYCyclePagerViewDelegate

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    //NSLog(@"%ld:%ld",(long)fromIndex,(long)toIndex);
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    
}

- (void)pagerView:(TYCyclePagerView *)pageView initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes {
    
}

- (void)pagerView:(TYCyclePagerView *)pageView applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes {
    
}

#pragma mark scrollViewDelegate
- (void)pagerViewDidScroll:(TYCyclePagerView *)pageView {
    //NSLog(@"%ld",(long)pageView.curIndex);
}

- (void)pagerViewWillBeginDragging:(TYCyclePagerView *)pageView {
    
}

- (void)pagerViewDidEndDragging:(TYCyclePagerView *)pageView willDecelerate:(BOOL)decelerate {
    
}

- (void)pagerViewWillBeginDecelerating:(TYCyclePagerView *)pageView {
    
}

- (void)pagerViewDidEndDecelerating:(TYCyclePagerView *)pageView {
    
}

- (void)pagerViewWillBeginScrollingAnimation:(TYCyclePagerView *)pageView {
    
}

- (void)pagerViewDidEndScrollingAnimation:(TYCyclePagerView *)pageView {
    
}

@end
