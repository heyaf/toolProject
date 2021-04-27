//
//  MCHomeViewController.m
//  MiuCalculatorPro
//
//  Created by iOS on 2021/3/29.
//

#import "MCHomeViewController.h"
#import "MCHomeCollectionViewCell.h"
#import "MCHSView.h"
#import "MCSettingViewController.h"
#import "MCCalculatorObject.h"
#import "MCCalculatorManager.h"
#import <GDTUnifiedBannerView.h>

@interface MCHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,GDTUnifiedBannerViewDelegate>
{
    CGFloat _itemHeight;
    NSString *_preStr;
}
@property (nonatomic, strong) GDTUnifiedBannerView *bannerView;

@property (nonatomic, strong) NSMutableArray<NSArray *> *dataArray;
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) UILabel *result;
@property (nonatomic, strong) UITextView *expres;
@property (nonatomic, strong) MCHSView *history;

@property (nonatomic, strong) UIImageView *bgImgView;

@end

@implementation MCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kGray2Color;
    
    self.dataArray = NSMutableArray.array;
    
    //只做适配iphone的计算器界面
    [self createCalculateUIForPhone];
    
    [self.view sendSubviewToBack:self.bgImgView];
    
    

    [self setNavButton];
    [self loadAdAndShow:nil];
}
- (void)loadAdAndShow:(id)sender {
      if (self.bannerView.superview) {
          [self.bannerView removeFromSuperview];
      }
      [self.view addSubview:self.bannerView];
 
      [self.bannerView loadAdAndShow];
  }
- (GDTUnifiedBannerView *)bannerView
  {
    if (!_bannerView) {
        CGRect rect = CGRectMake(0, kNavBarHeight, kScreenWidth, 100);
        _bannerView = [[GDTUnifiedBannerView alloc]
                       initWithFrame:rect
                       placementId:kGDTSDKBanner
                       viewController:self];
   
        _bannerView.animated = YES;
        _bannerView.autoSwitchInterval = 5;
        _bannerView.delegate = self;
    }
    return _bannerView;
  }
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kClearColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:kClearColor]];
    
    [self.myCollectionView reloadData];
    NSString *str =kGetUserDefaults(KHomeAnimaOpen);
    if (str.length>2) {
        [self.view.layer addSublayer:MCAnimationManager.shardManager.animationWithSnow];
    }else{
        [MCAnimationManager.shardManager.animationWithSnow removeFromSuperlayer];
    }
    
    NSString *strName = kGetUserDefaults(KHomeSelBGImage);
    if (strName.length>0) {
        _bgImgView.image = [UIImage imageNamed:strName];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setNavButton{

    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
   UIButton *leftbtn =[UIButton buttonWithType:UIButtonTypeCustom];
   leftbtn.frame = CGRectMake(-10, 0, 36, 36);
   [leftbtn setImage:[UIImage imageNamed:@"history"] forState:UIControlStateNormal];
   [leftbtn addTarget:self action:@selector(showHSView) forControlEvents:UIControlEventTouchUpInside];
   [leftView addSubview:leftbtn];
//   [self.view addSubview:leftView];
   
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
   UIButton *rightbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(25, 0, 36, 36);
   [rightbtn setImage:[UIImage imageNamed:@"more_icon"] forState:UIControlStateNormal];
   [rightbtn addTarget:self action:@selector(settingView) forControlEvents:UIControlEventTouchUpInside];
   [rightView addSubview:rightbtn];
//   [self.view addSubview:rightView];
   
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
}
//展示历史
-(void)showHSView{
    [[[AppDelegate shareAppDelegate] getCurrentVC].view addSubview:self.history];
    [self.history showOrHidden];
}

-(void)settingView{
    MCSettingViewController *newViewController = [[MCSettingViewController alloc] init];
    [self.navigationController pushViewController:newViewController animated:YES];
}
#pragma mark - 懒加载
- (UICollectionView *)myCollectionView {
    if (_myCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _myCollectionView.backgroundColor = UIColor.clearColor;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [_myCollectionView registerClass:[MCHomeCollectionViewCell class] forCellWithReuseIdentifier:@"MCHomeCollectionViewCell"];
        [self.view addSubview:_myCollectionView];
        _myCollectionView.sd_layout
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomEqualToView(self.view);
    }
    return _myCollectionView;
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.contentMode = UIViewContentModeScaleAspectFill;
//        NSFileManager *manager = NSFileManager.defaultManager;
//        if ([manager fileExistsAtPath:BG_IMG_PATH]) {
//            UIImage *img = [UIImage imageWithContentsOfFile:BG_IMG_PATH];
//            _bgImgView.image = img;
//        } else {
//            _bgImgView.image = [UIImage imageNamed:@"03_bg"];
//        }
        NSString *strName = kGetUserDefaults(KHomeSelBGImage);
        if (strName.length>0) {
            _bgImgView.image = [UIImage imageNamed:strName];
        }else{
            _bgImgView.image = [UIImage imageNamed:@"03_bg"];
        }
        [self.view addSubview:self.bgImgView];
        _bgImgView.sd_layout
        .topEqualToView(self.view)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomEqualToView(self.view);
    }
    return _bgImgView;
}

