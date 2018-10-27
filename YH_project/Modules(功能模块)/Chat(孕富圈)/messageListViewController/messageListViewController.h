//
//  messageListViewController.h
//  YH_project
//
//  Created by Angzeng on 2018/7/19.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>

typedef void(^ConversationBlock)(NSDictionary *conversationData);
typedef void(^GroupConversationBlock)(NSDictionary *gconversationData);

@protocol messageDelegate

- (void)ViewdidScroll;

@end

@interface messageListViewController : RCConversationListViewController

@property (nonatomic, copy) ConversationBlock conversationBlock;
@property (nonatomic, copy) GroupConversationBlock gconversationBlock;
@property (nonatomic, weak) id <messageDelegate> delegate;

@end
