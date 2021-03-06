//
//  MCAnimationManager.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import "MCAnimationManager.h"
#import <UIKit/UIKit.h>
@interface MCAnimationManager ()
{
    CAEmitterLayer *_snowLayer;
}
@end
@implementation MCAnimationManager
static MCAnimationManager *_manager;
+ (instancetype)shardManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[MCAnimationManager alloc] init];
    });
    return _manager;
}



#pragma mark - 动画
/// 雪花动画
- (CAEmitterLayer *)animationWithSnow {
    
    if (_snowLayer) {
        return _snowLayer;
    }
    
    
    _snowLayer = [CAEmitterLayer layer];
    _snowLayer.emitterPosition = CGPointMake(kScreenWidth / 2.0,0);
    _snowLayer.emitterSize = CGSizeMake(kScreenWidth, kScreenHeight);
    _snowLayer.emitterMode = kCAEmitterLayerSurface;
    _snowLayer.emitterShape = kCAEmitterLayerLine;
    
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    snowflake.contentsScale = 1.5;
    snowflake.name = @"snow";
    snowflake.birthRate = 20.0;
    snowflake.lifetime = 10.0;
    snowflake.velocity = 10.0;
    snowflake.velocityRange = 10;
    snowflake.yAcceleration = 30;
    snowflake.emissionRange = M_PI_2;
    snowflake.spinRange = M_PI_4;
    snowflake.contents  = (id)[[UIImage imageNamed:@"MCsnow"] CGImage];
    snowflake.scaleRange = 0.6f;
    snowflake.scale = 0.7f;
    
    snowflake.color = UIColor.whiteColor.CGColor;
//    snowflake.redRange = 1.5f;
//    snowflake.greenRange = 2.2f;
//    snowflake.blueRange = 2.2f;
    
    _snowLayer.emitterCells = @[snowflake];
    
    return _snowLayer;
}
@end