- (UILabel *)result {
    if (!_result) {
        _result = [[UILabel alloc] init];
        _result.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _result.text = @"";
        _result.font = [UIFont systemFontOfSize:60];
        _result.textColor = kWhiteColor;
        _result.textAlignment = NSTextAlignmentRight;
        _result.numberOfLines = 2;
        [self.view addSubview:_result];
    }
    return _result;
}

- (UITextView *)expres {
    if (!_expres) {
        _expres = [[UITextView alloc] init];
        _expres.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        // 去掉textview内边距
        _expres.textContainer.lineFragmentPadding = 0.0;
        _expres.textContainerInset = UIEdgeInsetsZero;
        // textview 阻止键盘弹起
        _expres.inputView = UIView.new;
        _expres.inputView.hidden = YES;
        _expres.text = @"";
        _expres.font = [UIFont systemFontOfSize:36];
        _expres.textColor = kWhiteColor;
        _expres.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:_expres];
    }
    return _expres;
}

- (MCHSView *)history {
    if (!_history) {
        _history = MCHSView.new;
        _history.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
    return _history;
}



#pragma mark - layout
- (void)layoutViews {
    self.result.sd_resetLayout
    .leftSpaceToView(self.view, 5)
    .rightSpaceToView(self.view, 5)
    .bottomSpaceToView(self.myCollectionView, 5)
    .heightIs(100);
    self.expres.sd_resetLayout
    .leftSpaceToView(self.view, 5)
    .rightSpaceToView(self.view, 5)
    .bottomSpaceToView(self.result, 5)
    .heightIs(40);
}


#pragma mark - --collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray[section].count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MCHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MCHomeCollectionViewCell" forIndexPath:indexPath];
    cell.itemHeight = _itemHeight;
    cell.title = self.dataArray[indexPath.section][indexPath.row];
    NSString *colorStr = kGetUserDefaults(KSelColor);
    if (indexPath.row==4) {
        cell.backgroundColor = [UIColor colorWithHexString:colorStr alpha:1];
    }else{
        cell.backgroundColor = kClearColor;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = self.dataArray[indexPath.section][indexPath.row];
    [self keyboldClickWithString:str];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section==4&&indexPath.row==3) {
//        return CGSizeMake((int)_itemHeight+20, (int)_itemHeight);
//    }
    return CGSizeMake((int)_itemHeight, (int)_itemHeight);
}

// 四边边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0.1, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1f;
}


#pragma mark - 自定键盘输入逻辑
- (void)keyboldClickWithString:(NSString *)string {
    
    if ([_preStr isEqualToString:@"="]) {
        NSArray *nums = @[@"0", @"00", @".", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"(", @")"];
        if ([nums containsObject:string]) {
            self.expres.text = @"";
            self.result.text = @"";
        }
        NSArray *oprations = @[@"+", @"-", @"*", @"/", @"%", @"^", @"√", @"+-", @"x^2", @"2√x"];
        if ([oprations containsObject:string]) {
            self.expres.text = self.result.text;
            self.result.text = @"";
        }
    }
    
    if ([string isEqualToString:@"设置"]) {
        MCSettingViewController *setting = MCSettingViewController.new;
//        __weak typeof(self) weakSelf = self;
//        setting.selectImageBlock = ^(UIImage *img) {
//            weakSelf.bgImgView.image = img;
//        };
//        setting.bgAnimationBlock = ^(BOOL bgAnimation) {
//            if (bgAnimation) {
//                [DJAnimationManager.shardManager.animationWithSnow removeFromSuperlayer];
//            } else {
//                [self.view.layer addSublayer:DJAnimationManager.shardManager.animationWithSnow];
//            }
//        };
        [self presentViewController:setting animated:YES completion:nil];
    } else if ([string isEqualToString:@"x^2"]) {
        self.expres.text = [NSString stringWithFormat:@"%@%@", self.expres.text, @"^2"];
    } else if ([string isEqualToString:@"2√x"]) {
        self.expres.text = [NSString stringWithFormat:@"%@%@", self.expres.text, @"2√"];
    } else if ([string isEqualToString:@"%"]) {
        self.expres.text = [NSString stringWithFormat:@"%@%@", self.expres.text, @"/100"];
    } else if ([string isEqualToString:@"清空"]) {
        self.expres.text = @"";
        self.result.text = @"";
    } else if ([string isEqualToString:@"删除"]) {
        [self clickDeleteAction];
        self.result.text = @"";
    } else if ([string isEqualToString:@"="]) {
        self.expres.text = [NSString stringWithFormat:@"%@%@", self.expres.text, string];
        self.result.text = [MCCalculatorObject calculator:self.expres.text];
        MCCalculatorManager *manager = MCCalculatorManager.sharedManager;
        
//        NSLog(@"加入数据库前%@",[manager getAllCalculate]);
        
        [manager addCalculate:self.expres.text result:self.result.text];
        
//        NSLog(@"加入数据库后%@",[manager getAllCalculate]);

    } else {
        self.expres.text = [NSString stringWithFormat:@"%@%@", self.expres.text, string];
    }

    _preStr = string;
}
- (void)clickOffAction {
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    maskView.backgroundColor = UIColor.blackColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewClickAction:)];
    [maskView addGestureRecognizer:tap];
    [UIApplication.sharedApplication.keyWindow addSubview:maskView];
}

