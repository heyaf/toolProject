//
//  MCBackImageViewViewController.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/30.
//

#import "MCBackImageViewViewController.h"

@interface MCBackImageViewViewController ()

@end

@implementation MCBackImageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavButton];
}
-(void)setNavButton{

    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
   UIButton *leftbtn =[UIButton buttonWithType:UIButtonTypeCustom];
   leftbtn.frame = CGRectMake(-10, -5, 36, 36);
   [leftbtn setImage:[UIImage imageNamed:@"back04"] forState:UIControlStateNormal];
   [leftbtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
   [leftView addSubview:leftbtn];
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
