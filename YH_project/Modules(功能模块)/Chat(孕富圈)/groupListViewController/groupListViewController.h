//
//  groupListViewController.h
//  YH_project
//
//  Created by Angzeng on 2018/7/19.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GroupConversationBlock)(NSDictionary *gconversationData);

@protocol GroupDelegate

- (void)ViewdidScroll;

@end

@interface groupListViewController : UITableViewController

@property (nonatomic, copy) GroupConversationBlock gconversationBlock;
@property (nonatomic, weak) id <GroupDelegate> delegate;

@end
