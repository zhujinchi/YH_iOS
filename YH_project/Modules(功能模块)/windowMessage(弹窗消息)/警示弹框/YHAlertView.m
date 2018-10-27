//
//  YHAlertView.m
//  YH_project
//
//  Created by Angzeng on 2018/9/18.
//  Copyright © 2018 Angzeng. All rights reserved.
//

#import "YHAlertView.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"

@interface YHAlertView()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation YHAlertView

+ (void)initAlertViewWithText:(NSString *)text Second:(int)sec {
    YHAlertView *alertView = [[YHAlertView alloc] initWithText:text Second:sec];
}

- (id)initWithText:(NSString *)text Second:(int)sec {
    self = [super initWithFrame:CGRectMake(10, -0.9*YHScreenHeight, YHScreenWidth-20, 80)];
    if (self) {
        [self setUIWithText:text];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:sec];
    }
    return self;
}

- (void)setUIWithText:(NSString *)text {
    self.layer.cornerRadius = 0.03*YHScreenWidth;
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 15.0;
    self.layer.shadowOpacity = 0.5;
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.90];
    //
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(2*YHpx, 2*YHpx, 10*YHpx, 10*YHpx)];
    titleView.layer.cornerRadius = 5*YHpx;
    [titleView setImage:[UIImage imageNamed:@"icon_font_sign"]];
    [self addSubview:titleView];
    //
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(56, 3, 100*YHpx-93, 74)];
    _textView.backgroundColor = [UIColor clearColor];
    [_textView setEditable:NO];
    _textView.font = [UIFont fontWithName:YHFont size:16*FontPx];
    _textView.text = text;
    [self addSubview:_textView];
    //限制警告标语出现个数，小于等于一
    if ([self WindowView].subviews.count <= 1) {
        [self showView];
    }
}

- (void)showView {
    [[self WindowView] addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        [self setTransform:CGAffineTransformMakeTranslation(0, YHScreenHeight)];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:1 animations:^{
        [self setTransform:CGAffineTransformMakeTranslation(0, -2*YHScreenHeight)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (UIWindow *)WindowView {
    UIApplication *YHwindow = [UIApplication sharedApplication];
    if ([YHwindow.delegate respondsToSelector:@selector(window)]) {
        return [YHwindow.delegate window];
    }else {
        return [YHwindow keyWindow];
    }
}

@end
