//
//  YHTableContentView.h
//  YH_project
//
//  Created by Angzeng on 2018/6/17.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHArticleModel.h"

@protocol YHSelectCellDelegate <NSObject>

- (void)ViewSelectCellWithId:(NSString *)articleID;

@end

@interface YHTableContentView : UIView

- (void)setData:(YHArticleModel *)dataDict;
/**
 *  代理
 */
@property(nonatomic,weak) id <YHSelectCellDelegate> delegate;

@end
