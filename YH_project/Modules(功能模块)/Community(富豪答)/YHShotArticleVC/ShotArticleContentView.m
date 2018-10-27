//
//  ShotArticleContentView.m
//  YH_project
//
//  Created by Angzeng on 2018/7/19.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "ShotArticleContentView.h"
#import "YHLabelBrand.h"
#import "YHBasePopView.h"
#import "YHAvatar.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShotArticleContentView()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) YHAvatar *avatarView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *introShowView;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) UILabel *intro;

@end

@implementation ShotArticleContentView

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
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 1*YHpx, 100*YHpx, 12*YHpx)];
    _topView.backgroundColor = [UIColor clearColor];
    [self addSubview:_topView];
    //
    _avatarView = [[YHAvatar alloc] initWithFrame:CGRectMake(3.5*YHpx, 1*YHpx, 10*YHpx, 10*YHpx)];
    [_topView addSubview:_avatarView];
    //
    UIView *titlelineV = [[UIView alloc] initWithFrame:CGRectMake(18*YHpx-2*FontPx, 2*YHpx, 2*FontPx, 8*YHpx)];
    titlelineV.backgroundColor = YHColor_ChineseRed;
    [_topView addSubview:titlelineV];
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(18*YHpx, 0*YHpx, 79*YHpx, 12*YHpx)];
    _titleView.backgroundColor = YHColor_LightGray;
    _titleView.layer.cornerRadius = 5;
    [_topView addSubview:_titleView];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(4*YHpx, 0, 71*YHpx, 12*YHpx)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self.titleView addSubview:_titleLabel];
    //
    _introShowView = [[UIView alloc] initWithFrame:CGRectMake(3*YHpx, 14*YHpx, 94*YHpx, (88*YHpx-20)/3)];
    _introShowView.backgroundColor = YHColor_PureGray;
    _introShowView.layer.cornerRadius = 2*YHpx;
    [self addSubview:_introShowView];
    _intro = [[UILabel alloc] initWithFrame:CGRectMake(18*YHpx, 2*YHpx, 74*YHpx, (72*YHpx-20)/3)];
    _intro.numberOfLines = 6;
    _intro.textColor = [UIColor grayColor];
    _intro.font = [UIFont fontWithName:YHFont size:12*FontPx];
    [_introShowView addSubview:_intro];
    //
    
    YHLabelBrand *labelBrand = [[YHLabelBrand alloc] initWithFrame:CGRectMake(2.5*YHpx, 2*YHpx, 14*YHpx, 4.5*YHpx) Title:@"大 咖" Color:[UIColor grayColor] TextColor:[UIColor whiteColor] showDot:NO];
    UITapGestureRecognizer *showIntro = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showIntroView)];
    [labelBrand addGestureRecognizer:showIntro];
    [_introShowView addSubview:labelBrand];
    //
    UIView *bottomlineV = [[UIView alloc] initWithFrame:CGRectMake(3*YHpx, (139*YHpx-20)/3, 1*YHpx, 1*YHpx)];
    bottomlineV.backgroundColor = YHColor_ChineseRed;
    bottomlineV.layer.cornerRadius = 0.5*YHpx;
    [self addSubview:bottomlineV];
    _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(5*YHpx, (133*YHpx-20)/3, 92*YHpx, 5*YHpx)];
    _bottomLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_bottomLabel];
    //
    UITapGestureRecognizer *showArticle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showArticle)];
    [self addGestureRecognizer:showArticle];
}

- (void)showIntroView {
    [YHBasePopView initIntroViewWithText:@""];
}

- (void)showArticle {
    [self.delegate ShotSelectCell];
}

- (void)setData:(YHShotArticleModel *)cellModel {
    NSLog(@"%@",cellModel);
    //titleText
    NSString *titleText;
    if (!cellModel.title || [cellModel.title isEqualToString:@""]) {
        titleText = @" 非法标题（无标题）";
        _titleLabel.textColor = YHColor_ChineseRed;
    }else {
        titleText = [NSString stringWithFormat:@"%@",cellModel.title];
    }
    int titleLength = (int)(unsigned long)[cellModel.title length];
    if (titleLength > 24) {
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont fontWithName:YHFont size:12*FontPx];
    }else if(titleLength <= 24 &&titleLength > 12) {
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont fontWithName:YHFont size:14*FontPx];
    }else if(titleLength <= 12) {
        _titleLabel.font = [UIFont fontWithName:YHFont size:18*FontPx];
    }
    _titleLabel.text = titleText;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    //avatarView
    [_avatarView setAvaterImgWithUrl:cellModel.avatar placeholderImage:nil];
    //bottomText
    NSString *bottomText = [NSString stringWithFormat:@"%@ %@评论 %@",cellModel.cname,cellModel.com_num,cellModel.pub_time];
    _bottomLabel.text = bottomText;
    _bottomLabel.textAlignment = NSTextAlignmentLeft;
    _bottomLabel.font = [UIFont fontWithName:YHFont size:10*FontPx];
    //_bottomView.font = [UIFont boldSystemFontOfSize:12];
    _bottomLabel.textColor = [UIColor colorWithRed:52/255.0 green:53/255.0 blue:44/255.0 alpha:0.7];
    //
    //_articleId = cellModel.aid;
    //
    int cnameLength = (int)(unsigned long)[cellModel.cname length];
    NSMutableString *cnameStr = [[NSMutableString alloc] initWithString:cellModel.cname];
    YHLabelBrand *labelName;
    if (cnameLength == 2) {
        [cnameStr insertString:@" " atIndex:1];
        labelName = [[YHLabelBrand alloc] initWithFrame:CGRectMake(2.5*YHpx, 8.5*YHpx, 14*YHpx, 4.5*YHpx) Title:cnameStr Color:[UIColor whiteColor] TextColor:YHColor_Black showDot:YES];
    }else if (cnameLength == 3) {
        labelName = [[YHLabelBrand alloc] initWithFrame:CGRectMake(2*YHpx, 8.5*YHpx, 15*YHpx, 4.5*YHpx) Title:cnameStr Color:[UIColor whiteColor] TextColor:YHColor_Black showDot:YES];
    }
    //introLabel
    _intro.text = cellModel.intro;
    //
    [_introShowView addSubview:labelName];
}


@end
