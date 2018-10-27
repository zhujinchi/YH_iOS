//
//  ShotArticleTableViewCell.m
//  YH_project
//
//  Created by Angzeng on 2018/7/19.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "ShotArticleTableViewCell.h"
#import "ShotArticleContentView.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"

@interface ShotArticleTableViewCell()<ShotCellDelegate>

@property (nonatomic, strong) ShotArticleContentView *CellcontentView;

@end

@implementation ShotArticleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _CellcontentView = [[ShotArticleContentView alloc] initWithFrame:CGRectMake(0, 5, YHScreenWidth, (151*YHpx-20)/3)];
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

- (void)cellSetDataWithDict:(YHShotArticleModel *)cellModel {
    [_CellcontentView setData:cellModel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark ShotArticleContentViewDelegate
- (void)ShotSelectCell {
    [self.delegate ShotVSelectContent];
}

@end
