//
//  setViewMethod.m
//  YH_project
//
//  Created by Angzeng on 2018/6/10.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "setViewManager.h"
#import "FontAndColorMacros.h"

@implementation setViewManager

- (instancetype)initWithView:(UIView *)View {
    if (self) {
        [self setViewShadow:View];
    }
    return [self init];
}


- (void)setViewShadow:(UIView *)View {
    View.layer.shadowOpacity = 0.1;
    View.layer.shadowColor = YHColor_Black.CGColor;
    View.layer.shadowRadius = 3;
    View.layer.shadowOffset = CGSizeMake(1, 1);
    return;
}

@end
