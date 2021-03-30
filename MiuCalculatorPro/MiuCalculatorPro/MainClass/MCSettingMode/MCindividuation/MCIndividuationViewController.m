//
//  MCIndividuationViewController.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/30.
//

#import "MCIndividuationViewController.h"
#import "MCSelectColorVC.h"
@interface MCIndividuationViewController ()
@property(nonatomic, strong) UISwitch *pushSwitch;

@property (nonatomic,strong) UIView *colorView;

@end

@implementation MCIndividuationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = kRGB(245, 245, 245);
    [self creatUI];
    [self setNavButton];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *colorStr = kGetUserDefaults(KSelColor);
    self.colorView.backgroundColor = [UIColor colorWithHexString:colorStr alpha:1];
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
-(void)creatUI{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight)];
    navView.backgroundColor = kWhiteColor;
    [self.view addSubview:navView];
    self.navigationItem.title = @"个性化";
    
    
    UIView *swithcView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+10, kScreenWidth, 48)];
    swithcView.backgroundColor = kWhiteColor;
    [self.view addSubview:swithcView];
    
    UILabel *switchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 24)];
    switchLabel.text = @"启动动画";
    switchLabel.font = [UIFont systemFontOfSize:15];
    [swithcView addSubview:switchLabel];
    
    //将开关添加到控制器的View
   [swithcView addSubview:self.pushSwitch];
    self.pushSwitch.centerY = swithcView.height/2;
   //设置开关切换事件
   [self.pushSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    NSString *str = kGetUserDefaults(KHomeAnimaOpen);
    if (str.length>2) {
        self.pushSwitch.on = YES;
    }else{
        self.pushSwitch.on = NO;
    }
    
    UIView *swithcView1 = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+68, kScreenWidth, 48)];
    swithcView1.backgroundColor = kWhiteColor;
    [self.view addSubview:swithcView1];
    
    UILabel *switchLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 24)];
    switchLabel1.text = @"主题颜色";
    switchLabel1.font = [UIFont systemFontOfSize:15];
    [swithcView1 addSubview:switchLabel1];
    
    UIImageView *rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-27, 15, 12, 18)];
    rightArrow.image = [UIImage imageNamed:@"rightArrow"];
    [swithcView1 addSubview:rightArrow];
    
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-30-10-30, 9, 30, 30)];
    NSString *colorStr = kGetUserDefaults(KSelColor);
    
    colorView.backgroundColor = [UIColor colorWithHexString:colorStr alpha:1];
    [swithcView1 addSubview:colorView];
    self.colorView = colorView;
    
    
    UIButton *selectBtn = [UIButton buttonWithType:0];
    selectBtn.frame = CGRectMake(kScreenWidth-200, 0, 200, 48);
    [swithcView1 addSubview:selectBtn];
    [selectBtn addTarget:self action:@selector(selectColor) forControlEvents:UIControlEventTouchUpInside];
    

}
/**
 * 懒加载按钮开关
 */
- (UISwitch *)pushSwitch {
    if (_pushSwitch == nil) {
        _pushSwitch = [[UISwitch alloc] init];
        //位置的x,y可以改，但是按钮宽、高不可以改，就算设置了也没效果
        _pushSwitch.frame = CGRectMake(kScreenWidth-70, 10, 80, 40);
        

    }
    return _pushSwitch;
}
- (void)switchChange:(UISwitch*)sw {
    if(sw.on == YES) {
        kSetUserDefaults(@"YES",KHomeAnimaOpen);
    } else if(sw.on == NO) {
        kSetUserDefaults(@"Y",KHomeAnimaOpen);
    }
}
-(void)selectColor{
    MCSelectColorVC *newViewController = [[MCSelectColorVC alloc] init];
    [self.navigationController pushViewController:newViewController animated:YES];
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
