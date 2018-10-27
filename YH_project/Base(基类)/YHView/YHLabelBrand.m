//
//  YHLabelBrand.m
//  YH_project
//
//  Created by Angzeng on 2018/7/17.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHLabelBrand.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"

@implementation YHLabelBrand

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title Color:(UIColor *)color TextColor:(UIColor *)textColor showDot:(BOOL)isShowDot{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUIwithTitle:title Color:color TextColor:textColor showDot:isShowDot];
    }
    return self;
}

- (void)setUIwithTitle:(NSString *)title Color:(UIColor *)color TextColor:(UIColor *)textColor showDot:(BOOL)isShowDot{
    self.backgroundColor = color;
    self.layer.cornerRadius = 1*YHpx;
    //
    float tempWidth = self.frame.size.width;
    float tempHeight = self.frame.size.height;
    UIView *dotV = [[UIView alloc] initWithFrame:CGRectMake(0.125*tempWidth-0.032*tempWidth, tempHeight/2-0.016*tempWidth, 0.064*tempWidth, 0.064*tempWidth)];
    dotV.layer.cornerRadius = 2*0.016*self.frame.size.width;
    dotV.backgroundColor = YHColor_ChineseRed;
    if (isShowDot) {
        [self addSubview:dotV];
    }
    
    UILabel *ModelValueV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tempWidth, tempHeight)];
    ModelValueV.textAlignment = NSTextAlignmentCenter;
    ModelValueV.font = [UIFont fontWithName:YHFont size:0.76*tempHeight];
    ModelValueV.text = title;
    ModelValueV.textColor = textColor;
    [self addSubview:ModelValueV];
}

@end
