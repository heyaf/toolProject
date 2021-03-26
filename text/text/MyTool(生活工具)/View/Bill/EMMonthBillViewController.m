//
//  EMMonthBillViewController.m
//  emark
//
//  Created by neebel on 2017/6/6.
//  Copyright © 2017年 neebel. All rights reserved.
//

#import "EMMonthBillViewController.h"
#import "EMMonthBillTableViewCell.h"
#import "EMBillManager.h"
#import "UIView+EMTips.h"

@interface EMMonthBillViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) EMBillMonthInfo *monthInfo;
@property (nonatomic, strong) UIView *chooseView;
@property (nonatomic, strong) UILabel *yearLabel;
@property (nonatomic, strong) UILabel *monthLabel;

@end

static NSString *monthBillTableViewCellIdentifier = @"monthBillTableViewCellIdentifier";

@implementation EMMonthBillViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    [self loadData];
    [self chooseView];
    
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:_chooseView];
    
    self.navigationItem.rightBarButtonItem = barBut;
//    UIBarButtonItem *publishButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.chooseView];
//    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                                                           target:nil
//                                                                           action:nil];
//    space.width = - 20;
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: publishButtonItem, nil];
}

#pragma mark - Private

- (void)initUI
{
    self.view.backgroundColor = [EMTheme currentTheme].mainBGColor;
    self.navigationItem.title = @"账单";
    [self.view addSubview:self.tableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData
{
    [self.view showHYFLoadingViewTips:nil style:kLogoLoopGray];
    __weak typeof(self) weakSelf = self;
    [[EMBillManager sharedManager] fetchMonthBillInMonth:self.monthStr result:^(EMResult *result) {
        [weakSelf.view hideManualTips];
        weakSelf.monthInfo = result.result;
        [weakSelf.tableView reloadData];
    }];
}


- (CGFloat)cellHeight
{
    if (IS_3_5_INCH || IS_4_0_INCH) {
        return 300;
    } else if (IS_4_7_INCH) {
        return 340;
    } else {
        return 360;
    }
}

#pragma mark - Getter
-(UIView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75, 44)];
        _chooseView.backgroundColor = kMainColor;
        if (self.canChoose) {
            [self addChooseSubviews];

        }
    }
    return _chooseView;
}
-(void)addChooseSubviews{
    UIImageView *imageview = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"xiala1")];
    imageview.frame = CGRectMake(10, 20, 10, 10);
    [_chooseView addSubview:imageview];
//    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.chooseView).offset(10);
//        make.left.mas_equalTo(self.chooseView.left).offset(0);
//        make.width.height.mas_equalTo(15);
//
//    }];
    UILabel *yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 45,15)];
    [_chooseView addSubview:yearLabel];
    yearLabel.text = @"2021年";
    yearLabel.textColor = kWhiteColor;
    yearLabel.textAlignment = NSTextAlignmentLeft;
    yearLabel.font = kFont(11);
    _yearLabel= yearLabel;
//    [yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.chooseView).offset(5);
//        make.right.mas_equalTo(self.chooseView.right).offset(5);
//        make.width.mas_offset(@(85));
//        make.height.mas_offset(@(15));
//    }];
//
    UILabel *monthlabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 45, 15)];
    [_chooseView addSubview:monthlabel];
    monthlabel.text = @"03月";
    monthlabel.textColor = kWhiteColor;
    monthlabel.textAlignment = NSTextAlignmentLeft;
    monthlabel.font = kFont(15);
    _monthLabel= monthlabel;
    
    UIButton *choosebtn = [UIButton buttonWithType:0];
    choosebtn.frame = CGRectMake(0, 0, 75, 44);
    [choosebtn addTarget:self action:@selector(chooseDate) forControlEvents:UIControlEventTouchUpInside];
    [_chooseView addSubview:choosebtn];
}
-(void)chooseDate{
    
    NSDate *minDate = [NSDate br_setYear:2017 month:1 day:1];
    NSDate *maxDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM"];
    
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:BRDatePickerModeYM defaultSelValue:[dateFormatter stringFromDate:maxDate] minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:kMainColor resultBlock:^(NSString *selectValue) {
        NSArray *dateArr = [selectValue componentsSeparatedByString:@"-"];
        self->_yearLabel.text = NSStringFormat(@"%@年",dateArr[0]);
        self->_monthLabel.text = NSStringFormat(@"%@月",dateArr[1]);
        self.monthStr = selectValue;
        [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
        [self loadData];
    } cancelBlock:^{
        
    }];}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [EMTheme currentTheme].mainBGColor;
        [_tableView registerClass:[EMMonthBillTableViewCell class]
           forCellReuseIdentifier:monthBillTableViewCellIdentifier];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = view;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}


#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeight];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EMMonthBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:monthBillTableViewCellIdentifier
                                                             forIndexPath:indexPath];
    NSString *type = nil;
    if (indexPath.row == 0) {
        type = NSLocalizedString(@"总支出", nil);
    } else {
        type = NSLocalizedString(@"总收入", nil);
    }
    
    [cell updateHYFCellCOUSHUWithTitle:type monthInfo:self.monthInfo];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

@end
