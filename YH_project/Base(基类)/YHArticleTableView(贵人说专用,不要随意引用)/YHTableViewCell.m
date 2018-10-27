//
//  YHTableViewCell.m
//  YH_project
//
//  Created by Angzeng on 2018/6/13.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHTableViewCell.h"
#import "YHTableContentView.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"
@interface YHTableViewCell()<YHSelectCellDelegate>

@property (nonatomic, strong) YHTableContentView *CellcontentView;

@end

@implementation YHTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _CellcontentView = [[YHTableContentView alloc] initWithFrame:CGRectMake(0, 5, YHScreenWidth, (151*YHpx-20)/3)];
        _CellcontentView.delegate = self;
        [self addSubview:_CellcontentView];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //
        CGRect rect = self.frame;
        rect.size.height = _CellcontentView.frame.size.height + 10;
        self.frame = rect;
    }
    return self;
}

- (void)cellSetDataWithDict:(YHArticleModel *)cellModel {
    [_CellcontentView setData:cellModel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark delegate 文章加载方法集
- (void)ViewSelectCellWithId:(NSString *)articleId {
    [self.delegate ViewSelectContentWithId:articleId];
}

@end
