//
//  YHArticleContentViewController.h
//  YH_project
//
//  Created by Angzeng on 2018/6/11.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHArticleModel.h"

@protocol YHDidScrollViewDelegate <NSObject>

- (void)ViewDidScrollisDismiss:(BOOL)isDismiss;
- (void)ViewSelectedTableWithId:(NSString *)articleId;

@end

@interface YHArticleContentViewController : UIViewController
/**
 *  代理
 */
@property (nonatomic, weak) id <YHDidScrollViewDelegate> delegate;
@property (nonatomic, strong) YHArticleModel *articleModel;
@property (nonatomic, readwrite) int articleType;

@end
