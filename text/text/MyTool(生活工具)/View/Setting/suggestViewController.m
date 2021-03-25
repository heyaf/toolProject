//
//  suggestViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/29.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "suggestViewController.h"
#import "XXTextView.h"

@interface suggestViewController ()

@property (weak, nonatomic) IBOutlet UITextField *connectTX;
@property (weak, nonatomic) IBOutlet UIButton *submitBTN;

@property (nonatomic,strong) XXTextView *suggestTextview;



@end

@implementation suggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(242, 242, 242);
   
    self.navigationItem.title = @"意见反馈";
    
    // Do any additional setup after loading the view from its nib.
    [self creatUI];
}
-(void)viewWillAppear:(BOOL)animated{
    

   self.navigationController.navigationBarHidden = NO;
}
-(void)creatUI{

    _suggestTextview = [[XXTextView alloc] initWithFrame:CGRectMake(20, 20, kScreenW-40, 130)];
    _suggestTextview.backgroundColor = kWhiteColor;
    _suggestTextview.xx_placeholderFont = [UIFont systemFontOfSize:16.0f];
    _suggestTextview.xx_placeholderColor = RGBA(246, 246, 246, 1);
    _suggestTextview.xx_placeholder = @"请输入您的宝贵意见，我们将第一时间关注，不断优化和改进！";
    [self.view addSubview:_suggestTextview];


}
-(void)viewWillDisappear:(BOOL)animated{

//    self.navigationController.navigationBarHidden =YES;
}
- (IBAction)submitbtn:(id)sender {

    if (self.suggestTextview.text.length>0) {
        
            MBProgressHUD *hud = [[MBProgressHUD alloc]init];
            
            [[UIApplication sharedApplication].keyWindow addSubview:hud];
            [hud setMode:MBProgressHUDModeIndeterminate];
            
            hud.labelText = @"谢谢您的支持，我们将尽快改进";
            
            [hud show:YES];
            
            [hud hide:YES afterDelay:1.0f];
        
            
            self.suggestTextview.text = @"";
            [self.navigationController popViewControllerAnimated:YES];

    }else{
        MBProgressHUD *hud = [[MBProgressHUD alloc]init];
        [[UIApplication sharedApplication].keyWindow addSubview:hud];
        [hud setMode:MBProgressHUDModeIndeterminate];
        
        hud.labelText = @"请输入您的宝贵意见";
        
        [hud show:YES];
        
        [hud hide:YES afterDelay:1.0f];
        
    }


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
