//
//  NSDate+MCdate.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import "NSDate+MCdate.h"

@implementation NSDate (MCdate)
+ (NSString *)desc {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:NSDate.date];
    return currentDateStr;
}
@end
