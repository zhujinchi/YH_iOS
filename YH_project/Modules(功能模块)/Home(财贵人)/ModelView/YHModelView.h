//
//  YHModelView.h
//  YH_project
//
//  Created by Angzeng on 2018/5/15.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHAvatar.h"

@interface YHModelView : UIView

@property (nonatomic ,strong) YHAvatar *AvatarV;
@property (nonatomic, strong) NSString *ModelValueStr;

- (void)setDateForInfoViewWithDict:(NSDictionary *)dict;

@end
