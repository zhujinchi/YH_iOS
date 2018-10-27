//
//  YHArticleUploadViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/6/2.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHArticleUploadViewController.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"

@interface YHArticleUploadViewController ()

@end

@implementation YHArticleUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setUI {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(YHLeftPoint(40), IS_IPHONE_X?YHScreenHeight-75:YHScreenHeight-65, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"icon_font_done"] forState:UIControlStateNormal];
    backBtn.backgroundColor = YHColor_ChineseRed;
    backBtn.layer.cornerRadius = 20;
    [backBtn addTarget:self action:@selector(backToArticleMainView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)backToArticleMainView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
