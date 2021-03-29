//
//  NSDate+MCdate.h
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (MCdate)

//获取yyyy-MM-dd HH:mm:ss格式的时间字符串
+ (NSString *)desc;
@end

NS_ASSUME_NONNULL_END
