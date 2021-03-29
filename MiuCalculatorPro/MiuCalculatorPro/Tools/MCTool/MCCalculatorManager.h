//
//  MCCalculatorManager.h
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCCalculatorManager : NSObject


+ (instancetype)sharedManager;

/// 添加计算记录到数据库
- (void)addCalculate:(NSString *)expression result:(NSString *)result;

/// 删除记录
- (void)deleteCalculate:(NSString *)expression;

/// 计算记录列表
- (NSArray *)getAllCalculate;
@end

NS_ASSUME_NONNULL_END
