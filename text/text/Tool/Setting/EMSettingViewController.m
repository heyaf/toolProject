//
//  EMSettingViewController.m
//  emark
//
//  Created by neebel on 2017/5/27.
//  Copyright © 2017年 neebel. All rights reserved.
//

#import "EMSettingViewController.h"
#import "EMSettingTableViewCell.h"
#import "EMSettingHeaderView.h"
#import "EMHomeManager.h"
#import "EMSettingActionSheet.h"
#import "EMHomeManager.h"
#import "EMAboutUsViewController.h"
#import "FSMediaPicker.h"
#import "EMShowPhotoTool.h"
#import "SXAlertView.h"
#import "suggestViewController.h"

@interface EMSettingViewController ()<UITableViewDelegate, UITableViewDataSource, EMSettingActionSheetDelegate, FSMediaPickerDelegate, EMSettingHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *settingItemArr;
@property (nonatomic, strong) EMSettingActionSheet *actionSheet;
@property (nonatomic, strong) EMHomeHeadInfo *headInfo;
@property (nonatomic, strong) EMShowPhotoTool *tool;
@property (nonatomic, strong) NSString *messageString;
@end

static NSString *settingTableViewCellIdentifier = @"settingTableViewCellIdentifier";
static NSString *settingTableViewHeaderViewIdentifier = @"settingTableViewHeaderViewIdentifier";

@implementation EMSettingViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = NSLocalizedString(@"设置", nil);
    [self.view addSubview:self.tableView];
    [self loadData];
}


- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.hasNav) {
        self.navigationController.navigationBarHidden = YES;

    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;

}

#pragma mark - Getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[EMSettingTableViewCell class]
           forCellReuseIdentifier:settingTableViewCellIdentifier];
        [_tableView registerClass:[EMSettingHeaderView class] forHeaderFooterViewReuseIdentifier:settingTableViewHeaderViewIdentifier];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = view;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }

    return _tableView;
}


- (NSArray *)settingItemArr
{
    if (!_settingItemArr) {
        _settingItemArr = @[NSLocalizedString(@"更换头像", nil), NSLocalizedString(@"关于我们", nil), NSLocalizedString(@"隐私政策", nil),NSLocalizedString(@"意见反馈", nil)];
    }

    return _settingItemArr;
}
-(NSString *)messageString{
    return @"本应用尊重并保护所有使用服务用户的个人隐私权。\n为了给您提供更准确、更有个性化的服务，本应用会按照本隐私权政策的规定使用和披露您的个人信息。但本应用将以高度的勤勉、审慎义务对待这些信息。除本隐私权政策另有规定外，在未征得您事先许可的情况下，本应用不会将这些信息对外披露或向第三方提供。本应用会不时更新本隐私权政策。 您在同意本应用服务使用协议之时，即视为您已经同意本隐私权政策全部内容。本隐私权政策属于本应用服务使用协议不可分割的一部分。\n\n1. 适用范围(a) 在您注册本应用帐号时，您根据本应用要求提供的个人注册信息；\n(b) 在您使用本应用网络服务，或访问本应用平台网页时，本应用自动接收并记录的您的浏览器和计算机上的信息，包括但不限于您的IP地址、浏览器的类型、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；\n(c) 本应用通过合法途径从商业伙伴处取得的用户个人数据。您了解并同意，以下信息不适用本隐私权政策：\n(a) 您在使用本应用平台提供的搜索服务时输入的关键字信息；\n(b) 本应用收集到的您在本应用发布的有关信息数据，包括但不限于参与活动、成交信息及评价详情；\n(c) 违反法律规定或违反本应用规则行为及本应用已对您采取的措施。\n\n2. 信息使用本应用不会向任何无关第三方提供、出售、出租、分享或交易您的个人信息，除非事先得到您的许可，或该第三方和本应用（含本应用关联公司）单独或共同为您提供服务，且在该服务结束后，其将被禁止访问包括其以前能够访问的所有这些资料。\n\n3. 信息披露在如下情况下，本应用将依据您的个人意愿或法律的规定全部或部分的披露您的个人信息：\n(a) 经您事先同意，向第三方披露；\n(b)为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；\n(c) 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；\n\n本公司保留随时修改本政策的权利，因此请经常查看。如对本政策作出重大更改，本公司会通过网站通知的形式告知。方披露自己的个人信息，如联络方式或者邮政地址。请您妥善保护自己的个人信息，仅在必要的情形下向他人提供。如您发现自己的个人信息泄密，尤其是本应用用户名及密码发生泄露，请您立即联络本应用客服，以便本应用采取相应措施。";
}

- (EMSettingActionSheet *)actionSheet
{
    if (!_actionSheet) {
        _actionSheet = [[EMSettingActionSheet alloc] init];
        _actionSheet.delegate = self;
    }

    return _actionSheet;
}


- (EMHomeHeadInfo *)headInfo
{
    if (!_headInfo) {
        _headInfo = [[EMHomeHeadInfo alloc] init];
    }

    return _headInfo;
}


