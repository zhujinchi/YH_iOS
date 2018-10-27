//
//  YHResetViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/9/18.
//  Copyright © 2018 Angzeng. All rights reserved.
//

#import "YHResetViewController.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"

@interface YHResetViewController ()

@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UITextField *checkField;

@end

@implementation YHResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setUI {
    self.view.backgroundColor = YHColor_ChineseRed;
    //
    //输入框背景视图
    UIView *inputBackView = [[UIView alloc] initWithFrame:CGRectMake(YHLeftPoint(75*YHpx), 0.34*YHScreenHeight, 75*YHpx, 48*YHpx)];
    inputBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:inputBackView];
    //账号
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75*YHpx, 12*YHpx)];
    accountView.backgroundColor = [UIColor whiteColor];
    accountView.layer.cornerRadius = 2*YHpx;
    [inputBackView addSubview:accountView];
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(1*YHpx, 1*YHpx, 24*YHpx, 10*YHpx)];
    accountLabel.backgroundColor = YHColor_Black;
    accountLabel.layer.cornerRadius = 2*YHpx;
    accountLabel.clipsToBounds = YES;
    accountLabel.text = @"用户名";
    accountLabel.font = [UIFont fontWithName:YHFont size:18*FontPx];
    accountLabel.textAlignment = NSTextAlignmentCenter;
    accountLabel.textColor = YHColor_DarkGray;
    accountLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *accountGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputAccount)];
    [accountLabel addGestureRecognizer:accountGesture];
    [accountView addSubview:accountLabel];
    
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(28*YHpx, 1*YHpx, 44*YHpx, 10*YHpx)];
    _accountField.backgroundColor = [UIColor whiteColor];
    _accountField.keyboardType = UIKeyboardTypeNumberPad;
    _accountField.font = [UIFont fontWithName:YHFont size:18*FontPx];
    _accountField.clearButtonMode = UITextFieldViewModeAlways;
    _accountField.placeholder = @"请输入手机号";
    [accountView addSubview:_accountField];
    //密码
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(0, 18*YHpx, 75*YHpx, 12*YHpx)];
    passwordView.backgroundColor = [UIColor whiteColor];
    passwordView.layer.cornerRadius = 2*YHpx;
    [inputBackView addSubview:passwordView];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(1*YHpx, 1*YHpx, 24*YHpx, 10*YHpx)];
    passwordLabel.backgroundColor = YHColor_Black;
    passwordLabel.layer.cornerRadius = 2*YHpx;
    passwordLabel.clipsToBounds = YES;
    passwordLabel.text = @"密 码";
    passwordLabel.font = [UIFont fontWithName:YHFont size:18*FontPx];
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    passwordLabel.textColor = YHColor_DarkGray;
    passwordLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *passwordGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputPassword)];
    [passwordLabel addGestureRecognizer:passwordGesture];
    [passwordView addSubview:passwordLabel];
    
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(28*YHpx, 1*YHpx, 44*YHpx, 10*YHpx)];
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.font = [UIFont fontWithName:YHFont size:18*FontPx];
    _passwordField.clearButtonMode = UITextFieldViewModeAlways;
    _passwordField.placeholder = @"请输入密码";
    _passwordField.returnKeyType = UIReturnKeyDone;
    [passwordView addSubview:_passwordField];
    //验证码
    UIView *checkView = [[UIView alloc] initWithFrame:CGRectMake(0, 36*YHpx, 75*YHpx, 12*YHpx)];
    checkView.backgroundColor = [UIColor whiteColor];
    checkView.layer.cornerRadius = 2*YHpx;
    [inputBackView addSubview:checkView];
    
    UILabel *checkLabel = [[UILabel alloc] initWithFrame:CGRectMake(1*YHpx, 1*YHpx, 24*YHpx, 10*YHpx)];
    checkLabel.backgroundColor = YHColor_Black;
    checkLabel.layer.cornerRadius = 2*YHpx;
    checkLabel.clipsToBounds = YES;
    checkLabel.text = @"验证码";
    checkLabel.font = [UIFont fontWithName:YHFont size:18*FontPx];
    checkLabel.textAlignment = NSTextAlignmentCenter;
    checkLabel.textColor = YHColor_DarkGray;
    checkLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *checkGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputCheck)];
    [checkLabel addGestureRecognizer:checkGesture];
    [checkView addSubview:checkLabel];
    
    UIButton *getCheck = [[UIButton alloc] initWithFrame:CGRectMake(60*YHpx, 1*YHpx, 14*YHpx, 10*YHpx)];
    getCheck.backgroundColor = YHColor_Black;
    getCheck.layer.cornerRadius = 2*YHpx;
    [checkView addSubview:getCheck];
    //
    UIButton *Register = [[UIButton alloc] initWithFrame:CGRectMake(YHLeftPoint(55*YHpx), 0.76*YHScreenHeight, 55*YHpx/*200*/, 11*YHpx)];
    Register.layer.cornerRadius = 5;
    Register.backgroundColor = YHColor_Black;
    [Register setTitle:@"重    置" forState:UIControlStateNormal];
    Register.titleLabel.textAlignment = NSTextAlignmentCenter;
    Register.titleLabel.font = [UIFont fontWithName:YHFont size:18*FontPx];
    [Register setTitleColor:YHColor_DarkRed forState:UIControlStateNormal];
    //[Register addTarget:self action:@selector(RegisterSucceed) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:Register];
    //
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(YHLeftPoint(11*YHpx), IS_IPHONE_X?YHScreenHeight-26*YHpx:YHScreenHeight-24*YHpx, 11*YHpx, 11*YHpx)];
    [backBtn setTitle:@"毕" forState:UIControlStateNormal];
    backBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    backBtn.titleLabel.font = [UIFont fontWithName:YHFont size:22*FontPx];
    [backBtn setTitleColor:YHColor_ChineseRed forState:UIControlStateNormal];
    backBtn.backgroundColor = YHColor_WhiteGray;
    backBtn.layer.cornerRadius = 5.5*YHpx;
    [backBtn addTarget:self action:@selector(backToLoginView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    //
}

- (void)inputAccount {
    [_accountField becomeFirstResponder];
}

- (void)inputPassword {
    [_passwordField becomeFirstResponder];
}

- (void)inputCheck {
    [_checkField becomeFirstResponder];
}

- (void)backToLoginView {
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
