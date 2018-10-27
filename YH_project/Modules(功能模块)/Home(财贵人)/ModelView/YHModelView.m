//
//  YHModelView.m
//  YH_project
//
//  Created by Angzeng on 2018/5/15.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHModelView.h"
#import "YHMatchViewController.h"
#import "YHBasePopView.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "setViewManager.h"
#import "YHLabelBrand.h"
#import "YHabilityView.h"
#import "YHprofileInfoView.h"
#import "YHUser.h"

@interface YHModelView()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) YHabilityView *ability;
@property (nonatomic, strong) YHprofileInfoView *profileInfoView;

@end

@implementation YHModelView

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
    //
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(1*YHpx, 1*YHpx, 57*YHpx-10, 33*YHpx)];
    backView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1];
    backView.layer.cornerRadius = 1*YHpx;
    [self addSubview:backView];
    UIView *backLine = [[UIView alloc] initWithFrame:CGRectMake(27*YHpx, 7*YHpx, 1, 19*YHpx)];
    backLine.backgroundColor = YHColor_PureGray;
    [backView addSubview:backLine];
    //头像
    _AvatarV = [[YHAvatar alloc] initWithFrame:CGRectMake(5*YHpx, 5*YHpx, 20*YHpx, 20*YHpx)];
    _AvatarV.userId = [YHUser shareInstance].userId;
    [self addSubview:_AvatarV];
    //标签
    YHLabelBrand *labelV = [[YHLabelBrand alloc] initWithFrame:CGRectMake(5*YHpx, 27.5*YHpx, 20*YHpx, 5*YHpx) Title:@"军 师" Color:YHColor_Black TextColor:YHColor_DarkGray showDot:YES];
    UITapGestureRecognizer *showIntro = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showIntroView)];
    [labelV addGestureRecognizer:showIntro];
    [self addSubview:labelV];
    //个人信息视图
    _profileInfoView = [[YHprofileInfoView alloc] initWithFrame:CGRectMake(30*YHpx, 5*YHpx, 25*YHpx, 25*YHpx)];
    [self addSubview:_profileInfoView];
    //
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(62*YHpx-21, 2.5*YHpx, 1, 30*YHpx)];
    lineV.backgroundColor = YHColor_PureGray;
    [self addSubview:lineV];
    //
    _ability = [[YHabilityView alloc] initWithFrame:CGRectMake(67*YHpx-20, 4*YHpx, 30*YHpx, 30*YHpx)];
    _ability.layer.cornerRadius = 1*YHpx;
    _ability.backgroundColor = [UIColor clearColor];
    [self addSubview:_ability];
    //
    UIImageView *nameImgV = [[UIImageView alloc] initWithFrame:CGRectMake(1*YHpx, 1*YHpx, 7*YHpx, 7*YHpx)];
    [nameImgV setImage:[UIImage imageNamed:@"icon_font_name"]];
    //[self addSubview:nameImgV];
}

- (void)setDateForInfoViewWithDict:(NSDictionary *)dict {
    NSLog(@"%@",dict);
    [_profileInfoView setNameWithString:dict[@"uname"] daysWithString:dict[@"reg_all"] answerWithString:dict[@"question_count"]];
    [YHUser shareInstance].abilityMode = @[dict[@"growsystem"],
                                           dict[@"wealthsystem"],
                                           dict[@"emotionsystem"],
                                           dict[@"faithsystem"],
                                           dict[@"toolsystem"]];
    _ability.capacity = [YHUser shareInstance].abilityMode;
    [_ability setNeedsDisplay];
}

- (void)showIntroView {
    [YHBasePopView initIntroViewWithText:@"标签是根据你的模型特征得出的个人属性，根据标签可以帮助其他人更快的了解你。"];
}

@end
