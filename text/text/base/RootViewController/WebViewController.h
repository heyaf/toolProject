//
//  WebViewController.h
//  hongxiuzhao
//
//  Created by 胡古古 on 2018/9/6.
//  Copyright © 2018年 hugugu. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController

@property (nonatomic,copy) NSString *webUrl;

@property (nonatomic,strong) WKWebView *webView;

@end
