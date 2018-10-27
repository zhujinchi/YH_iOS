//
//  ShotArticleContentView.h
//  YH_project
//
//  Created by Angzeng on 2018/7/19.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHShotArticleModel.h"

@protocol ShotCellDelegate <NSObject>

- (void)ShotSelectCell;

@end

@interface ShotArticleContentView : UIView

- (void)setData:(YHShotArticleModel *)dataDict;
/**
 *  代理
 */
@property(nonatomic,weak) id <ShotCellDelegate> delegate;

@end
