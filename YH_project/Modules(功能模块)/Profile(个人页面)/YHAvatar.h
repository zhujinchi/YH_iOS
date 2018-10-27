//
//  YHAvatar.h
//  YH_project
//
//  Created by Angzeng on 2018/5/16.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHAvatar : UIView

@property BOOL isShowInfo;
@property (nonatomic, strong) UIImageView *AvatarImg;
@property (nonatomic, strong) NSString *userId;

- (void)setAvaterImgWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholder;

@end
