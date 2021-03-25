//
//  MainTabBarController.m
//  HotShow_iOS
//
//  Created by ios开发 on 2018/9/25.
//  Copyright © 2018年 ios开发. All rights reserved.
//

#import "MainTabBarController.h"
#import "RootNavigationController.h"
#import "EMBillViewController.h"
#import "EMDiaryViewController.h"
#import "EMBigDayViewController.h"
//#import "FourViewController.h"
#import "UITabBar+CustomBadge.h"

#import "LXTabBar.h"
#import "MCTabBar.h"
@interface MainTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) MCTabBar *mcTabbar;

@property (nonatomic,strong) NSMutableArray * VCS;//tabbar root VC
@property (nonatomic, assign) NSUInteger selectItem;//选中的item

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
   
    
    self.selectItem = 0; //默认选中第一个
    //初始化tabbar
    [self setUpTabBar];
    
    //创建子控制器
    [self setUpAllChildViewController];
}
#pragma mark ————— 初始化TabBar —————
-(void)setUpTabBar{
    //设置背景色 去掉分割线
    [self setValue:[LXTabBar new] forKey:@"tabBar"];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    //通过这两个参数来调整badge位置
        [self.tabBar setTabIconWidth:29];
        [self.tabBar setBadgeTop:-20];
}
#pragma mark - ——————— 初始化VC ————————
-(void)setUpAllChildViewController{
    _VCS = @[].mutableCopy;
    EMBillViewController *homeVC = [[EMBillViewController alloc]init];
    [self setupChildViewController:homeVC title:@"首页" imageName:@"homepage_fill" seleceImageName:@"homepage"];

    EMDiaryViewController *welfareburst = [[EMDiaryViewController alloc]init];
    [self setupChildViewController:welfareburst title:@"二维码" imageName:@"qrcode_fill" seleceImageName:@"qrcode"];

   

    EMBigDayViewController *sendVC = [[EMBigDayViewController alloc]init];
    [self setupChildViewController:sendVC title:@"登记" imageName:@"addpeople_fill" seleceImageName:@"addpeople"];

//    FourViewController *mineVC = [[FourViewController alloc]init];
//
//    [self setupChildViewController:mineVC title:@"关于" imageName:@"people_fill" seleceImageName:@"people"];

    self.viewControllers = _VCS;
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:kFont(10.0f)} forState:UIControlStateNormal];
    
    //选中字体颜色
    
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:kFont(10.0f)} forState:UIControlStateSelected];
    //包装导航控制器
    RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:controller];
    
    //    [self addChildViewController:nav];
    [_VCS addObject:nav];
    
}


- (void)buttonAction:(UIButton *)button{
    self.selectedIndex = 2;//关联中间按钮
    //    if (self.selectItem != 2){
    //        [self rotationAnimation];
    //    }
    self.selectItem = 2;
}

//tabbar选择时的代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //    if (tabBarController.selectedIndex == 2){//选中中间的按钮
    //        if (self.selectItem != 2){
    //             [self rotationAnimation];
    //        }
    //    }else {
    //        [_mcTabbar.centerBtn.layer removeAllAnimations];
    //    }
    self.selectItem = tabBarController.selectedIndex;
}

-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow{
    if (isShow) {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:0 atIndex:index];
    }else{
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:index];
    }
    
}

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

