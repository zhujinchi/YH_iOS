//
//  YHTableViewCell.h
//  YH_project
//
//  Created by Angzeng on 2018/6/13.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHArticleModel.h"

@protocol YHSelectContentDelegate <NSObject>

- (void)ViewSelectContentWithId:(NSString *)articleId;

@end

@interface YHTableViewCell : UITableViewCell

@property (nonatomic, weak) id<YHSelectContentDelegate> delegate;

- (void)cellSetDataWithDict:(YHArticleModel *)cellModel;

@end
