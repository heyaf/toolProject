//
//  AppDelegate+Method.h
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Method)
-(UIViewController *)getCurrentUIVC;
-(UIViewController *)getCurrentVC;
+ (AppDelegate *)shareAppDelegate;

-(void)baseSet;
@end

NS_ASSUME_NONNULL_END
