//
//  AppDelegate.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/27.
//

#import "AppDelegate.h"
#import <GDTMobSDK/GDTSDKConfig.h>
#import <GDTMobSDK/GDTSplashAd.h>
@interface AppDelegate ()<GDTSplashAdDelegate>
@property (strong, nonatomic) GDTSplashAd *splashAd;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self baseSet];
    
    MCNavigationController *nav = [[MCNavigationController alloc] initWithRootViewController:[[MCHomeViewController alloc] init] ];
    self.window.rootViewController = nav;
    [self setGDTSDK];

    return YES;
}
-(void)setGDTSDK{
    BOOL result = [GDTSDKConfig registerAppId:kGDTSDKAPPID];
    if (result) {
        NSLog(@"注册成功");
    }else{
        NSLog(@"注册不成功");
    }
        
    //设置渠道号
    [GDTSDKConfig setChannel:14];
    
    self.splashAd = [[GDTSplashAd alloc] initWithPlacementId:KGDTSDKKaiPin];
    self.splashAd.delegate = self;
    self.splashAd.fetchDelay = 3;
    UIImage *splashImage = [UIImage imageNamed:@"SplashNormal"];
    if (isIPhoneXSeries()) {
        splashImage = [UIImage imageNamed:@"SplashX"];
    } else if ([UIScreen mainScreen].bounds.size.height == 480) {
        splashImage = [UIImage imageNamed:@"SplashSmall"];
    }
    self.splashAd.needZoomOut = YES;
    self.splashAd.backgroundImage = splashImage;
    self.splashAd.backgroundImage.accessibilityIdentifier = @"splash_ad";

    [self.splashAd loadAd];
}

#pragma mark - GDTSplashAdDelegate

- (void)splashAdDidLoad:(GDTSplashAd *)splashAd {
    
    if (splashAd.splashZoomOutView) {
        [self.window.rootViewController.view addSubview:splashAd.splashZoomOutView];
        
    }
    NSLog(@"广告拉取成功%s", __func__);
    NSLog(@"ecpmLevel:%@", splashAd.eCPMLevel);
    [self.splashAd showAdInWindow:self.window withBottomView:nil skipView:nil];

}

- (void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error
{

}

- (void)splashAdExposured:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdClicked:(GDTSplashAd *)splashAd
{
    if (splashAd.splashZoomOutView) {
        [splashAd.splashZoomOutView removeFromSuperview];
    }
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdApplicationWillEnterBackground:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdWillClosed:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdClosed:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
   self.splashAd = nil;
}

- (void)splashAdWillPresentFullScreenModal:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdDidPresentFullScreenModal:(GDTSplashAd *)splashAd
{
     NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdWillDismissFullScreenModal:(GDTSplashAd *)splashAd
{
     NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdDidDismissFullScreenModal:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - GDTSplashZoomOutViewDelegate
- (void)splashZoomOutViewDidClick:(GDTSplashZoomOutView *)splashZoomOutView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashZoomOutViewAdDidClose:(GDTSplashZoomOutView *)splashZoomOutView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashZoomOutViewAdVideoFinished:(GDTSplashZoomOutView *)splashZoomOutView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashZoomOutViewAdDidPresentFullScreenModal:(GDTSplashZoomOutView *)splashZoomOutView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashZoomOutViewAdDidDismissFullScreenModal:(GDTSplashZoomOutView *)splashZoomOutView
{
    NSLog(@"%s",__FUNCTION__);
}



@end
