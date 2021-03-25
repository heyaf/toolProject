//
//  OtherViewController.m
//  text
//
//  Created by Mac on 2018/12/15.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "OtherViewController.h"
#import "EMDiaryViewController.h"
#import "EMBigDayViewController.h"
#import "LXFCalculatorViewController.h"
@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"工具";
    // Do any additional setup after loading the view.

    NSArray *titleArr = @[@"日记",@"节日",@"房贷计算器"];
    NSArray *imageArr = @[@"mytool1",@"mytool2",@"mytool3"];
    CGFloat W = 80;
    CGFloat margin = (kScreenW-80*2)/3;
    for (int i=0; i<titleArr.count; i++) {
        NSInteger hang = i/2;
        NSInteger lie = i%2;
        CGRect rect = CGRectMake(margin+(W+margin)*lie, margin+(W+margin)*hang, W, W);
        [self subViewsWithFrame:rect Image:imageArr[i] title:titleArr[i] tag:i];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)subViewsWithFrame:(CGRect)frame Image:(NSString *)imageName title:(NSString *)title tag:(NSInteger) tag{
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = frame;
    button.tag = tag+666;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button removeAllSubviews];
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 55, 55)];
    imagev.image = IMAGE_NAMED(imageName);
    [button addSubview:imagev];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 20)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = kFont(13.0);
    [button addSubview:label];
    
    
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width, -button.imageView.frame.size.height, 0);
//    // button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.frame.size.height, 0, 0, -button.titleLabel.frame.size.width);
//    // 由于iOS8中titleLabel的size为0，用上面这样设置有问题，修改一下即可
//    button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.intrinsicContentSize.height, 0, 0, -button.titleLabel.intrinsicContentSize.width);
}
-(void)buttonClicked:(id)sender{
    UIButton *btn = sender;
    EMDiaryViewController *emVC = [EMDiaryViewController new];
    EMBigDayViewController *bigDayVC = [EMBigDayViewController new];
    LXFCalculatorViewController *lxVC = [LXFCalculatorViewController new];
    
    switch (btn.tag) {
        case 666:
            [self.navigationController pushViewController:emVC animated:YES];
            break;
        case 667:
            [self.navigationController pushViewController:bigDayVC animated:YES];

            break;
        case 668:
            [self.navigationController pushViewController:lxVC animated:YES];

            break;

        default:
            break;
    }
    
}
- (void)adjustButtonImageViewUPTitleDownWithButton:(UIButton *)button {
    [button.superview layoutIfNeeded];
    //使图片和文字居左上角
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    CGFloat buttonHeight = CGRectGetHeight(button.frame);
    CGFloat buttonWidth = CGRectGetWidth(button.frame);
    
    CGFloat ivHeight = CGRectGetHeight(button.imageView.frame);
    CGFloat ivWidth = CGRectGetWidth(button.imageView.frame);
    
    CGFloat titleHeight = CGRectGetHeight(button.titleLabel.frame);
    CGFloat titleWidth = CGRectGetWidth(button.titleLabel.frame);
    //调整图片
    float iVOffsetY = buttonHeight / 2.0 - (ivHeight + titleHeight) / 2.0;
    float iVOffsetX = buttonWidth / 2.0 - ivWidth / 2.0;
    [button setImageEdgeInsets:UIEdgeInsetsMake(iVOffsetY, iVOffsetX, 0, 0)];
    
    //调整文字
    float titleOffsetY = iVOffsetY + CGRectGetHeight(button.imageView.frame) + 10;
    float titleOffsetX = 0;
    if (CGRectGetWidth(button.imageView.frame) >= (CGRectGetWidth(button.frame) / 2.0)) {
        //如果图片的宽度超过或等于button宽度的一半
        titleOffsetX = -(ivWidth + titleWidth - buttonWidth / 2.0 - titleWidth / 2.0);
    }else {
        titleOffsetX = buttonWidth / 2.0 - ivWidth - titleWidth / 2.0;
    }
    [button setTitleEdgeInsets:UIEdgeInsetsMake(titleOffsetY , titleOffsetX, 0, 0)];
}



@end
