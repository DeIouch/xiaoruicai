//
//  UpdateCertificateViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "UpdateCertificateViewController.h"
#import "UpdateIdCardTableViewCell.h"
#import "UpdateBankCardTableViewCell.h"
#import "HomePageActivateMachineViewController.h"

@interface UpdateCertificateViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 oss手持身份证地址
 */
@property(nonatomic, strong)NSString *ossidCardPictureString;

/**
 leshua手持身份证地址
 */
@property(nonatomic, strong)NSString *leshuaidCardPictureString;

/**
 oss身份证正面地址
 */
@property(nonatomic, strong)NSString *ossIdCardPositiveString;

/**
 leshua身份证正面地址
 */
@property(nonatomic, strong)NSString *leshuaIdCardPositiveString;

/**
 oss身份证反面地址
 */
@property(nonatomic, strong)NSString *ossIdCardReverseString;

/**
 leshua身份证反面地址
 */
@property(nonatomic, strong)NSString *leshuaIdCardReverseString;

/**
 oss银行卡正面
 */
@property(nonatomic, strong)NSString *ossBankCardPositiveString;

/**
 leshua银行卡正面
 */
@property(nonatomic, strong)NSString *leshuaBankCardPositiveString;

@end

@implementation UpdateCertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"证件信息";
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 34)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"请上传真实、匹配的个人信息，认证通过后将无法修改", 1, 153, 153, 153, 1, 255, 255, 255, 2, 10, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 16, 77, 300, 10)];
    
    self.tableView.frame = CGRectMake(0, DelouchStatusBarAndNavigationBarHeight + 34 * self.baseicFloat, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 34 * self.baseicFloat - DelouchTabbarSafeBottomMargin);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            {
                return 326 * self.baseicFloat;
            }
            break;
            
        case 1:
            {
                return 282 * self.baseicFloat;
            }
            break;
            
        default:
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            {
                UpdateIdCardTableViewCell *updateIdCardTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"UpdateIdCardTableViewCell"];
                if (!updateIdCardTableViewCell) {
                    updateIdCardTableViewCell = [[UpdateIdCardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UpdateIdCardTableViewCell"];
                }
                __weak typeof(self) weakSelf = self;
                updateIdCardTableViewCell.updateIdCardPictureBlock = ^(NSString * _Nonnull ossString, NSString * _Nonnull leshuaString) {
                    weakSelf.ossidCardPictureString = ossString;
                    weakSelf.leshuaidCardPictureString = leshuaString;
                    weakSelf.notiString = @"身份证人像面图片上传成功";
                };
                updateIdCardTableViewCell.updateIdCardReverseBlock = ^(NSString * _Nonnull ossString, NSString * _Nonnull leshuaString) {
                    weakSelf.ossIdCardReverseString = ossString;
                    weakSelf.leshuaIdCardReverseString = leshuaString;
                    weakSelf.notiString = @"身份证国徽面图片上传成功";
                };
                updateIdCardTableViewCell.updateIdCardPositiveBlock = ^(NSString * _Nonnull ossString, NSString * _Nonnull leshuaString) {
                    weakSelf.ossIdCardPositiveString = ossString;
                    weakSelf.leshuaIdCardPositiveString = ossString;
                    weakSelf.notiString = @"手持身份证图片上传成功";
                };
                cell = updateIdCardTableViewCell;
            }
            break;
            
        case 1:
            {
                UpdateBankCardTableViewCell *updateBankCardTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"UpdateBankCardTableViewCell"];
                if (!updateBankCardTableViewCell) {
                    updateBankCardTableViewCell = [[UpdateBankCardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UpdateBankCardTableViewCell"];
                }
                __weak typeof(self) weakSelf = self;
                updateBankCardTableViewCell.bankCardPositiveBlock = ^(NSString * _Nonnull ossBankCardPositiveString, NSString * _Nonnull leshuaBankCardPositiveString) {
//                    weakSelf.ossBankCardPositiveString = ossBankCardPositiveString;
//                    weakSelf.leshuaBankCardPositiveString = leshuaBankCardPositiveString;
                    
                    weakSelf.ossBankCardPositiveString = @"111";
                    weakSelf.leshuaBankCardPositiveString = @"111";
                    
                    weakSelf.notiString = @"银行卡图片上传成功";
                };
                [self setbuttonLayer:updateBankCardTableViewCell.updateCertificateButton layerMask:3];
                [updateBankCardTableViewCell.updateCertificateButton addTarget:self action:@selector(updateCertificate) forControlEvents:UIControlEventTouchUpInside];
                cell = updateBankCardTableViewCell;
            }
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)updateCertificate{
    if (self.ossidCardPictureString.length == 0 || self.leshuaidCardPictureString.length == 0) {
        self.notiString = @"身份证人像面图片未成功上传";
    }else if (self.ossIdCardReverseString.length == 0 || self.leshuaIdCardReverseString.length == 0) {
        self.notiString = @"身份证国徽面图片未成功上传";
    }else if (self.ossIdCardPositiveString.length == 0 || self.leshuaIdCardPositiveString.length == 0) {
        self.notiString = @"手持身份证图片未成功上传";
    }else if (self.ossBankCardPositiveString.length == 0 || self.leshuaBankCardPositiveString.length == 0) {
        self.notiString = @"银行卡图片未成功上传";
    }else{
        [self urlHeadStr:PosActivatedURL urlStr:UrlPosActivated parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"userId", self.e_sn, @"e_sn",self.linkman, @"linkman", self.fullName, @"fullName", self.phoneNo, @"phoneNo", self.orgCode, @"orgCode",self.receiveAddress, @"receiveAddress", self.province, @"province",self.city, @"city", self.bankAccountName, @"bankAccountName",self.identityNo, @"identityNo", self.bankAccountNo, @"bankAccountNo",self.bankCode, @"bankCode", self.bankInfoId, @"bankInfoId",self.mobile, @"mobile", self.idcardStart, @"idcardStart",self.idcardEnd, @"idcardEnd", self.ossidCardPictureString, @"url04",self.ossIdCardReverseString, @"url15", self.ossIdCardPositiveString, @"url16",self.ossBankCardPositiveString, @"url18", self.leshuaidCardPictureString, @"url04le",self.leshuaIdCardReverseString, @"url15le", self.leshuaIdCardPositiveString, @"url16le", self.leshuaBankCardPositiveString, @"url18le", nil] Success:^(NSDictionary *obj) {
            self.notiString = @"激活成功";
            HomePageActivateMachineViewController *mainVC = nil;
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[HomePageActivateMachineViewController class]]) {
                    mainVC = (HomePageActivateMachineViewController *)vc;
                }
            }
            [self.navigationController popToViewController:mainVC animated:YES];
        }];
    }
}

@end
