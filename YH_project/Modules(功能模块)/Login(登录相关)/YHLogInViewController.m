//
//  YHLogInViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/5/14.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHLogInViewController.h"
#import "YHUser.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"
#import "URLMacros.h"
#import "YHDataManager.h"
#import "YHTabBarController.h"
#import "YHAlertView.h"
#import <MJExtension/MJExtension.h>
#import <CommonCrypto/CommonDigest.h>
#import "YHResetViewController.h"
#import "YHRegisterViewController.h"
#import "YHAlertView.h"

@interface YHLogInViewController ()

@property (nonatomic, strong) YHRegisterViewController *registerVC;
@property (nonatomic, strong) YHResetViewController *resetVC;
@property (nonatomic, readwrite) Boolean isLogin;
@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) NSString *getAccount;
@property (nonatomic, strong) NSString *getPassword;


@end

@implementation YHLogInViewController

#pragma mark 生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    _isLogin = false;
    [self setUI];
}

#pragma mark 页面样式设置

- (void)setUI {
    self.view.backgroundColor = YHColor_ChineseRed;
    //
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(YHLeftPoint(48*YHpx), 0.08*YHScreenHeight, 48*YHpx, 48*YHpx)];
    [iconView setImage:[UIImage imageNamed:@"icon_round"]];
    //[self.view addSubview:iconView];
    //输入框背景视图
    UIView *inputBackView = [[UIView alloc] initWithFrame:CGRectMake(YHLeftPoint(75*YHpx), 0.4*YHScreenHeight, 75*YHpx, 38*YHpx)];
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
    _passwordField.secureTextEntry = YES;
    _passwordField.font = [UIFont fontWithName:YHFont size:18*FontPx];
    _passwordField.clearButtonMode = UITextFieldViewModeAlways;
    _passwordField.placeholder = @"请输入密码";
    _passwordField.returnKeyType = UIReturnKeyDone;
    [passwordView addSubview:_passwordField];
    //
    UIButton *Login = [[UIButton alloc] initWithFrame:CGRectMake(YHLeftPoint(55*YHpx), 0.76*YHScreenHeight, 55*YHpx/*200*/, 11*YHpx)];
    Login.layer.cornerRadius = 5;
    Login.backgroundColor = [UIColor colorWithRed:149/255.0 green:133/255.0 blue:71/255.0 alpha:1];
    [Login setTitle:@"登    录" forState:UIControlStateNormal];
    Login.titleLabel.textAlignment = NSTextAlignmentCenter;
    Login.titleLabel.font = [UIFont fontWithName:YHFont size:18*FontPx];
    Login.titleLabel.textColor = YHColor_WhiteGray;
    [Login addTarget:self action:@selector(LogIn) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:Login];
    //
    UILabel *resetLabel = [[UILabel alloc] initWithFrame:CGRectMake(6*YHpx, 0.85*YHScreenHeight, 25*YHpx, 6*YHpx)];
    resetLabel.text = @"忘记密码？";
    resetLabel.font = [UIFont fontWithName:YHFont size:14*FontPx];
    resetLabel.textColor = YHColor_WhiteGray;
    resetLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:resetLabel];
    //
    UIButton *reset = [[UIButton alloc] initWithFrame:CGRectMake(31*YHpx, 0.85*YHScreenHeight, 15*YHpx, 6*YHpx)];
    reset.layer.cornerRadius = 1*YHpx;
    [reset setTitle:@"重 置" forState:UIControlStateNormal];
    reset.titleLabel.font = [UIFont fontWithName:YHFont size:13*FontPx];
    [reset setTitleColor:YHColor_DarkRed forState:UIControlStateNormal];
    reset.backgroundColor = YHColor_Black;
    [reset addTarget:self action:@selector(goResetVC) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:reset];
    //
    UIView *orline = [[UIView alloc] initWithFrame:CGRectMake(50*YHpx, 0.85*YHScreenHeight, 1, 6*YHpx)];
    orline.backgroundColor = YHColor_WhiteGray;
    [self.view addSubview:orline];
    //
    UILabel *registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(53*YHpx, 0.85*YHScreenHeight, 23*YHpx, 6*YHpx)];
    registerLabel.text = @"尚无密码？";
    registerLabel.font = [UIFont fontWithName:YHFont size:14*FontPx];
    registerLabel.textColor = YHColor_WhiteGray;
    registerLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:registerLabel];
    //
    UIButton *registerAccount = [[UIButton alloc] initWithFrame:CGRectMake(76*YHpx, 0.85*YHScreenHeight, 15*YHpx, 6*YHpx)];
    registerAccount.layer.cornerRadius = 1*YHpx;
    [registerAccount setTitle:@"注 册" forState:UIControlStateNormal];
    registerAccount.titleLabel.font = [UIFont fontWithName:YHFont size:13*FontPx];
    [registerAccount setTitleColor:YHColor_DarkRed forState:UIControlStateNormal];
    registerAccount.backgroundColor = YHColor_Black;
    [registerAccount addTarget:self action:@selector(goRegisterVC) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:registerAccount];
}

