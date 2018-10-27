//
//  YHconversationTableViewCell.h
//  YH_project
//
//  Created by Angzeng on 2018/7/29.
//  Copyright © 2018 Angzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

@interface YHconversationTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *cellName;
@property (nonatomic, strong) NSString *cellId;
@property BOOL isLoad;
- (void)setCellUIWithImageUrl:(NSString *)imgurl Name:(NSString *)cellname Id:(NSString *)cellid Type:(int)type;
- (void)setUI;

@end
