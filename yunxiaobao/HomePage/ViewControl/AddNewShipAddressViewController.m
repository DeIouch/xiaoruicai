//
//  AddNewShipAddressViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "AddNewShipAddressViewController.h"
#import "UITextView+LZBExtention.h"

@interface AddNewShipAddressViewController ()

/**
 用户姓名
 */
@property(nonatomic, strong)UITextField *nameTextField;

/**
 手机号码
 */
@property(nonatomic, strong)UITextField *phoneTextField;

/**
 地区信息
 */
@property(nonatomic, strong)UILabel *cityLabel;

/**
 详细地址
 */
@property(nonatomic, strong)UITextView *addressDetailTextView;

/**
 保存
 */
@property(nonatomic, strong)UIButton *saveButton;

/**
 选择城市
 */
@property(nonatomic, strong)UIImageView *chooseCityImageView;

/**
 是否为默认地址
 */
@property(nonatomic, strong)UIImageView *isDefaulteImageView;

/**
 是否为默认地址
 */
@property(nonatomic, assign)BOOL isDefaulteBOOL;

/**
 地址id
 */
@property(nonatomic, strong)NSString *addressID;

@end

@implementation AddNewShipAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    if ([self.addressType isEqualToString:@"addAddress"]) {
        self.titleString = @"新增收货地址";
        self.addressDetailTextView.bgm_placeholder = @"请输入详细地址";
        self.nameTextField.placeholder = @"请使用真实姓名";
        self.phoneTextField.placeholder = @"请输入手机号码";
        self.cityLabel.text = @"请选择";
        self.addressID = @"";
        self.isDefaulteBOOL = YES;
    }else{
        self.titleString = @"修改收货地址";
        self.infoDic = DelouchRightButtonInfomake(@"删除", 51, 51, 51, 1, 255, 255, 255, 2, 15);
        self.nameTextField.text = self.addressModel.consignee;
        self.phoneTextField.text = self.addressModel.telephone;
        NSArray *addressArray = [self.addressModel.detail_address componentsSeparatedByString:@" "];
        
        for (int i = 0; i < addressArray.count - 1; i++) {
            self.cityLabel.text = [NSString stringWithFormat:@"%@%@", self.cityLabel.text, addressArray[i]];
        }
//        self.cityLabel.text = [NSString stringWithFormat:@"%@%@%@", addressArray[0], addressArray[1], addressArray[2]];
        self.addressDetailTextView.text = addressArray[addressArray.count - 1];
        self.cityLabel.textAlignment = NSTextAlignmentLeft;
        self.cityLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
        self.addressID = self.addressModel.address_id;
        self.isDefaulteBOOL = [self.addressModel.default_address isEqualToString:@"0"] ? YES : NO;
    }
    [self.saveButton addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseCityImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseCity)]];
}

-(void)chooseCity{
    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:nil defaultSelected:nil isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        self.cityLabel.text = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
        self.cityLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
    } cancelBlock:^{
        
    }];
}

-(void)saveAddress{
    if ([self.haveDefaulteAddress isEqualToString:@"NO"]) {
        _isDefaulteBOOL = YES;
    }
    if (self.nameTextField.text.length == 0) {
        self.notiString = @"请输入姓名";
    }else if (self.phoneTextField.text.length != 11) {
        self.notiString = @"请输入正确的手机号";
    }else if (self.cityLabel.text.length == 0) {
        self.notiString = @"请选择城市";
    }else if (self.addressDetailTextView.text.length == 0) {
        self.notiString = @"请输入详细地址";
    }else{
        [self urlHeadStr:AppPostURL urlStr:UrlSaveAddress parameters:[NSDictionary dictionaryWithObjectsAndKeys: self.nameTextField.text, @"consignee", @"1", @"province", @"1", @"city", @"1", @"district", self.phoneTextField.text, @"telephone", [NSString stringWithFormat:@"%@ %@", self.cityLabel.text, self.addressDetailTextView.text], @"detail_address", [NSString stringWithFormat:@"%@", _isDefaulteBOOL ? @"0" : @"1"], @"default_address", self.userInfoModel.user_id, @"user_id", self.addressID, @"addressId", [self.defaulteAddressString intValue] == [self.addressID intValue] ? @"" : self.defaulteAddressString, @"addid", nil] Success:^(NSDictionary *obj) {
            if ([self.addressType isEqualToString:@"addAddress"]) {
                self.notiString = @"新增地址成功";
            }else{
                self.notiString = @"修改地址成功";
            }
            [self popVC];
        }];
    }
}

