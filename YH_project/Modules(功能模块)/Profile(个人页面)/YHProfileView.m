//
//  YHProfileView.m
//  YH_project
//
//  Created by Angzeng on 2018/5/14.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHProfileView.h"
#import "YHScrollView.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "YHUser.h"

@implementation YHProfileView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    YHScrollView *ScrollV = [[YHScrollView alloc] initWithFrame:CGRectMake(0, 0, 0.8*YHScreenWidth, YHScreenHeight)];
    ScrollV.backgroundColor = [UIColor clearColor];
    ScrollV.contentSize = CGSizeMake(0.8*YHScreenWidth, YHScreenHeight);
    ScrollV.alwaysBounceVertical = YES;
    ScrollV.userInteractionEnabled=YES;
    ScrollV.showsHorizontalScrollIndicator = NO;
    ScrollV.showsVerticalScrollIndicator = NO;
    [self addSubview:ScrollV];
    //
    _AvatarV = [[YHAvatar alloc] initWithFrame:CGRectMake(0.05*YHScreenWidth-0.45*YHScreenWidth-102, 0.05*YHScreenWidth+14+30, 0.2*YHScreenWidth, 0.2*YHScreenWidth)];
    [_AvatarV setAvaterImgWithUrl:[NSString stringWithFormat:@"http://%@",[YHUser shareInstance].userAvater] placeholderImage:nil];
    _AvatarV.layer.cornerRadius = 0.1*YHScreenWidth;
    _AvatarV.isShowInfo = NO;
    [self addSubview:_AvatarV];
    self.backgroundColor = [UIColor darkGrayColor];
    //
    UILabel *NameL = [[UILabel alloc] initWithFrame:CGRectMake(0.2*YHScreenWidth+22, 0, 80, 30)];
    NameL.text = @"朱近赤";
    NameL.textColor =YHColor_LightGray;
    NameL.font = [UIFont fontWithName:YHFont size:20];
    [_AvatarV addSubview:NameL];
    //
}

- (void)pushAvatarV {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_AvatarV setTransform:CGAffineTransformMakeTranslation(0.45*YHScreenWidth+102, 0)];
    } completion:^(BOOL finished){
        //
    }];
}

- (void)pullAvatarV {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_AvatarV setTransform:CGAffineTransformMakeTranslation(-0.45*YHScreenWidth-102, 0)];
    } completion:^(BOOL finished){
        //
    }];
}

@end
