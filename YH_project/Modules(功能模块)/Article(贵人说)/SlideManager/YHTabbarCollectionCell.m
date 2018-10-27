//
//  YHTabbarCollectionCell.m
//  YH_project
//
//  Created by Angzeng on 2018/6/11.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHTabbarCollectionCell.h"

@interface YHTabbarCollectionCell()

@property (nonatomic,weak) UIView * subView;

@end

@implementation YHTabbarCollectionCell

- (void)setSubVc:(UIViewController *)subVc{
    
    _subVc = subVc;
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:subVc.view];
    subVc.view.frame = self.bounds;
}

@end
