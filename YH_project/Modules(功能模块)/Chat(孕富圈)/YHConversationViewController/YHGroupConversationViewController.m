//
//  YHGroupConversationViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/7/30.
//  Copyright © 2018 Angzeng. All rights reserved.
//

#import "YHGroupConversationViewController.h"
#import "FontAndColorMacros.h"

@interface YHGroupConversationViewController ()

@end

@implementation YHGroupConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)setUI {
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont fontWithName:YHFont size:18];
    [leftbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem=leftItem;
    //
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    titleLabel.text = self.title;
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont fontWithName:YHFont size:20];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //
    UISwipeGestureRecognizer *GestureRemoveRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [GestureRemoveRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:GestureRemoveRight];
}

- (void)back {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

@end
