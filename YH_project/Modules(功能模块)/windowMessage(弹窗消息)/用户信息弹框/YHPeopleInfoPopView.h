//
//  YHPeopleInfoPopView.h
//  YH_project
//
//  Created by Angzeng on 2018/5/15.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHUserInfoView.h"

@interface YHPeopleInfoPopView : UIView

@property (nonatomic, strong) YHUserInfoView *UserInfoView;

+ (void)initUserViewWithID:(NSString *)userId;

@end
