//
//  YHAnswerViewController.h
//  YH_project
//
//  Created by Angzeng on 2018/7/16.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHAnswerScrollDelegate <NSObject>

- (void)ViewDidScroll;

@end
@interface YHAnswerViewController : UIViewController
/**
 *  代理
 */
@property(nonatomic,weak) id <YHAnswerScrollDelegate> delegate;

@end
