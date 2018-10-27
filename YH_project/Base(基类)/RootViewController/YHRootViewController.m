//
//  YHRootViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/5/14.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHRootViewController.h"
#import "YHLogInViewController.h"

@interface YHRootViewController ()

@end

@implementation YHRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLogInView];
}

- (void)setLogInView {
    YHLogInViewController *logInVC = [[YHLogInViewController alloc] init];
    [self presentViewController:logInVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
