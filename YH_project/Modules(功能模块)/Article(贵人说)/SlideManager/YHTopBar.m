//
//  YHTopBar.m
//  YH_project
//
//  Created by Angzeng on 2018/6/11.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHTopBar.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"

static CGFloat const topBarItemMargin = 24; ///标题之间的间距
static CGFloat const topBarHeight = 40; //顶部标签条的高度

@interface YHTopBar()

@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIView *lineV;

@end

@implementation YHTopBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isOnView = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        _lineV = [[UIView alloc] initWithFrame:CGRectMake(15, self.frame.size.height-3, 37, 2)];
        _lineV.backgroundColor = YHColor_ChineseRed;
        [self addSubview:_lineV];
    }
    return self;
}

- (void)addTitleBtn:(NSString *)title {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.titleLabel.font = [UIFont fontWithName:YHFont size:16];
    //mark
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(itemSelectedChange:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [self.btnArray addObject:btn];
}

- (void)itemSelectedChange:(UIButton *)btn {
    
    NSInteger index = [self.btnArray indexOfObject:btn];
    if ([self.topBarDelegate respondsToSelector:@selector(YHTopBarChangeSelectedItem:selectedIndex:)]) {
        [self.topBarDelegate YHTopBarChangeSelectedItem:self selectedIndex:index];
    }
}

- (void)setSelectedItem:(NSInteger)index {
    
    UIButton *btn = self.btnArray[index];
    [UIView animateWithDuration:0.25 animations:^{
        
        self.selectedBtn.selected = NO;
        self.selectedBtn.titleLabel.font = [UIFont fontWithName:YHFont size:16];
        
        btn.selected = YES;
        btn.titleLabel.font = [UIFont fontWithName:YHFont size:18];
        self.selectedBtn = btn;
        //linV位置设定
        NSLog(@"%f:%f",self.selectedBtn.frame.size.width,self.selectedBtn.frame.origin.x);
        CGRect frame = self.lineV.frame;
        frame.origin.x = self.selectedBtn.frame.origin.x==0.0f?topBarItemMargin:self.selectedBtn.frame.origin.x;/*此处有触发概率极低的bug，可以忽略*/
        frame.size.width =  self.selectedBtn.frame.size.width;
        self.lineV.frame = frame;
        
        // 计算偏移量
        CGFloat offsetX = btn.center.x - YHScreenW * 0.5;
        if (offsetX < 0) offsetX = 0;
        // 获取最大滚动范围
        CGFloat maxOffsetX = self.contentSize.width - YHScreenW;
        if (offsetX > maxOffsetX) offsetX = maxOffsetX;
        
        if (self.contentSize.width > [UIScreen mainScreen].bounds.size.width) {
            // 滚动标题滚动条
            [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        }
    }];
}

- (NSMutableArray *)btnArray{
    
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat btnH = topBarHeight;
    CGFloat btnX = topBarItemMargin;
    for (int i = 0 ; i < self.btnArray.count; i++) {
        
        UIButton *btn = self.btnArray[i];
        btn.frame = CGRectMake(btnX, 0, btn.frame.size.width, btnH);
        btnX += btn.frame.size.width + topBarItemMargin;
    }
    self.contentSize = CGSizeMake(btnX, 0);
}
@end
