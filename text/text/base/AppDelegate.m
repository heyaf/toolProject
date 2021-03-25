//
//  AppDelegate.m
//  text
//
//  Created by Mac on 2018/10/31.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "EMHomeViewController.h"
#import "MainTabBarController.h"
#import "EMBaseNavigationController.h"
#import "ViewController.h"
#import <AVOSCloud/AVOSCloud.h>

static NSString *leanCloundAppID = @"Nc8uB8AiV7TE6hjNj8dmyWGk-gzGzoHsz";
static NSString *leanCloundAppKey = @"kCCDHJ1EPHcTnGwLaYJCJ3nN";
static NSString *leanCloundObjectID = @"5c1b47f9808ca40073299a79";
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [WMAdSDKManager setAppID:@"xxxxxx"];
//    [AVOSCloud setApplicationId:leanCloundAppID  clientKey:leanCloundAppKey];
//    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
//    AVQuery *query = [AVQuery queryWithClassName:@"hh1"];
//    [query getObjectInBackgroundWithId:leanCloundObjectID block:^(AVObject * _Nullable object, NSError * _Nullable error) {
//        NSLog(@"121212%@",object);
//    }];
    
    [AVOSCloud setApplicationId:leanCloundAppID  clientKey:leanCloundAppKey];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[ViewController alloc] init];
//    [[RootNavigationController alloc] initWithRootViewController:[[EMHomeViewController alloc] init] ];
//    [self loadNetWebView];
    self.window.rootViewController = [[hyftabbarController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)loadNetWebView{
    AVQuery *query = [AVQuery queryWithClassName:@"Assistant"];
    [query getObjectInBackgroundWithId:leanCloundObjectID block:^(AVObject * _Nullable object, NSError * _Nullable error) {
        if ([object[@"isChange"] isEqualToString:@"YES"]) {
            self.window.rootViewController = [[hyftabbarController alloc] init];
        }else{
            self.window.rootViewController = [[RootNavigationController alloc] initWithRootViewController:[[EMHomeViewController alloc] init] ];

        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
