//
//  MCAnimationManager.h
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/CAEmitterLayer.h>

@interface MCAnimationManager : NSObject
+ (instancetype)shardManager;
/// 雪花动画的layer
- (CAEmitterLayer *)animationWithSnow;
@end

