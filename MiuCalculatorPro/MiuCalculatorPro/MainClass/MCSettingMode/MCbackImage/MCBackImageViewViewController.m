//
//  MCBackImageViewViewController.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/30.
//

#import "MCBackImageViewViewController.h"
#import "iCarousel.h"
#import <SVProgressHUD.h>

@interface MCBackImageViewViewController ()<iCarouselDataSource, iCarouselDelegate>
@property (strong, nonatomic)  iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation MCBackImageViewViewController
- (void)setUp
{
    
    self.items = [NSMutableArray array];
    
    for (int i = 1; i < 10; i++)
    {
        
        [self.items addObject:[UIImage imageNamed:[NSString stringWithFormat:@"bgimage0%d.jpg",i]]];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kRGB(100, 100, 100);
    [self setNavButton];
    
    [self setUp];
    
    self.carousel = [[iCarousel alloc] initWithFrame:CGRectMake(15, kNavBarHeight+10, kScreenWidth, kScreenHeight-kNavBarHeight-30)];
    [self.view addSubview:self.carousel];
    
    /** 协议代理方法*/
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    
    /** 样式*/
    self.carousel.type = iCarouselTypeCoverFlow;
    self.view.clipsToBounds = YES;
}

#pragma mark - **************** 数据源

/** 共有多少个*/
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return (NSInteger)[self.items count];
}

/** 每个显示的类容(自定义)*/
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    UIImageView *imageView = nil;
    

    if (view == nil)
    {
        /** 创建视图,然后放上图片展示*/
        view = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, kScreenWidth-80, (kScreenWidth-150)/kScreenWidth*kScreenHeight)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.bounds];
        imageView.image = self.items[index];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.tag = 1;
        [view addSubview:imageView];
        
    }
    else
    {
        imageView = (UIImageView *)[view viewWithTag:1];
    }
    
    
    return view;

}

/** 此方法主要用于网路请求时加载图片完成之前的默认图片(类似于输入文本框的默认提示)*/

/*
- (NSInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel{
    
}
- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
}
*/


- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{

    NSString *str = [NSString stringWithFormat:@"bgimage0%li.jpg",(long)index+1];
    kSetUserDefaults(str, KHomeSelBGImage);
    [self.navigationController popViewControllerAnimated:YES];
}
- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
 
    /** 效果*/
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            /** 1: 包围样式 0:第一张开始*/
            return 1;
        }
        case iCarouselOptionSpacing:
        {
            /** 间隔*/
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

-(void)setNavButton{

    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
   UIButton *leftbtn =[UIButton buttonWithType:UIButtonTypeCustom];
   leftbtn.frame = CGRectMake(-10, 0, 36, 36);
   [leftbtn setImage:[UIImage imageNamed:@"backicon"] forState:UIControlStateNormal];
   [leftbtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
   [leftView addSubview:leftbtn];
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
   UIButton *rightbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(25, 0, 36, 36);
   [rightbtn setImage:[UIImage imageNamed:@"photos"] forState:UIControlStateNormal];
   [rightbtn addTarget:self action:@selector(getPhotos) forControlEvents:UIControlEventTouchUpInside];
   [rightView addSubview:rightbtn];
//   [self.view addSubview:rightView];
   
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getPhotos{
    [SVProgressHUD showInfoWithStatus:@"暂未开放，敬请期待"];
}
@end
