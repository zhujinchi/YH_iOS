//
//  YHIntroduceView.m
//  YH_project
//
//  Created by Angzeng on 2018/5/16.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHIntroduceView.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"

@interface YHIntroduceView()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation YHIntroduceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(2*YHpx, 2*YHpx, 10*YHpx, 10*YHpx)];
    titleView.layer.cornerRadius = 5*YHpx;
    [titleView setImage:[UIImage imageNamed:@"icon_font_note"]];
    [self addSubview:titleView];
    //
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(56, 3, 100*YHpx-93, 114)];
    [_textView setEditable:NO];
    _textView.font = [UIFont fontWithName:YHFont size:16*FontPx];
    [self addSubview:_textView];
}

- (void)setTextWithString:(NSString *)text {
    _textView.text = text;
}

@end
