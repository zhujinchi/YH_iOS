//
//  YHArticleModel.m
//  YH_project
//
//  Created by Angzeng on 2018/8/4.
//  Copyright © 2018 Angzeng. All rights reserved.
//

#import "YHArticleModel.h"
#import "YHcommonTool.h"

@implementation YHArticleModel

- (void)setHoleDataWithDict:(NSDictionary *)dict {
    self.aid = dict[@"aid"];
    self.art_url = dict[@"art_url"];
    self.awd_num = dict[@"awd_num"];
    self.avatar = [NSString stringWithFormat:@"http://%@",dict[@"avatar"]];
    self.col_num = dict[@"col_num"];
    self.com_num = dict[@"com_num"];
    self.like_num = dict[@"like_num"];
    self.priority = dict[@"priority"];
    self.pub_time = dict[@"pub_time"];
    self.title = [YHcommonTool filtratSpecialCodeWithString:dict[@"title"]];
    self.uid = dict[@"uid"];
    self.uname = dict[@"uname"];
    self.view_num = dict[@"view_num"];
    //NSLog(@"%@",[dict[@"img_url"][0] class]);
    self.img_url = ([(NSArray *)dict[@"img_url"] count] > 0)?dict[@"img_url"][0]:@"";
}

@end
