//
//  EMMonthBillViewController.h
//  emark
//
//  Created by neebel on 2017/6/6.
//  Copyright © 2017年 neebel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMMonthBillViewController : UIViewController

@property (nonatomic, copy) NSString *monthStr;

/**
 是否能选择日期
 */
@property (nonatomic,assign) BOOL canChoose; //
@end
