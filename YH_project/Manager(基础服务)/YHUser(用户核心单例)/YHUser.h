//
//  YHUser.h
//  YH_project
//
//  Created by Angzeng on 2018/5/30.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "friendListModel.h"

@interface YHUser : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userMobile;
@property (nonatomic, strong) NSString *userAuthorization;
@property (nonatomic, strong) NSString *userAvater;
@property (nonatomic, strong) NSString *userBirthday;
@property (nonatomic, strong) NSString *userAlipay;
@property (nonatomic, strong) NSString *userGender;
@property (nonatomic, strong) NSString *userLabel;
@property (nonatomic, strong) NSArray *abilityMode;   //用户模型数据
@property (nonatomic, strong) NSMutableArray<friendListModel *> *userFriendList;//用户好友列表
@property (nonatomic, strong) NSArray<NSString *> *userGroupList;//用户组列表

/**
 * 单例模式用户信息存储
 */
+ (instancetype)shareInstance;

- (void)setLoginUserData:(id)dict;

@end
