//
//  ShotArticleTableViewCell.h
//  YH_project
//
//  Created by Angzeng on 2018/7/19.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHShotArticleModel.h"

@protocol ShotViewDelegate

- (void)ShotVSelectContent;

@end

@interface ShotArticleTableViewCell : UITableViewCell

@property (nonatomic, strong) id<ShotViewDelegate> delegate;

- (void)cellSetDataWithDict:(YHShotArticleModel *)cellModel;

@end
