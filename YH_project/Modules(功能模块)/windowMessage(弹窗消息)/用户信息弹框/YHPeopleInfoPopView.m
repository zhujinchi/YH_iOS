//
//  YHPeopleInfoPopView.m
//  YH_project
//
//  Created by Angzeng on 2018/5/15.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHPeopleInfoPopView.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"

@interface YHPeopleInfoPopView()

@property (nonatomic, strong) NSString *userId;

@end

@implementation YHPeopleInfoPopView

+ (void)initUserViewWithID:(NSString *)userId {
    YHPeopleInfoPopView *PeopleInfoPopView = [[YHPeopleInfoPopView alloc] initWithID:userId];
}

- (instancetype)initWithID:(NSString *)userId {
    self = [super initWithFrame:CGRectMake(0, 0, YHScreenWidth, YHScreenHeight)];
    if (self) {
        self.userId = userId;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = ColorWithRGBA(52,53,44,0.6);
    [self setUserInfoUI];
    [[self WindowView] addSubview:self];
    UITapGestureRecognizer *GestureRemove = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissFromWindow)];
    UISwipeGestureRecognizer *GestureRemoveLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissByLeft)];
    [GestureRemoveLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    UISwipeGestureRecognizer *GestureRemoveRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissByRight)];
    [GestureRemoveRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    UISwipeGestureRecognizer *GestureRemoveUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissByUp)];
    [GestureRemoveUp setDirection:(UISwipeGestureRecognizerDirectionUp)];
    UISwipeGestureRecognizer *GestureRemoveDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissByDown)];
    [GestureRemoveDown setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self addGestureRecognizer:GestureRemove];
    [self addGestureRecognizer:GestureRemoveLeft];
    [self addGestureRecognizer:GestureRemoveRight];
    [self addGestureRecognizer:GestureRemoveUp];
    [self addGestureRecognizer:GestureRemoveDown];
}

- (void)setUserInfoUI {
    //_UserInfoView = [[YHUserInfoView alloc] initWithFrame:CGRectMake(0.15*YHScreenWidth, 1.2*YHScreenHeight, 0.7*YHScreenWidth, 0.6*YHScreenHeight)];
    _UserInfoView = [[YHUserInfoView alloc] initWithFrame:CGRectMake(5*YHpx, 1.5*YHScreenHeight-60*YHpx, 90*YHpx, 120*YHpx) ID:_userId];
    _UserInfoView.layer.cornerRadius = 0.03*YHScreenWidth;
    _UserInfoView.layer.shadowColor = [UIColor grayColor].CGColor;
    _UserInfoView.layer.shadowOffset = CGSizeMake(0, 0);
    _UserInfoView.layer.shadowRadius = 15.0;
    _UserInfoView.layer.shadowOpacity = 0.5;
    [self addSubview:_UserInfoView];
    [self pushFromWindow];
}

- (UIWindow *)WindowView {
    UIApplication *YHwindow = [UIApplication sharedApplication];
    if ([YHwindow.delegate respondsToSelector:@selector(window)]) {
        return [YHwindow.delegate window];
    }else {
        return [YHwindow keyWindow];
    }
}

#pragma mark 显示动画

- (void)pushFromWindow {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_UserInfoView setTransform:CGAffineTransformMakeTranslation(0, -YHScreenHeight)];
    }];
}

#pragma mark 消失动画

- (void)dismissFromWindow {
    [self dismissByDown];
}

- (void)dismissByLeft {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_UserInfoView setTransform:CGAffineTransformMakeTranslation(-YHScreenWidth, -YHScreenHeight)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (void)dismissByRight {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_UserInfoView setTransform:CGAffineTransformMakeTranslation(YHScreenWidth, -YHScreenHeight)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (void)dismissByUp {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_UserInfoView setTransform:CGAffineTransformMakeTranslation(0, -2*YHScreenHeight)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (void)dismissByDown {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_UserInfoView setTransform:CGAffineTransformMakeTranslation(0, 0)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

@end
