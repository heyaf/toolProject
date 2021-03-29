//
//  MCsetDetailViewController.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import "MCsetDetailViewController.h"
#import <SVProgressHUD.h>

@interface MCsetDetailViewController ()

@end

@implementation MCsetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.navigationItem.title = self.Title;
    
    UITextView *textfile = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, kScreenHeight-20)];
    textfile.userInteractionEnabled = NO;
    
    textfile.text = self.message;
    textfile.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textfile];
    
    UIButton *button = [UIButton buttonWithType:0];
    [button setTitle:@"点击复制客服微信" forState:0];
//    button.frame = CGRectMake(0, 0, 120, 20);
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:kBlackColor forState:0];
    kViewBorderRadius(button, 5, .5, kRedColor);
    [button addTarget:self action:@selector(ButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    rightItem.imageInsets = UIEdgeInsetsMake(0, 0,0, 0);//设置向左偏移
    
    if ([self.hasKefu isEqualToString:@"YES"]) {
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}
- (void)ButtonClicked{
    [UIPasteboard generalPasteboard].string =@"ccc666888ooo";
    [SVProgressHUD showSuccessWithStatus:@"客服微信号已复制到粘贴板"];
}


@end
