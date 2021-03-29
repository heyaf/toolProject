//
//  MCStack.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import "MCStack.h"
@interface MCStack ()

@property(nonatomic, strong) NSMutableArray *elementArray;

@end
@implementation MCStack
/// 初始化
+ (instancetype)stack {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        self.elementArray = NSMutableArray.array;
    }
    return self;
}
/// 栈空间大小
- (NSInteger)size {
    return self.elementArray.count;
}
/// 栈是否为空
- (BOOL)isEmpty {
    return self.size == 0;
}


/// 向栈内添加元素
///
- (void)push:(id)e {
    [self.elementArray addObject:e];
}

/// 弹出栈顶元素
- (id)pop {
    id e = [self top];
    [self.elementArray removeObjectAtIndex:(self.size - 1)];
    return e;
}

/// 查看栈顶元素
- (id)top {
    return [self.elementArray objectAtIndex:(self.size - 1)];
}

/// 清空栈
- (void)clear {
    [self.elementArray removeAllObjects];
}

@end
