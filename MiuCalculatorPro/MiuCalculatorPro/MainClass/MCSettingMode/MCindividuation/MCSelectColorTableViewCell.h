//
//  MCSelectColorTableViewCell.h
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCSelectColorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *ColorView;
@property (weak, nonatomic) IBOutlet UILabel *colorNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *SelelctImageV;

@end

NS_ASSUME_NONNULL_END
