//
//  MCSelectColorVC.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/30.
//

#import "MCSelectColorVC.h"
#import "MCSelectColorTableViewCell.h"

@interface MCSelectColorVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *colorArray;

@property (nonatomic,strong) NSArray *nameCorArr;

@property (nonatomic,strong) UITableView *tableView;


@end

@implementation MCSelectColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight)];
    navView.backgroundColor = kWhiteColor;
    [self.view addSubview:navView];
    self.navigationItem.title = @"设置背景图";
    self.view.backgroundColor = kRGB(245, 245, 245);
    self.colorArray = @[@"#c63c26",@"#6f599c",@"#f58220",@"#b76f40",@"#ffc20e",@"#33a3dc",@"#00a6ac",@"#ea66a6",];
    self.nameCorArr = @[@"海棠红",@"江户紫",@"蜜柑色",@"琥珀色",@"向日葵色",@"芦草色",@"浅葱色",@"牡丹色",];
    [self.view addSubview:self.tableView];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+10, kScreenWidth, kScreenHeight-kNavBarHeight)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0,0);
        _tableView.rowHeight = 48;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerNib:[UINib nibWithNibName:@"MCSelectColorTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MCSelectColorTableViewCell"];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameCorArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCSelectColorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCSelectColorTableViewCell"];
    cell.ColorView.backgroundColor = [UIColor colorWithHexString:self.colorArray[indexPath.row] alpha:1];
    cell.colorNameLabel.text = self.nameCorArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (int i =0; i<self.colorArray.count; i++) {
        MCSelectColorTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.SelelctImageV.hidden = YES;
    }
    MCSelectColorTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.SelelctImageV.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    NSString *colorStr = self.colorArray[indexPath.row];
    kSetUserDefaults(colorStr, KSelColor);

}
@end
