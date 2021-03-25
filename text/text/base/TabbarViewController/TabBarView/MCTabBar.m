//
//  MCTabBar.m
//  MCTabBarDemo
//
//  Created by chh on 2017/12/18.
//  Copyright © 2017年 Mr.C. All rights reserved.
//

#import "MCTabBar.h"
#define tabbarW 35
#define tabbarH 36
@implementation MCTabBar
- (instancetype)init{
    if (self = [super init]){
        [self initView];
//        [self.selectedItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KBlackColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateNormal];
//        [self.selectedItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CNavBgColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateSelected];
    }
    return self;
}

- (void)initView{
    _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //  设定button大小为适应图片
    UIImage *normalImage = [UIImage imageNamed:@"icon_tabbar_merchant_normal"];
    _centerBtn.frame = CGRectMake(0, 0, tabbarW, tabbarH);
    [_centerBtn setBackgroundImage:normalImage forState:0];
    //去除选择时高亮
    _centerBtn.adjustsImageWhenHighlighted = NO;
    //根据图片调整button的位置(图片中心在tabbar的中间最上部，这个时候由于按钮是有一部分超出tabbar的，所以点击无效，要进行处理)
    _centerBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - tabbarW)/2.0, - tabbarW/4.0, tabbarW, tabbarH);
    _centerBtn.layer.cornerRadius = (tabbarW)/2;
    _centerBtn.layer.masksToBounds = YES;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-(tabbarW+15)/2, -(tabbarW+15)/4, (tabbarW+15), (tabbarW+15))];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = (tabbarW+15)/2;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    [self addSubview:_centerBtn];
}

//处理超出区域点击无效的问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.hidden){
        return [super hitTest:point withEvent:event];
    }else {
        //转换坐标
        CGPoint tempPoint = [self.centerBtn convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(self.centerBtn.bounds, tempPoint)){
            //返回按钮
            return _centerBtn;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
}
@end