- (EMShowPhotoTool *)tool
{
    if (!_tool) {
        _tool = [[EMShowPhotoTool alloc] init];
    }

    return _tool;
}

#pragma mark - Action

- (void)jumpAction:(NSIndexPath *)indexPath
{
    NSString *title = self.settingItemArr[indexPath.row];
    if ([title isEqualToString:NSLocalizedString(@"更换头像", nil)]) {
        [self selectHead];
    } else if ([title isEqualToString:NSLocalizedString(@"关于我们", nil)]) {
        EMAboutUsViewController *aboutUsVC = [[EMAboutUsViewController alloc] init];
//        [self presentViewController:aboutUsVC animated:YES completion:nil];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    } else if ([title isEqualToString:NSLocalizedString(@"隐私政策", nil)]) {
        [SXAlertView showWithTitle:@"隐私政策" message:self.messageString cancelButtonTitle:@"确定" otherButtonTitle:nil clickButtonBlock:^(SXAlertView * _Nonnull alertView, NSInteger buttonIndex) {
            
        }];
    }else if ([title isEqualToString:NSLocalizedString(@"意见反馈", nil)]) {
        suggestViewController *suVC = [[suggestViewController alloc] init];
        [self.navigationController pushViewController:suVC animated:YES];
    }
}

#pragma mark - Private

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [[EMHomeManager sharedManager] fetchHeadInfoWithResultBlock:^(EMResult *result) {
        weakSelf.headInfo = result.result;
        [weakSelf.tableView reloadData];
    }];
}


- (void)selectHead
{
    [self.actionSheet show];
}


- (void)checkAuthorizationWithType:(EMSettingHeadImageType)type complete:(void (^) (void))complete
{
    switch (type) {
        case kEMSettingHeadImageTypeCamera: //检查相机授权
        {
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                switch (authStatus) {
                    case AVAuthorizationStatusAuthorized:
                        if (complete) {
                            complete();
                        }
                        break;
                    case AVAuthorizationStatusNotDetermined:
                    {
                        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                            dispatch_async_in_main_queue(^{
                                if (granted && complete) {
                                    complete();
                                }
                            });
                        }];
                    }
                        break;
                    default:
                    {
                        [self.view showMultiLineMessage:NSLocalizedString(@"请在iPhone的\"设置-隐私-相机\"选项中，允许EMark访问你的相机", nil)];
                    }
                        break;
                }
            } else {
                [EMTips show:NSLocalizedString(@"您的设备不支持拍照", nil)];
            }
        }
            break;
        case kEMSettingHeadImageTypeAlbum: //检查相册授权
        {
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
            switch (status) {
                case ALAuthorizationStatusNotDetermined:
                case ALAuthorizationStatusAuthorized:
                    if (complete) {
                        complete();
                    }
                    break;
                default:
                {
                    [self.view showMultiLineMessage:NSLocalizedString(@"请在iPhone的\"设置-隐私-照片\"选项中，允许该App访问你的相册", nil)];
                }
                    break;
            }
        }
            break;
        default:
            break;
    }
}


- (void)refreshHead:(UIImage *)image
{
    self.headInfo.headImage = image;
    [[EMHomeManager sharedManager] cacheHeadInfo:self.headInfo];
    [self.tableView reloadData];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingItemArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EMSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingTableViewCellIdentifier
                                    forIndexPath:indexPath];
    [cell updateHYFCellCOUSHUWithTitle:self.settingItemArr[indexPath.row]];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    EMSettingHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:settingTableViewHeaderViewIdentifier];
    [headerView updateViewWithImage:self.headInfo.headImage];
    headerView.delegate = self;
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self jumpAction:indexPath];
}

#pragma mark - EMSettingActionSheetDelegate

- (void)takePhoto
{
    __weak typeof(self) weakSelf = self;
    [self checkAuthorizationWithType:kEMSettingHeadImageTypeCamera complete:^{
        FSMediaPicker *mediaPicker = [[FSMediaPicker alloc] initWithDelegate:weakSelf];
        mediaPicker.mediaType = FSMediaTypePhoto;
        mediaPicker.editMode = FSEditModeStandard;
        [mediaPicker takePhotoFromCamera];
    }];
}


- (void)searchFromAlbum
{
    __weak typeof(self) weakSelf = self;
    [self checkAuthorizationWithType:kEMSettingHeadImageTypeAlbum complete:^{
        FSMediaPicker *mediaPicker = [[FSMediaPicker alloc] initWithDelegate:weakSelf];
        mediaPicker.mediaType = FSMediaTypePhoto;
        mediaPicker.editMode = FSEditModeStandard;
        [mediaPicker takePhotoFromPhotoLibrary];
    }];
}

#pragma mark - FSMediaPickerDelegate

- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    [self refreshHead:mediaInfo.editedImage];
}

#pragma mark - EMSettingHeaderViewDelegate

- (void)lookBigImage
{
    UIImage *image = self.headInfo.headImage ? self.headInfo.headImage : [UIImage imageNamed:@"iconimage"];
    [self.tool showWithImage:image];
}

@end