-(void)rightSelect{
    UIAlertController *deleteAlert=[UIAlertController
                                    alertControllerWithTitle: nil
                                    message:@"是否删除此收货地址?"
                                    preferredStyle:UIAlertControllerStyleAlert
                                    ];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [cancelAction setValue:[UIColor colorWithRed:9 / 255.0 green:1 / 255.0 blue:3 / 255.0 alpha:1] forKey:@"titleTextColor"];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf deleteAddress];
    }];
    [deleteAction setValue:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forKey:@"titleTextColor"];
    [deleteAlert addAction:deleteAction];
    [deleteAlert addAction:cancelAction];
    [self presentViewController:deleteAlert animated:true completion:nil];
}

-(void)deleteAddress{
    [self urlHeadStr:AppPostURL urlStr:UrlDelAddress parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.addressModel.address_id, @"id", nil] Success:^(NSDictionary *obj) {
        self.notiString = @"删除成功";
        [self popVC];
    }];
}

-(void)changeDefalute{
    self.isDefaulteBOOL = !self.isDefaulteBOOL;
}

-(void)createUI{
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 279)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 113, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 162, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 211, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 283, 375, 10)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"收货人:", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 16, 82, 73, 13)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"手机号码:", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 16, 131, 73, 13)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"所在地区:", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 16, 180, 73, 13)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"详细地址:", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 16, 226, 73, 13)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"设置为默认地址", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 311, 100, 14)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"(注:每次下单时会使用该地址）", 1, 133, 133, 133, 1, 255, 255, 255, 2, 10, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 123, 313, 150, 10)];
}

-(UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 89, 82, 268, 14)];
    }
    return _nameTextField;
}

-(UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 89, 131, 268, 14)];
    }
    return _phoneTextField;
}

-(UILabel *)cityLabel{
    if (!_cityLabel) {
        _cityLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 89, 180, 258, 14)];
    }
    return _cityLabel;
}

-(UITextView *)addressDetailTextView{
    if (!_addressDetailTextView) {
        _addressDetailTextView = [[UITextView alloc]initWithFrame:CGRectMake(89 * self.baseicFloat, 154 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 254 * self.baseicFloat, 44 * self.baseicFloat)];
        _addressDetailTextView.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
        _addressDetailTextView.font = [UIFont systemFontOfSize:14 * self.baseicFloat];
        _addressDetailTextView.bgm_placeholderFont = [UIFont systemFontOfSize:14 * self.baseicFloat];
        _addressDetailTextView.bgm_placeholderColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
        [self.view addSubview:_addressDetailTextView];
    }
    return _addressDetailTextView;
}

-(UIImageView *)chooseCityImageView{
    if (!_chooseCityImageView) {
        _chooseCityImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 341, 172, 26, 30)];
        _chooseCityImageView.contentMode = UIViewContentModeCenter;
    }
    return _chooseCityImageView;
}

-(UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"保存", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 372, 345, 44)];
        [self setbuttonLayer:_saveButton layerMask:3];
    }
    return _saveButton;
}

-(UIImageView *)isDefaulteImageView{
    if (!_isDefaulteImageView) {
        _isDefaulteImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_switchOff, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 292, 293, 81, 51)];
        [_isDefaulteImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeDefalute)]];
    }
    return _isDefaulteImageView;
}

-(void)setIsDefaulteBOOL:(BOOL)isDefaulteBOOL{
    _isDefaulteBOOL = isDefaulteBOOL;
    if (isDefaulteBOOL) {
        self.isDefaulteImageView.image = [UIImage imageNamed:icon_switchOn];
    }else{
        self.isDefaulteImageView.image = [UIImage imageNamed:icon_switchOff];
    }
}

@end
