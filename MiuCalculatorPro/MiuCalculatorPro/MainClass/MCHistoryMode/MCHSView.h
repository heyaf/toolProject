//
//  MCHSView.h
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCHSView : UIView
- (void)showOrHidden;


@end



@interface MCHSCell : UITableViewCell

@property(nonatomic, strong) NSDictionary *dataDic;

@end
NS_ASSUME_NONNULL_END
