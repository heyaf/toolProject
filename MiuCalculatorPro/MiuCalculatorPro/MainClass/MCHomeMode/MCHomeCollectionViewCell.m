//
//  MCHomeCollectionViewCell.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import "MCHomeCollectionViewCell.h"
#import <SDAutoLayout/SDAutoLayout.h>

@interface MCHomeCollectionViewCell ()
{
    UILabel *_label;
}
@end
@implementation MCHomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createViews];
    }
    return self;
}

- (void)createViews {
    
    
    _label = UILabel.new;
    _label.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    _label.font = [UIFont systemFontOfSize:30];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = kWhiteColor;
    _label.layer.cornerRadius = 5;
    [self.contentView addSubview:_label];
    _label.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    
}


#pragma mark - setter
- (void)setTitle:(NSString *)title {
    _title = title;
    _label.text = title;
    self.layer.cornerRadius = self.itemHeight / 3;
    self.layer.masksToBounds = YES;
}

@end
