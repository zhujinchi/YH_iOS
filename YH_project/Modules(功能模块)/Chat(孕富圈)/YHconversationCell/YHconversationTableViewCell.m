//
//  YHconversationTableViewCell.m
//  YH_project
//
//  Created by Angzeng on 2018/7/29.
//  Copyright © 2018 Angzeng. All rights reserved.
//

#import "YHconversationTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"
#import "YHcommonTool.h"

@interface YHconversationTableViewCell()

@property (nonatomic, strong) UIImageView *cellImageview;
@property (nonatomic, strong) UILabel *cellTitle;
@property (nonatomic, readwrite) int type;

@end

@implementation YHconversationTableViewCell

- (void)setUI {
    self.backgroundColor = YHColor_LightGray;
    _cellImageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 46, 46)];
    _cellImageview.layer.cornerRadius = 23;
    _cellImageview.clipsToBounds = YES;
    _cellImageview.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_cellImageview];
    _cellTitle = [[UILabel alloc] initWithFrame:CGRectMake(66, 10, 200, 23)];
    _cellTitle.font = [UIFont fontWithName:YHFont size:16*FontPx];
    [self.contentView addSubview:_cellTitle];
    self.selectionStyle = YES;
    //
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = YHColor_tapBackColor;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellUIWithImageUrl:(NSString *)imgurl Name:(NSString *)cellname Id:(NSString *)cellid Type:(int)type{
    //setimage
    [_cellImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",imgurl]] placeholderImage:[UIImage imageNamed:@"imfomation_icon_default"]];
    //setname
    _cellTitle.text = cellname;
    self.cellName = cellname;
    //setid
    self.cellId = cellid;
    //settype
    self.type = type;
}

@end
