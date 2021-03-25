//
//  WebViewController.m
//  hongxiuzhao
//
//  Created by 胡古古 on 2018/9/6.
//  Copyright © 2018年 hugugu. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<WKNavigationDelegate>



@end

@implementation WebViewController

- (WKWebView *)webView {
    if (nil == _webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self.view addSubview:self.webView];
  
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
}

- (void)setNav {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(-5, 0, 30, 30)];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateHighlighted];
    [view addSubview:btn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    UIView *viewtwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    viewtwo.backgroundColor = [UIColor clearColor];
    UIButton *btntwo = [[UIButton alloc]initWithFrame:CGRectMake(-5, 0, 30, 30)];
    [btntwo addTarget:self action:@selector(clickPopButton) forControlEvents:UIControlEventTouchUpInside];
    [btntwo setImage:[UIImage imageNamed:@"tuichu"] forState:UIControlStateNormal];
    [btntwo setImage:[UIImage imageNamed:@"tuichu"] forState:UIControlStateHighlighted];
    [viewtwo addSubview:btntwo];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:viewtwo];
    
}

-(void)pop {
    
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
        [cookieStorage deleteCookie:cookie];
    }
    

    if (self.webView.canGoBack == YES) {
        
        [self.webView goBack];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)clickPopButton {
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];

    for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
        [cookieStorage deleteCookie:cookie];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *htmlTitle = @"document.title";
    NSString *titleHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:htmlTitle];

    self.title = titleHtmlInfo;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

        NSString *url = [request.URL absoluteString];

        
    if ([url rangeOfString:@"http://www.baidu.com"].location != NSNotFound) {
            

            [self.navigationController popViewControllerAnimated:YES];
            
        
            return NO;
    }
    
    if ([url rangeOfString:@"http://www.taobao.com"].location != NSNotFound) {
       
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        return NO;
    }
    
    if ([url rangeOfString:@"http://139.224.239.47:8080/error"].location != NSNotFound) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
      
        
        return NO;
    }
    
    return YES;
}


@end
