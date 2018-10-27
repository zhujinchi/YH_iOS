//
//  YHPickModel.m
//  YH_project
//
//  Created by Angzeng on 2018/5/16.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHPickModel.h"
#import "YHPickLabel.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "setViewManager.h"

@interface YHPickModel()

@property (nonatomic, strong) YHPickLabel *pickOneV;
@property (nonatomic, strong) YHPickLabel *pickTwoV;
@property (nonatomic, strong) YHPickLabel *pickThreeV;
@property (nonatomic, strong) YHPickLabel *pickFourV;

@end

@implementation YHPickModel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = YHColor_LightGray;
    self.layer.cornerRadius = 0.01*YHScreenWidth;
    float loat = 6*YHpx;
    //
    _pickOneV = [[YHPickLabel alloc] initWithFrame:CGRectMake(loat/2, 2*YHpx, 18*YHpx, 31*YHpx) input:0];
    _pickOneV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pickOneV];
    //
    _pickTwoV = [[YHPickLabel alloc] initWithFrame:CGRectMake(3*loat/2+18*YHpx, 2*YHpx, 18*YHpx, 31*YHpx) input:1];
    _pickTwoV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pickTwoV];
    //
    _pickThreeV = [[YHPickLabel alloc] initWithFrame:CGRectMake(5*loat/2+36*YHpx, 2*YHpx, 18*YHpx, 31*YHpx) input:2];
    _pickThreeV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pickThreeV];
    //
    _pickFourV = [[YHPickLabel alloc] initWithFrame:CGRectMake(7*loat/2+54*YHpx, 2*YHpx, 18*YHpx, 31*YHpx) input:3];
    _pickFourV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pickFourV];
    //
    for (YHPickLabel *subView in self.subviews) {
        @autoreleasepool{
            setViewManager *manager = [[setViewManager alloc] init];
            [manager setViewShadow:subView];
        }
    }
}

@end