- (void)clickDeleteAction {
    NSString *text = self.expres.text;
    if (!text.length) return;
    NSRange range = self.expres.selectedRange;
    if (range.location == 0) {
        return;
    } else if (range.location == NSNotFound) {
        range.location = text.length;
    }
    NSString *before = [text substringToIndex:range.location - 1];
    NSString *after = [text substringFromIndex:range.location];
    self.expres.text = [NSString stringWithFormat:@"%@%@", before, after];
    self.expres.selectedRange = NSMakeRange(range.location - 1, 0);
}

- (void)maskViewClickAction:(UIGestureRecognizer *)ges {
    [ges.view removeFromSuperview];
}


#pragma mark - 屏幕旋转


static NSInteger count = 6;

- (void)createCalculateUIForPhone {
    NSArray *arr = @[
                     @[@"(",   @")",   @"%",   @"^",     @"+"],
                     @[@"7",   @"8",   @"9",   @"x^2",   @"-"],
                     @[@"4",   @"5",   @"6",   @"2√x",   @"*"],
                     @[@"1",   @"2",   @"3",   @"√",     @"/"],
                     @[@"清空",  @"0",   @".",   @"删除",  @"="]];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:arr];
    count = 5;
    
    _itemHeight = (kScreenWidth - 5 * (count + 1)) / count;
    
    CGFloat collectionViewHeight = (_itemHeight + 5) * self.dataArray.count+kSafeAreaBottom;
    NSLog(@"collectionViewHeight:%f", collectionViewHeight);
    self.myCollectionView.sd_layout.heightIs(collectionViewHeight);
    
    [self.myCollectionView reloadData];
    
    [self layoutViews];
}
#pragma mark - GDTUnifiedBannerViewDelegate
/**
 *  请求广告条数据成功后调用
 *  当接收服务器返回的广告数据成功后调用该函数
 */
- (void)unifiedBannerViewDidLoad:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"unified banner did load");
}

/**
 *  请求广告条数据失败后调用
 *  当接收服务器返回的广告数据失败后调用该函数
 */

- (void)unifiedBannerViewFailedToLoad:(GDTUnifiedBannerView *)unifiedBannerView error:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  banner2.0曝光回调
 */
- (void)unifiedBannerViewWillExpose:(nonnull GDTUnifiedBannerView *)unifiedBannerView {
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  banner2.0点击回调
 */
- (void)unifiedBannerViewClicked:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  应用进入后台时调用
 *  当点击应用下载或者广告调用系统程序打开，应用将被自动切换到后台
 */
- (void)unifiedBannerViewWillLeaveApplication:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  全屏广告页已经被关闭
 */
- (void)unifiedBannerViewDidDismissFullScreenModal:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  全屏广告页即将被关闭
 */
- (void)unifiedBannerViewWillDismissFullScreenModal:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  banner2.0广告点击以后即将弹出全屏广告页
 */
- (void)unifiedBannerViewWillPresentFullScreenModal:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  banner2.0广告点击以后弹出全屏广告页完毕
 */
- (void)unifiedBannerViewDidPresentFullScreenModal:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  banner2.0被用户关闭时调用
 */
- (void)unifiedBannerViewWillClose:(nonnull GDTUnifiedBannerView *)unifiedBannerView {
    self.bannerView = nil;
    NSLog(@"%s",__FUNCTION__);
}
@end