- (void)inputAccount {
    [_accountField becomeFirstResponder];
}

- (void)inputPassword {
    [_passwordField becomeFirstResponder];
}

- (void)goRegisterVC {
    _registerVC = [[YHRegisterViewController alloc] init];
    [self presentViewController:_registerVC animated:YES completion:nil];
}

- (void)goResetVC {
    _resetVC = [[YHResetViewController alloc] init];
    [self presentViewController:_resetVC animated:YES completion:nil];
}

#pragma mark 页面方法设置

- (BOOL)checkAccount:(NSString *)Account{
    NSString *pattern = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:Account];
    return !isMatch;
}

- (BOOL)checkPassword:(NSString *)password{
    NSString *pattern =@"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return !isMatch;
}

- (void)LogIn {
    if (_isLogin) {
        return;
    }
    _getAccount = self.accountField.text;
    _getPassword = self.passwordField.text;
    if (_getAccount.length == 0) {
        [YHAlertView initAlertViewWithText:@"请输入手机号。" Second:3];
        return;
    }
    if ([self checkAccount:_getAccount]) {
        [YHAlertView initAlertViewWithText:@"请输入正确的手机号。" Second:3];
        return;
    }
    if (_getPassword.length == 0) {
        [YHAlertView initAlertViewWithText:@"请输入密码。" Second:3];
        return;
    }
    if ([self checkPassword:_getPassword]) {
        [YHAlertView initAlertViewWithText:@"密码各式错误（请输入6到20位字母大小写以及数字组成的密码）。" Second:5];
        return;
    }
    NSDictionary *parameters = @{@"type":@"0",@"mobile":_getAccount,@"password":[self MD5enc:_getPassword With:_getAccount]};
    [[YHDataManager manager] postDataWithUrl:YHurl_login Parameters:parameters Block:^(id dict) {
        if ([dict[@"code"] isEqual:@200]) {
            [[YHUser shareInstance] setLoginUserData:dict[@"data"][0]];/*设置用户登录数据*/
            [self LogInSucceed];/*用户登录成功*/
        }else {
            [YHAlertView initAlertViewWithText:@"登录失败，请检查用户名和密码。" Second:3];
        }
    }];
}

- (void)LogInSucceed {
    NSLog(@"%@",[YHUser shareInstance].userGender);
    YHTabBarController *YHTabBarVC = [[YHTabBarController alloc] init];
    [self presentViewController:YHTabBarVC animated:YES completion:nil];
}

- (NSString *)MD5enc:(NSString *) secret With:(NSString *)salt{
    secret = [self md5:[NSString stringWithFormat:@"%@%@",secret,salt]];
    salt = [self md5:[NSString stringWithFormat:@"%@%@",secret,salt]];
    secret = [self md5:[NSString stringWithFormat:@"%@%@yinghui",secret,salt]];
    return secret;
}

- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

#pragma mark 内存预警

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
