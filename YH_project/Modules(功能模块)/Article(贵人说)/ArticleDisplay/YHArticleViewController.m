//
//  YHArticleViewController.m
//  YH_project
//
//  Created by Angzeng on 2018/6/21.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHArticleViewController.h"
#import "YHWebView.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"

@interface YHArticleViewController ()<UIScrollViewDelegate,WKNavigationDelegate>

@property (nonatomic, strong) YHWebView *ArticleView;
@property (nonatomic, strong) UIView *navigationV;
@property (nonatomic, strong) UILabel *backLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, assign) NSInteger lastcontentOffset;
//计时器属性
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int timeCount;
@property (nonatomic, readwrite) BOOL isViewUP;

@end

@implementation YHArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setUI {
    _isViewUP = NO;
    NSString *articleUrl = [NSString stringWithFormat:@"http://zhujinchi.com/index.php/Web/Article/article_show?aid=%@",_articleId];
    [self setArticleWebView:articleUrl];
    //
    _navigationV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YHScreenWidth, YHTopHeight)];
    _navigationV.backgroundColor = YHColor_ChineseRed;
    //
    _backLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
    _backLabel.text = @"返回";
    _backLabel.textColor = [UIColor whiteColor];
    _backLabel.font = [UIFont fontWithName:YHFont size:18];
    //
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, YHStatusRectHeight+2, 60, 40)];
    _backButton.backgroundColor = [UIColor clearColor];
    [_backButton addTarget:self action:@selector(backToArticleMainView) forControlEvents:UIControlEventTouchUpInside];
    
    [_navigationV addSubview:_backButton];
    [_backButton addSubview:_backLabel];
    
    [self.view addSubview:_navigationV];
}

- (void)setArticleWebView:(NSString *)url {
    _ArticleView = [[YHWebView alloc] initWithFrame:CGRectMake(0, YHTopHeight, YHScreenWidth, YHScreenHeight-YHTopHeight)];
    NSURL *articleUrl = [NSURL URLWithString:url];
    _ArticleView.scrollView.bounces = NO;
    _ArticleView.scrollView.delegate = self;
    _ArticleView.navigationDelegate = self;
    //_ArticleView.scalesPageToFit = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:articleUrl];
    [_ArticleView loadRequest:request];
    [self.view addSubview:_ArticleView];
}

- (void)backToArticleMainView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark WKWebview代理
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
        if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential,card);
        }
}

#pragma mark 滑动方法集合
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat hight = scrollView.frame.size.height;
    CGFloat contentOffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
    CGFloat offset = contentOffset - self.lastcontentOffset;
    self.lastcontentOffset = contentOffset;
    
    if (offset > 0 && contentOffset > 0) {
        [self changeViewByUp];
    }
    if (offset < 0 && distanceFromBottom > hight) {
        [self changeViewByDown];
    }
    if (contentOffset == 0) {
        NSLog(@"滑动到顶部");
    }
    if (distanceFromBottom < hight) {
        NSLog(@"滑动到底部");
    }
}

- (void)changeViewByUp {
    if (!_isViewUP) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect changeFrame = self->_backLabel.frame;
            changeFrame.size.height = 0;
            self->_backLabel.frame = changeFrame;
            //
            changeFrame = self->_backButton.frame;
            changeFrame.size.height = 0;
            self->_backButton.frame = changeFrame;
            //
            changeFrame = self->_ArticleView.frame;
            changeFrame.origin.y = YHStatusRectHeight;
            changeFrame.size.height = YHScreenHeight-YHStatusRectHeight;
            self->_ArticleView.frame = changeFrame;
            //
            changeFrame = self->_navigationV.frame;
            changeFrame.size.height = YHStatusRectHeight;
            self->_navigationV.frame = changeFrame;
        }];
        _isViewUP = !_isViewUP;
    }
}

- (void)changeViewByDown {
    if (_isViewUP) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect changeFrame = self->_ArticleView.frame;
            changeFrame.origin.y = YHTopHeight;
            changeFrame.size.height = YHScreenHeight-YHTopHeight;
            self->_ArticleView.frame = changeFrame;
            //
            changeFrame = self->_navigationV.frame;
            changeFrame.size.height = YHTopHeight;
            self->_navigationV.frame = changeFrame;
            //
            changeFrame = self->_backButton.frame;
            changeFrame.size.height = 40;
            self->_backButton.frame = changeFrame;
            //
            changeFrame = self->_backLabel.frame;
            changeFrame.size.height = 20;
            self->_backLabel.frame = changeFrame;
        }];
        _isViewUP = !_isViewUP;
    }
    
}

- (void)dismissBarView {
    
}

- (void)showBarView {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
