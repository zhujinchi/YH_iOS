//
//  YHProfileView.h
//  YH_project
//
//  Created by Angzeng on 2018/5/14.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHAvatar.h"

@interface YHProfileView : UIView

@property(nonatomic, strong) YHAvatar *AvatarV;

/*profileView专用*/
- (void)pushAvatarV;
- (void)pullAvatarV;

@end
