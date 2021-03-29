//
//  MCHSView.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import "MCHSView.h"
@interface MCHSView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic, strong) UITableView *myTableView;

@property(nonatomic, assign) BOOL isShow;

@end

@implementation MCHSView


- (instancetype)init {
    if (self = [super init]) {
        self.isShow = NO;
        self.dataArray = NSMutableArray.array;
        [self loadData];
    }
    return self;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showOrHidden];
}

#pragma mark - tableview
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, kScreenHeight) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerClass:MCHSCell.class forCellReuseIdentifier:@"MCHSCell"];
        [self addSubview:_myTableView];
    }
    return _myTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = _dataArray[indexPath.row];
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"dataDic" cellClass:[MCHSCell class] contentViewWidth:300];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCHSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCHSCell"];
    cell.dataDic = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



//#pragma mark - private


#pragma mark - public
- (void)showOrHidden {
    self.isShow = !self.isShow;
    if (self.isShow) {
        [self loadData];
        [UIView animateWithDuration:0.3 animations:^{
            self.myTableView.frame = CGRectMake(0, 0, 300, kScreenHeight);
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.myTableView.frame = CGRectMake(-300, 0, 300, kScreenHeight);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

#pragma mark - 加载历史数据
- (void)loadData {
    [self.dataArray removeAllObjects];
    MCCalculatorManager *manager = MCCalculatorManager.sharedManager;
    NSArray *arr = manager.getAllCalculate;
    [self.dataArray addObjectsFromArray:[self sortArr:arr]];
    [self.myTableView reloadData];
}
//排序
-(NSArray *)sortArr:(NSArray *)sortArr{
    
    NSMutableArray *mutSortArr = [NSMutableArray arrayWithArray:sortArr];
    for (int i =0; i<mutSortArr.count-1; i++) {
        for (int j=i+1; j<mutSortArr.count; j++) {
            NSInteger id1 =[mutSortArr[i][@"id"] integerValue];
            NSInteger id2 =[mutSortArr[j][@"id"] integerValue];

            if (id1<id2) {
                NSDictionary *dic = mutSortArr[i];
                mutSortArr[i] = mutSortArr[j];
                mutSortArr[j] = dic;
            }
        }
    }
    return mutSortArr;
    
}

@end




@interface MCHSCell()
{
    UILabel *_expresLab;
    UILabel *_resultLab;
}
@end

@implementation MCHSCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kClearColor;
        [self createViews];
    }
    return self;
}

- (void)createViews {
    
    _expresLab = [[UILabel alloc] init];
//    _expresLab.backgroundColor = UIColor.blackColor;
    _expresLab.font = [UIFont systemFontOfSize:16];
    _expresLab.textColor = kWhiteColor;
    _expresLab.textAlignment = NSTextAlignmentRight;
    
    _resultLab = [[UILabel alloc] init];
//    _resultLab.backgroundColor = UIColor.blackColor;
    _resultLab.font = [UIFont systemFontOfSize:20];
    _resultLab.textColor = kWhiteColor;
    _resultLab.textAlignment = NSTextAlignmentRight;
    
    
    [self.contentView addSubview:_expresLab];
    [self.contentView addSubview:_resultLab];
    _expresLab.sd_layout
    .leftSpaceToView(self.contentView, 5)
    .rightSpaceToView(self.contentView, 5)
    .topSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    _resultLab.sd_layout
    .leftSpaceToView(self.contentView, 5)
    .rightSpaceToView(self.contentView, 5)
    .topSpaceToView(_expresLab, 5)
    .autoHeightRatio(0);
    
    UIView *line = UIView.new;
    line.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1];
    [self.contentView addSubview:line];
    line.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .heightIs(1);
    
    [self setupAutoHeightWithBottomView:_resultLab bottomMargin:15];

}


- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    _expresLab.text = dataDic[@"expression"];
    _resultLab.text = dataDic[@"result"];
}


@end
