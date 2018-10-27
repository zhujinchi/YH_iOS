//
//  AnswerTableViewCell.m
//  YH_project
//
//  Created by Angzeng on 2018/7/17.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "AnswerTableViewCell.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "AnswerContentView.h"

@implementation AnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        AnswerContentView *CellcontentView = [[AnswerContentView alloc] initWithFrame:CGRectMake(0, 5, YHScreenWidth, (124*YHpx-20)/3)];
        [self addSubview:CellcontentView];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //
        NSDictionary *dataDict = [NSDictionary new];
        [CellcontentView setData:dataDict];
        //
        CGRect rect = self.frame;
        rect.size.height = CellcontentView.frame.size.height + 10;
        self.frame = rect;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
