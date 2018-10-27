//
//  YHprofileInfoView.m
//  YH_project
//
//  Created by Angzeng on 2018/8/17.
//  Copyright © 2018 Angzeng. All rights reserved.
//

#import "YHprofileInfoView.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "UILabel+Extension.h"

@interface YHprofileInfoView()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *daysLabel;
@property (nonatomic, strong) UILabel *answerLabel;

@end

@implementation YHprofileInfoView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    //self.backgroundColor = [UIColor redColor];
    UIView *node = [[UIView alloc] initWithFrame:CGRectMake(0, 5*YHpx, 1*YHpx, 1*YHpx)];
    node.backgroundColor = YHColor_ChineseRed;
    node.layer.cornerRadius = 0.5*YHpx;
    [self addSubview:node];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*YHpx, 2*YHpx, 23*YHpx, 7*YHpx)];
    _nameLabel.font = [UIFont fontWithName:YHFont size:14*FontPx];
    _nameLabel.text = @"未命名";
    _nameLabel.textColor = YHColor_Black;
    [self addSubview:_nameLabel];
    //
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(1*YHpx, 10*YHpx, 16*YHpx, 1)];
    line.backgroundColor = YHColor_PureGray;
    [self addSubview:line];
    //
    _daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(1*YHpx, 11*YHpx, 24*YHpx, 7*YHpx)];
    _daysLabel.font = [UIFont fontWithName:YHFont size:12*FontPx];
    _daysLabel.text = @"登录0天";
    _daysLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_daysLabel];
    _answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(1*YHpx, 16*YHpx, 24*YHpx, 7*YHpx)];
    _answerLabel.font = [UIFont fontWithName:YHFont size:12*FontPx];
    _answerLabel.text = @"回答0题";
    _answerLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_answerLabel];
}

- (void)setNameWithString:(NSString *)name daysWithString:(NSString *)days answerWithString:(NSString *)answer {
    _nameLabel.text = name;
    _daysLabel.text = [NSString stringWithFormat:@"登录%@天",days];
    _answerLabel.text = [NSString stringWithFormat:@"回答%@题",answer];
    [self setNeedsLayout];
}

@end
