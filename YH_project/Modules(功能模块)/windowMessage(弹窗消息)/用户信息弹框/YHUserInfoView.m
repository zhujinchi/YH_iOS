//
//  YHUserInfoView.m
//  YH_project
//
//  Created by Angzeng on 2018/5/15.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHUserInfoView.h"
#import "URLMacros.h"
#import "YHDataManager.h"
#import "YHabilityView.h"
#import "YHprofileInfoView.h"
#import "UtilsMacros.h"
#import "YHAvatar.h"
#import "YHLabelBrand.h"
#import "FontAndColorMacros.h"
#import "YHUser.h"
#import "YHcommonTool.h"

@interface YHUserInfoView()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) YHAvatar *AvatarV;
@property (nonatomic, strong) YHprofileInfoView *profileInfoView;
@property (nonatomic, strong) YHabilityView *targetAbilityView;
@property (nonatomic, strong) YHabilityView *selfAbilityView;
@property (nonatomic, strong) UIView *midBackView;
@property (nonatomic, strong) UIView *bottomBackView;
@property (nonatomic, strong) UILabel *introLabel;


@end

@implementation YHUserInfoView

- (instancetype)initWithFrame:(CGRect)frame ID:(NSString *)userId{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUIWithID:userId];
    }
    return self;
}

