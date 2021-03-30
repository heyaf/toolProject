//
//  MCSelectColorTableViewCell.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/30.
//

#import "MCSelectColorTableViewCell.h"

@implementation MCSelectColorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.SelelctImageV.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
