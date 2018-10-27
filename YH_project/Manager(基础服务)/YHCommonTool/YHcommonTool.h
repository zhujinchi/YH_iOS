//
//  YHcommonTool.h
//  YH_project
//
//  Created by Angzeng on 2018/7/29.
//  Copyright © 2018 Angzeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YHcommonTool : NSObject

//过滤特殊字符
+ (NSString *)filtratSpecialCodeWithString:(NSString *)string;
//长方形图片处理
+ (UIImage*)getSubImage:(UIImage *)image centerBool:(BOOL)centerBool;
//方形图片处理
+ (UIImage *)circleImage:(UIImage*)image withParam:(CGFloat)inset;
//设置图片透明度
+ (UIImage *)imageByApplyingAlpha:(CGFloat )alpha image:(UIImage*)image;
@end
