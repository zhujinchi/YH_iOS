//
//  YHDataManager.h
//  YH_project
//
//  Created by Angzeng on 2018/5/31.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHDataManager;
//block回调传值
/**
 *   请求成功回调json数据
 *
 *  @param json json串
 */
typedef void(^Success)(id json);
/**
 *  请求失败回调错误信息
 *
 *  @param error error错误信息
 */
typedef void(^Failure)(NSError *error);

@interface YHDataManager : NSObject
@property (copy, nonatomic) Success successBlock;
@property (copy, nonatomic) Failure failureBlock;
@property (strong, nonatomic) id tempDict;
//单例模式
+ (YHDataManager *)manager;

/**
 *  GET请求
 */
- (void)getDataWithUrl:(NSString *)url Parameters:(NSDictionary *)paramters Block:(void(^)(id dict)) block;

/**
 *  POST请求
 */
- (void)postDataWithUrl:(NSString *)url Parameters:(NSDictionary *)paramters Block:(void(^)(id dict)) block;


@end
