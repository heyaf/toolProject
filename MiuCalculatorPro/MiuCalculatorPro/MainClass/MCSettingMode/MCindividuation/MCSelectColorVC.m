//
//  MCSelectColorVC.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/30.
//

#import "MCSelectColorVC.h"

@interface MCSelectColorVC ()
@property (nonatomic,strong) NSArray *colorArray;

@property (nonatomic,strong) NSArray *nameCorArr;


@end

@implementation MCSelectColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kWhiteColor;
    self.colorArray = @[@"#c63c26",@"#f15a22",@"#f58220",@"#b76f40",@"#ffc20e",@"#33a3dc",@"#00a6ac",@"#ea66a6",];
    self.nameCorArr = @[@"海棠红",@"金赤色",@"蜜柑色",@"琥珀色",@"向日葵色",@"芦草色",@"浅葱色",@"牡丹色",];
}



@end
