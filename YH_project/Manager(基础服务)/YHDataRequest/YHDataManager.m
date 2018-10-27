//
//  YHDataManager.m
//  YH_project
//
//  Created by Angzeng on 2018/5/31.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHDataManager.h"
#import "AFNetworking.h"
#import "YHUser.h"

static YHDataManager *manager = nil;
static AFHTTPSessionManager *afnManager = nil;

@interface YHDataManager()

@property (nonatomic, strong) id Dict;

@end

@implementation YHDataManager
/**
 *  创建单例
 *
 *  @return dict
 */
+ (YHDataManager *)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YHDataManager alloc] init];
        afnManager = [AFHTTPSessionManager manager];
        afnManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return manager;
}

- (void)postDataWithUrl:(NSString *)url Parameters:(NSDictionary *)paramters Block:(void(^)(id dict)) block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置回复内容信息
    [manager.requestSerializer setValue:[YHUser shareInstance].userAuthorization forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:url
       parameters:paramters//请求参数
          success:^(AFHTTPRequestOperation * operation, id responseObject){
              NSData *data=[operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
              id dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              block(dict);
          }
          failure:^(AFHTTPRequestOperation * operation, NSError * error) {
              NSLog(@"NoNetWork");
          }];
}

- (void)getDataWithUrl:(NSString *)url Parameters:(NSDictionary *)paramters Block:(void(^)(id dict)) block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置回复内容信息
    [manager.requestSerializer setValue:[YHUser shareInstance].userAuthorization forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager  GET:url
       parameters:paramters//请求参数
          success:^(AFHTTPRequestOperation * operation, id responseObject){
              NSData *data=[operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
              id dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              block(dict);
          }
          failure:^(AFHTTPRequestOperation * operation, NSError * error) {
              NSLog(@"NoNetWork");
          }];
}



@end
