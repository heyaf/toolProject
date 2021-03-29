//
//  MCStack.h
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCStack<ObjectType> : NSObject
+ (instancetype)stack;


@property(nonatomic, assign, readonly) NSInteger size;

@property(nonatomic, assign, readonly) BOOL isEmpty;


- (void)push:(ObjectType)e;

/// 弹出栈顶元素
- (ObjectType)pop;

/// 查看栈顶元素
- (ObjectType)top;

/// 清空栈
- (void)clear;
@end

NS_ASSUME_NONNULL_END
