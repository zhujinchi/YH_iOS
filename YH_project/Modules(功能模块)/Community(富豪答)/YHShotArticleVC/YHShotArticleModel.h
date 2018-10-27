//
//  YHShotArticleModel.h
//  YH_project
//
//  Created by Angzeng on 2018/8/27.
//  Copyright © 2018 Angzeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHShotArticleModel : NSObject

@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *art_url;
@property (nonatomic, copy) NSString *awd_num;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *col_num;
@property (nonatomic, copy) NSString *com_num;
@property (nonatomic, copy) NSString *like_num;
@property (nonatomic, copy) NSString *priority;
@property (nonatomic, copy) NSString *pub_time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *cname;
@property (nonatomic, copy) NSString *view_num;
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *intro;

- (void)setHoleDataWithDict:(NSDictionary *)dict;

@end