- (void)setUIWithID:(NSString *)userId {
    self.backgroundColor = [UIColor whiteColor];
    //
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(2*YHpx, 2*YHpx, 10*YHpx, 10*YHpx)];
    titleView.layer.cornerRadius = 3.5*YHpx;
    [titleView setImage:[UIImage imageNamed:@"@icon_font_name"]];
    //设置topview图片
    //UIImage *plumImg = [YHcommonTool imageByApplyingAlpha:0.8 image:[UIImage imageNamed:@"icon_info_back"]];
    UIImageView *plumView = [[UIImageView alloc] initWithFrame:CGRectMake(3*YHpx, 3*YHpx, 35*YHpx, 35*YHpx)];
    //[plumView setImage:plumImg];
    //
    UIView *backgroundV = [[UIView alloc] initWithFrame:CGRectMake(3*YHpx, 3*YHpx, 84*YHpx, 37*YHpx)];
    backgroundV.layer.cornerRadius = 1*YHpx;
    backgroundV.backgroundColor = YHColor_LightGray;
    //
    _backView = [[UIView alloc] initWithFrame:CGRectMake(1*YHpx, 1*YHpx, 82*YHpx, 33*YHpx)];
    _backView.backgroundColor = YHColor_WhiteGray;
    _backView.layer.cornerRadius = 1*YHpx;
    [backgroundV addSubview:_backView];
    //
    _AvatarV = [[YHAvatar alloc] initWithFrame:CGRectMake(17*YHpx, 3*YHpx, 20*YHpx, 20*YHpx)];
    _AvatarV.isShowInfo = NO;
    _AvatarV.userId = userId;
    [_backView addSubview:_AvatarV];
    //
    UIView *backLine = [[UIView alloc] initWithFrame:CGRectMake(41*YHpx, 7*YHpx, 1, 19*YHpx)];
    backLine.backgroundColor = YHColor_PureGray;
    [_backView addSubview:backLine];
    //
    YHLabelBrand *labelV = [[YHLabelBrand alloc] initWithFrame:CGRectMake(17*YHpx, 25*YHpx, 20*YHpx, 5*YHpx) Title:@"军 师" Color:YHColor_Black TextColor:YHColor_DarkGray showDot:YES];
    [_backView addSubview:labelV];
    //
    _profileInfoView = [[YHprofileInfoView alloc] initWithFrame:CGRectMake(44*YHpx, 5*YHpx, 25*YHpx, 25*YHpx)];
    [_backView addSubview:_profileInfoView];
    //
    _midBackView = [[UIView alloc] initWithFrame:CGRectMake(3*YHpx, 39*YHpx, 84*YHpx, 42*YHpx)];
    _midBackView.backgroundColor = YHColor_LightGray;
    _midBackView.layer.cornerRadius = 1*YHpx;
    
    UIView *midRightBackView = [[UIView alloc] initWithFrame:CGRectMake(42.5*YHpx, 1*YHpx, 40.5*YHpx, 40.5*YHpx)];
    midRightBackView.layer.cornerRadius = 1*YHpx;
    midRightBackView.backgroundColor = [UIColor colorWithRed:52/255.0 green:53/255.0 blue:44/255.0 alpha:0.03];
    //[_midBackView addSubview:midRightBackView];
    
    UIView *midLeftBackView = [[UIView alloc] initWithFrame:CGRectMake(1*YHpx, 1*YHpx, 82*YHpx, 40.5*YHpx)];
    midLeftBackView.layer.cornerRadius = 1*YHpx;
    midLeftBackView.backgroundColor = [UIColor colorWithRed:52/255.0 green:53/255.0 blue:44/255.0 alpha:0.03];
    [_midBackView addSubview:midLeftBackView];
    
    UILabel *selfLabel = [[UILabel alloc] initWithFrame:CGRectMake(13.6*YHpx, 36*YHpx, 15*YHpx, 4*YHpx)];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"你的模型"];
    [str addAttribute:NSForegroundColorAttributeName value:YHColor_ChineseRed range:NSMakeRange(0, 1)];
    [str addAttribute:NSForegroundColorAttributeName value:YHColor_WhiteGray range:NSMakeRange(1, 3)];
    selfLabel.attributedText = str;
    selfLabel.layer.cornerRadius = 1*YHpx;
    selfLabel.font = [UIFont fontWithName:YHFont size:8*FontPx];
    selfLabel.textAlignment = NSTextAlignmentCenter;
    selfLabel.clipsToBounds = YES;
    selfLabel.backgroundColor = YHColor_DarkGray;
    [_midBackView addSubview:selfLabel];
    
    UILabel *targetLabel = [[UILabel alloc] initWithFrame:CGRectMake(55.6*YHpx, 36*YHpx, 15*YHpx, 4*YHpx)];
    str = [[NSMutableAttributedString alloc] initWithString:@"对方的模型"];
    [str addAttribute:NSForegroundColorAttributeName value:YHColor_ChineseRed range:NSMakeRange(0, 2)];
    [str addAttribute:NSForegroundColorAttributeName value:YHColor_WhiteGray range:NSMakeRange(2, 3)];
    targetLabel.attributedText = str;
    targetLabel.layer.cornerRadius = 1*YHpx;
    targetLabel.font = [UIFont fontWithName:YHFont size:8*FontPx];
    targetLabel.textAlignment = NSTextAlignmentCenter;
    targetLabel.clipsToBounds = YES;
    targetLabel.backgroundColor = YHColor_DarkGray;
    [_midBackView addSubview:targetLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(42*YHpx-0.5, 3*YHpx, 1, 36*YHpx)];
    lineView.backgroundColor = YHColor_WhiteGray;
    [_midBackView addSubview:lineView];
    //
    _targetAbilityView = [[YHabilityView alloc] initWithFrame:CGRectMake(47*YHpx, 4*YHpx, 32*YHpx, 32*YHpx)];
    _targetAbilityView.backgroundColor = [UIColor clearColor];
    
    _selfAbilityView = [[YHabilityView alloc] initWithFrame:CGRectMake(5*YHpx, 4*YHpx, 32*YHpx, 32*YHpx)];
    _selfAbilityView.backgroundColor = [UIColor clearColor];
    
    [self setDataWithID:userId];
    //
    _bottomBackView = [[UIView alloc] initWithFrame:CGRectMake(3*YHpx, 80*YHpx, 84*YHpx, 37*YHpx)];
    _bottomBackView.backgroundColor = YHColor_LightGray;
    _bottomBackView.layer.cornerRadius = 1*YHpx;
    //
    _introLabel = [[UILabel alloc] initWithFrame:CGRectMake(3*YHpx, 0*YHpx, 78*YHpx, 23*YHpx)];
    _introLabel.font = [UIFont fontWithName:YHFont size:12*FontPx];
    _introLabel.textColor = YHColor_Black;
    _introLabel.numberOfLines = 4;
    [_bottomBackView addSubview:_introLabel];
    //
    UIButton *communityBtn = [[UIButton alloc] initWithFrame:CGRectMake(1*YHpx, 25*YHpx, 40.5*YHpx, 11*YHpx)];
    communityBtn.layer.cornerRadius = 1*YHpx;
    communityBtn.clipsToBounds = YES;
    communityBtn.backgroundColor = YHColor_ChineseRed;
    
    UILabel *communityLabel = [[UILabel alloc] initWithFrame:CGRectMake(1*YHpx, 1*YHpx, 38.5*YHpx, 9*YHpx)];
    communityLabel.text = @"添加好友";
    communityLabel.textAlignment = NSTextAlignmentCenter;
    communityLabel.font = [UIFont fontWithName:YHFont size:14*FontPx];
    communityLabel.textColor = YHColor_WhiteGray;
    [communityBtn addSubview:communityLabel];
    
    [_bottomBackView addSubview:communityBtn];
    
    UIButton *concernBtn = [[UIButton alloc] initWithFrame:CGRectMake(42.5*YHpx, 25*YHpx, 40.5*YHpx, 11*YHpx)];
    concernBtn.layer.cornerRadius = 1*YHpx;
    concernBtn.clipsToBounds = YES;
    concernBtn.backgroundColor = YHColor_ChineseRed;
    
    UILabel *concernLabel = [[UILabel alloc] initWithFrame:CGRectMake(1*YHpx, 1*YHpx, 38.5*YHpx, 9*YHpx)];
    concernLabel.text = @"关注";
    concernLabel.textAlignment = NSTextAlignmentCenter;
    concernLabel.font = [UIFont fontWithName:YHFont size:14*FontPx];
    concernLabel.textColor = YHColor_WhiteGray;
    [concernBtn addSubview:concernLabel];
    
    [_bottomBackView addSubview:concernBtn];
    //
    [self addSubview:backgroundV];
    [self addSubview:titleView];
    [self addSubview:plumView];
    [self addSubview:_midBackView];
    [self addSubview:_bottomBackView];
}

