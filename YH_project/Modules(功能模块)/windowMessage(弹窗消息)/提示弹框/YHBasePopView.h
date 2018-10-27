//
//  YHBasePopView.h
//  YH_project
//
//  Created by Angzeng on 2018/5/16.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHIntroduceView.h"

@interface YHBasePopView : UIView

@property (nonatomic, strong) YHIntroduceView *IntroInfoView;

+ (void)initIntroViewWithText:(NSString *)text;

@end
