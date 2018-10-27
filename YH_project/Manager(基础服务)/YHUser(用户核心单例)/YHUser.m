//
//  YHUser.m
//  YH_project
//
//  Created by Angzeng on 2018/5/30.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHUser.h"

@implementation YHUser

static YHUser *_instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self){
        if (nil == _instance) {
            _instance = [super allocWithZone:zone];
        }
        return _instance;
    }
}

+ (instancetype)shareInstance {
    @synchronized(self){
        if (nil == _instance) {
            _instance = [[self alloc] init];
        }
        return _instance;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

- (void)setLoginUserData:(id)dict {
    [self setUserId:[dict valueForKey:@"uid"]];
    [self setUserName:[dict valueForKey:@"uname"]];
    [self setUserAvater:[dict valueForKey:@"avatar"]];
    [self setUserAuthorization:[dict valueForKey:@"jwt"]];
    [self setUserGender:[[dict valueForKey:@"gender"] isEqualToString:@"0"]?@"man":@"woman"];
}

@end
