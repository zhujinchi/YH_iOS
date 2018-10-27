//
//  AnswerContentView.m
//  YH_project
//
//  Created by Angzeng on 2018/7/17.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "AnswerContentView.h"
#import "YHBasePopView.h"
#import "YHAvatar.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"
#import "YHLabelBrand.h"
#import "setViewManager.h"

@interface AnswerContentView()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) YHAvatar *askAvatarView;
@property (nonatomic, strong) UIView *askView;
@property (nonatomic, strong) UILabel *askLabel;
@property (nonatomic, strong) YHAvatar *answerAvatarView;
@property (nonatomic, strong) UIView *answerView;
@property (nonatomic, strong) UILabel *answerLabel;
@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation AnswerContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = YHColor_LightGray;
    //
    _answerAvatarView = [[YHAvatar alloc] initWithFrame:CGRectMake(3.5*YHpx, 2*YHpx, 10*YHpx, 10*YHpx)];
    [self addSubview:_answerAvatarView];
    //
    UIView *titlelineV = [[UIView alloc] initWithFrame:CGRectMake(18*YHpx-2*FontPx, 3*YHpx, 2*FontPx, 8*YHpx)];
    titlelineV.backgroundColor = YHColor_ChineseRed;
    [self addSubview:titlelineV];
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(18*YHpx, 1*YHpx, 79*YHpx, 12*YHpx)];
    _titleView.backgroundColor = YHColor_LightGray;
    _titleView.layer.cornerRadius = 5;
    [self addSubview:_titleView];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75*YHpx, 12*YHpx)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self.titleView addSubview:_titleLabel];
    //
    _askView = [[UIView alloc] initWithFrame:CGRectMake(6*YHpx, 14*YHpx, 97*YHpx, 19*YHpx)];
    _askView.backgroundColor = YHColor_PureGray;
    _askView.layer.cornerRadius = 2*YHpx;
    [self addSubview:_askView];
    YHLabelBrand *askPeopleLabel = [[YHLabelBrand alloc] initWithFrame:CGRectMake(2.5*YHpx, 13*YHpx, 14*YHpx, 4*YHpx) Title:@"提 问" Color:[UIColor grayColor] TextColor:[UIColor whiteColor] showDot:NO];
    UITapGestureRecognizer *showIntro = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showIntroView)];
    [askPeopleLabel addGestureRecognizer:showIntro];
    [_askView addSubview:askPeopleLabel];
    _askLabel = [[UILabel alloc] initWithFrame:CGRectMake(17*YHpx, 1.5*YHpx, 74*YHpx, 12*YHpx)];
    [_askView addSubview:_askLabel];
    _askAvatarView = [[YHAvatar alloc] initWithFrame:CGRectMake(4.5*YHpx, 1.5*YHpx, 10*YHpx, 10*YHpx)];
    [_askView addSubview:_askAvatarView];
    //
    UIView *bottomlineV = [[UIView alloc] initWithFrame:CGRectMake(3*YHpx, (112*YHpx-20)/3, 1*YHpx, 1*YHpx)];
    bottomlineV.backgroundColor = YHColor_ChineseRed;
    bottomlineV.layer.cornerRadius = 0.5*YHpx;
    [self addSubview:bottomlineV];
    _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(5*YHpx, (106*YHpx-20)/3, 92*YHpx, 5*YHpx)];
    _bottomLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_bottomLabel];
}

- (void)showIntroView {
    [YHBasePopView initIntroViewWithText:@""];
}

- (void)setData:(NSDictionary*)dataDict {
    [_answerAvatarView setAvaterImgWithUrl:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=4229473086,4264433453&fm=58&bpow=450&bpoh=675" placeholderImage:nil];
    [_askAvatarView setAvaterImgWithUrl:@"https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=2182404651,2297138095&fm=85&s=6F1A19C752233B1BD98518BE03005048" placeholderImage:nil];
    //titleText
    NSString *titleText = @" 上海的经济模式下的传媒行业发展";
//    if (!cellModel.title || [cellModel.title isEqualToString:@""]) {
//        titleText = @" 非法标题（无标题）";
//        _titleLabel.textColor = YHColor_ChineseRed;
//    }else {
//        titleText = [NSString stringWithFormat:@"%@",cellModel.title];
//    }
//    int titleLength = (int)(unsigned long)[cellModel.title length];
//    if (titleLength > 24) {
//        _titleLabel.numberOfLines = 2;
//        _titleLabel.font = [UIFont fontWithName:YHFont size:12*FontPx];
//    }else if(titleLength <= 24 &&titleLength > 12) {
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont fontWithName:YHFont size:14*FontPx];
//    }else if(titleLength <= 12) {
//        _titleLabel.font = [UIFont fontWithName:YHFont size:18*FontPx];
//    }
    _titleLabel.text = titleText;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    //_titleLabel.font = [UIFont fontWithName:YHFont size:18*FontPx];
    //askTitleText
    NSString *asktitleText = @" 上海经济发展的问题是什么？";
    _askLabel.text = asktitleText;
    _askLabel.textAlignment = NSTextAlignmentLeft;
    _askLabel.font = [UIFont fontWithName:YHFont size:14*FontPx];
    //bottomText
    NSString *bottomText = @"朱近赤 41评论 6小时前";
    _bottomLabel.text = bottomText;
    _bottomLabel.textAlignment = NSTextAlignmentLeft;
    _bottomLabel.font = [UIFont fontWithName:YHPingFangFont size:10*FontPx];
    //_bottomView.font = [UIFont boldSystemFontOfSize:12];
    _bottomLabel.textColor = [UIColor colorWithRed:52/255.0 green:53/255.0 blue:44/255.0 alpha:0.7];
}

@end
