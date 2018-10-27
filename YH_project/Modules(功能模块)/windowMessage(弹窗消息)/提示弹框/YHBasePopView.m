//
//  YHBasePopView.m
//  YH_project
//
//  Created by Angzeng on 2018/5/16.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHBasePopView.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"

@implementation YHBasePopView

+ (void)initIntroViewWithText:(NSString *)text {
    YHBasePopView *baseV = [[YHBasePopView alloc] initWithText:text];
}

- (instancetype)initWithText:(NSString *)text {
    self = [super initWithFrame:CGRectMake(0, 0, YHScreenWidth, YHScreenHeight)];
    if (self) {
        [self setUIwithText:text];
    }
    return self;
}

- (void)setUIwithText:(NSString *)text {
    self.backgroundColor = ColorWithRGBA(52,53,44,0.3);
    [self setIntroInfoUIwithText:(NSString *)text];
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

- (void)setIntroInfoUIwithText:(NSString *)text {
    _IntroInfoView = [[YHIntroduceView alloc] initWithFrame:CGRectMake(10, -0.9*YHScreenHeight, 100*YHpx-20, 120)];
    _IntroInfoView.layer.cornerRadius = 0.03*YHScreenWidth;
    _IntroInfoView.layer.shadowColor = [UIColor grayColor].CGColor;
    _IntroInfoView.layer.shadowOffset = CGSizeMake(0, 0);
    _IntroInfoView.layer.shadowRadius = 15.0;
    _IntroInfoView.layer.shadowOpacity = 0.5;
    _IntroInfoView.backgroundColor = [UIColor whiteColor];
    [_IntroInfoView setTextWithString:text];
    [self addSubview:_IntroInfoView];
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
        [self->_IntroInfoView setTransform:CGAffineTransformMakeTranslation(0, YHScreenHeight)];
    }];
}

#pragma mark 消失动画

- (void)dismissFromWindow {
    [self dismissByUp];
}

- (void)dismissByLeft {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_IntroInfoView setTransform:CGAffineTransformMakeTranslation(-YHScreenWidth, YHScreenHeight)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (void)dismissByRight {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_IntroInfoView setTransform:CGAffineTransformMakeTranslation(YHScreenWidth, YHScreenHeight)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (void)dismissByUp {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_IntroInfoView setTransform:CGAffineTransformMakeTranslation(0, -2*YHScreenHeight)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (void)dismissByDown {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_IntroInfoView setTransform:CGAffineTransformMakeTranslation(0, 2*YHScreenHeight)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

@end
