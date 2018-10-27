//
//  friendListViewController.h
//  YH_project
//
//  Created by Angzeng on 2018/7/19.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ConversationBlock)(NSDictionary *conversationData);

@protocol FriendDelegate

- (void)ViewdidScroll;

@end

@interface friendListViewController : UITableViewController

@property (nonatomic, copy) ConversationBlock conversationBlock;
@property (nonatomic, weak) id<FriendDelegate> delegate;

@end