- (void)setDataWithID:(NSString *)userId {
    [_selfAbilityView setNeedsLayout];
    __weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"type":@"1",@"uid": userId,@"muid":[YHUser shareInstance].userId};
    [[YHDataManager manager] postDataWithUrl:YHurl_feature Parameters:parameters Block:^(id dict) {
        if ([dict[@"code"] isEqual:@200]) {
            NSLog(@"%@",dict);
            [weakSelf setComponentDataWithDict:dict[@"data"]];
        }else {
            NSLog(@"请求失败");
        }
    }];
    
}

- (void)setComponentDataWithDict:(NSDictionary *)dict {
    [self->_AvatarV setAvaterImgWithUrl:[NSString stringWithFormat:@"http://%@",dict[@"avatar"]] placeholderImage:nil];
    [self->_profileInfoView setNameWithString:dict[@"uname"] daysWithString:dict[@"reg_all"] answerWithString:dict[@"question_count"]];
    _introLabel.text = @"雷军，小米科技的创始人兼CEO。曾任金山公司执行董事及董事会副主席，天使投资人。2011年8月，其投资创办的小米公司正式发布小米手机。";
    dispatch_async(dispatch_get_main_queue(), ^{
        self->_selfAbilityView.capacity = [YHUser shareInstance].abilityMode;
        self->_targetAbilityView.capacity = @[dict[@"growsystem"],
                                              dict[@"wealthsystem"],
                                              dict[@"emotionsystem"],
                                              dict[@"faithsystem"],
                                              dict[@"toolsystem"]];
        [self->_midBackView addSubview:self->_targetAbilityView];
        [self->_midBackView addSubview:self->_selfAbilityView];
    });

}

@end
