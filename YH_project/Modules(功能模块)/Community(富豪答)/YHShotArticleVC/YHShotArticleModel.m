//
//  YHShotArticleModel.m
//  YH_project
//
//  Created by Angzeng on 2018/8/27.
//  Copyright © 2018 Angzeng. All rights reserved.
//

#import "YHShotArticleModel.h"
#import "YHcommonTool.h"

@implementation YHShotArticleModel

- (void)setHoleDataWithDict:(NSDictionary *)dict {
    NSLog(@"%@",dict);
    self.aid = dict[@"aid"];
    self.art_url = dict[@"art_url"];
    self.awd_num = dict[@"awd_num"];
    //1
    self.avatar = [NSString stringWithFormat:@"http://%@",dict[@"avatar"]];
    self.col_num = dict[@"col_num"];
    self.com_num = dict[@"com_num"];
    self.like_num = dict[@"like_num"];
    self.priority = dict[@"priority"];
    self.pub_time = dict[@"pub_time"];
    self.title = [YHcommonTool filtratSpecialCodeWithString:dict[@"title"]];
    self.cid = dict[@"cid"];
    self.cname = dict[@"cname"];
    self.view_num = dict[@"view_num"];
    //NSLog(@"%@",[dict[@"img_url"][0] class]);
    self.img_url = ([(NSArray *)dict[@"img_url"] count] > 0)?dict[@"img_url"][0]:@"";
    self.intro = [YHcommonTool filtratSpecialCodeWithString:dict[@"introduce"]];
}

@end
