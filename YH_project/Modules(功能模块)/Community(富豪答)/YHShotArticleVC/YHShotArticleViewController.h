//
//  YHShotArticleViewController.h
//  YH_project
//
//  Created by Angzeng on 2018/7/16.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHShotArticleScrollDelegate <NSObject>

- (void)ShotViewSelectedTable;
- (void)ViewDidScroll;

@end
@interface YHShotArticleViewController : UIViewController
/**
 *  代理
 */
@property(nonatomic,weak) id <YHShotArticleScrollDelegate> delegate;

@end
