//
//  YHPickLabel.m
//  YH_project
//
//  Created by Angzeng on 2018/7/3.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHPickLabel.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "UILabel+Extension.h"

@interface YHPickLabel()

@property (nonatomic, readwrite) int labelNo;
@property (nonatomic, strong) UILabel *labelLeft;
@property (nonatomic, strong) UILabel *labelRight;

@end

@implementation YHPickLabel

- (instancetype)initWithFrame:(CGRect)frame input:(int)input {
    self.labelNo = input;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    UIView *linV = [[UIView alloc] initWithFrame:CGRectMake(2*YHpx, 0.8*YHpx, 14*YHpx, 1*YHpx)];
    linV.backgroundColor = YHColor_Black;
    //
    _labelLeft = [[UILabel alloc] initWithFrame:CGRectMake(4*YHpx, 3*YHpx, 7*YHpx, 25*YHpx)];
    _labelLeft.verticalText = [self setLabel:self.labelNo isLeft:YES];
    _labelLeft.font = [UIFont fontWithName:YHFont size:5.2*YHpx];
    [_labelLeft sizeToFit];
    //
    UIView *HlinV = [[UIView alloc] initWithFrame:CGRectMake(10.5*YHpx, 4*YHpx, 1, 23*YHpx)];
    HlinV.backgroundColor = YHColor_PureGray;
    //
    _labelRight = [[UILabel alloc] initWithFrame:CGRectMake(12*YHpx, 3*YHpx, 5*YHpx, 28*YHpx)];
    _labelRight.verticalText = [self setLabel:self.labelNo isLeft:NO];
    _labelRight.font = [UIFont fontWithName:YHFont size:2.56*YHpx];
    _labelRight.textColor = [UIColor lightGrayColor];
    [_labelRight sizeToFit];
    //
    //[self addSubview:linV];
    [self addSubview:HlinV];
    [self addSubview:_labelLeft];
    [self addSubview:_labelRight];
}

- (NSString *)setLabel:(int )input isLeft:(BOOL)isLeft{
    NSString *returnValue;
    switch (input) {
        case 0:
            returnValue = isLeft?@"志同道合":@"寻找模型相似者。";
            break;
        case 1:
            returnValue = isLeft?@"优势互补":@"寻找模型互补者。";
            break;
        case 2:
            returnValue = isLeft?@"富豪模型":@"查看富豪财富模型。";
            break;
        case 3:
            returnValue = isLeft?@"每日答题":@"答题完善财富模型。";
            break;
        default:
            break;
    }
    return returnValue;
}

@end
