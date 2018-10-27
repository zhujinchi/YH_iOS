//
//  YHTableView.m
//  YH_project
//
//  Created by Angzeng on 2018/6/13.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHTableView.h"
#import "FontAndColorMacros.h"

@implementation YHTableView

- (instancetype)initWithFrame:(CGRect)frame {
    CGRect tableFrame = frame;
    tableFrame.origin.y = frame.origin.y+50;
    //
    self = [super initWithFrame:tableFrame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.separatorStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
}

@end
