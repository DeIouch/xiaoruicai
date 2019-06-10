//
//  ActivateMachineInfoViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ActivateMachineInfoViewController.h"
#import "UITextView+LZBExtention.h"
#import "ActivitePosInfoTableViewCell.h"
#import "QueryBankInfoByBankNameModel.h"
#import "SelectOperationTypeView.h"

@interface ActivateMachineInfoViewController ()<UITableViewDelegate, UITableViewDataSource, SelectOperationTypeDelegate>

/**
 下一步
 */
@property(nonatomic, strong)UIButton *nextStepButton;

/**
 SN码
 */
@property(nonatomic, strong)UITextField *snTextField;

/**
 商户行
 */
@property(nonatomic, strong)UITextField *shopNameTextField;

/**
 商户手机号
 */
@property(nonatomic, strong)UITextField *phoneTextField;

/**
 商户姓名
 */
@property(nonatomic, strong)UITextField *shopNickNameTextField;

/**
 身份证输入框
 */
@property(nonatomic, strong)UITextField *idNameTextField;

/**
 收款银行卡输入框
 */
@property(nonatomic, strong)UITextField *shoukuanBankTextField;

/**
 银行名称
 */
@property(nonatomic, strong)UITextField *bankNameTextField;

/**
 银行所在地
 */
@property(nonatomic, strong)UILabel *bankPlaceLabel;

/**
 银行网点
 */
@property(nonatomic, strong)UILabel *bankDianLabel;

/**
 开户名输入框
 */
@property(nonatomic, strong)UITextField *kaiHuMingTextField;

/**
 银行支行编号
 */
@property(nonatomic, strong)NSString *bankIdString;

/**
 预留手机号
 */
@property(nonatomic, strong)UITextField *yuliuPhoneTextField;

/**
 地址
 */
@property(nonatomic, strong)UILabel *addressLabel;

/**
 身份证开始时间
 */
@property(nonatomic, strong)UILabel *idStartLabel;

/**
 身份证结束时间
 */
@property(nonatomic, strong)UILabel *idEndLabel;

/**
 详细地址
 */
@property(nonatomic, strong)UITextField *addressInfoTextField;

/**
 省ID
 */
@property(nonatomic, strong)NSString *provinceID;

/**
 市ID
 */
@property(nonatomic, strong)NSString *cityID;

/**
 区ID
 */
@property(nonatomic, strong)NSString *orgCodeID;

/**
 类型选择view
 */
@property(nonatomic, strong)SelectOperationTypeView *selectOperationTypeView;

@end

@implementation ActivateMachineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    self.titleString = @"基本资料";
    
//    [self urlHeadStr:AppAreaCodeURL urlStr:UrlQeryAllProvince parameters:nil Success:^(NSDictionary *obj) {
//        [obj[@"result"] writeToFile:@"/Users/rzjf/Desktop/Model/address.plist" atomically:YES];
//    }];
    
}

-(void)createUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = [self setTableViewNoBarFrame];
}

/**
 选择详细地址
 */
-(void)chooseInfoAddress{
    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:nil defaultSelected:nil isAutoSelect:NO themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@", province.name, city.name, area.name];
        [self urlHeadStr:AppAreaCodeURL urlStr:UrlQeryAllProvince parameters:nil Success:^(NSDictionary *obj) {
            for (NSDictionary *dic in obj[@"result"]) {
                if ([province.name isEqualToString:dic[@"province"]]) {
                    self.provinceID = dic[@"parent_code"];
                    [self urlHeadStr:AppAreaCodeURL urlStr:UrlQueryAreaByProvince parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.provinceID, @"parent_code", nil] Success:^(NSDictionary *obj) {
                        for (NSDictionary *dic in obj[@"result"]) {
                            if ([city.name isEqualToString:dic[@"area_name"]]) {
                                self.cityID = dic[@"area_code"];
                                [self urlHeadStr:AppAreaCodeURL urlStr:UrlQueryAreaByProvince parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.cityID, @"parent_code", nil] Success:^(NSDictionary *obj) {
                                    for (NSDictionary *dic in obj[@"result"]) {
                                        if ([area.name isEqualToString:dic[@"area_name"]]) {
                                            self.orgCodeID = dic[@"area_code"];
                                        }
                                    }
                                }];
                                
                            }
                        }
                    }];
                }
            }
        }];
    } cancelBlock:^{
        
    }];
}

- (void)didSelectTypeAtIndexPath:(NSIndexPath *)indexPath{
    QueryBankInfoByBankNameModel *model = self.dataArray[indexPath.row];
    self.bankPlaceLabel.text = model.code;
    self.bankIdString = model.bank_id;
}

/**
 选择银行地址
 */
-(void)chooseBankAddress{
    if (self.bankNameTextField.text.length == 0) {
        self.notiString = @"请先输入银行名称";
        }else{
        [self urlHeadStr:AppBankInfoURL urlStr:UrlQueryBankInfoByBankName parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.bankNameTextField.text, @"bankName", nil] Success:^(NSDictionary *obj) {
            [self.dataArray removeAllObjects];
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in obj[@"result"]) {
                [array addObject:dic[@"full_name"]];
                [self.dataArray addObject:[[QueryBankInfoByBankNameModel alloc]initModelWithDic:dic]];
            }
            self.selectOperationTypeView.typeArray = array;
            self.selectOperationTypeView.hidden = NO;
//            self.selectOperationTypeView.typeArray = array;
        }];
    }
}

/**
 选择身份证开始日期
 */
-(void)chooseIdStartTime{
    [BRDatePickerView showDatePickerWithTitle:nil dateType:BRDatePickerModeYMD defaultSelValue:nil resultBlock:^(NSString *selectValue) {
        self.idStartLabel.text = selectValue;
    }];
}

/**
 选择身份证结束日期
 */
-(void)chooseIdEndTime{
    [BRDatePickerView showDatePickerWithTitle:nil dateType:BRDatePickerModeYMD defaultSelValue:nil resultBlock:^(NSString *selectValue) {
        self.idEndLabel.text = selectValue;
    }];
}

-(void)next{
    if (self.snTextField.text.length == 0 || self.shopNickNameTextField.text == 0 || self.phoneTextField.text == 0 || self.idNameTextField.text == 0 || self.shoukuanBankTextField.text == 0 || self.bankNameTextField.text == 0 || self.bankPlaceLabel.text == 0 || self.phoneTextField.text == 0 || self.addressLabel.text == 0 || self.addressInfoTextField.text == 0 || self.idStartLabel.text == 0 || self.idEndLabel.text == 0 || self.yuliuPhoneTextField.text == 0 || self.bankIdString.length == 0 || self.provinceID.length == 0 || self.cityID.length == 0 || self.orgCodeID.length == 0) {
        self.notiString = @"信息请填写完整";
    }else{
        [self pushViewControl:@"UpdateCertificateViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.snTextField.text, @"e_sn", self.shopNickNameTextField.text, @"linkman", self.phoneTextField.text, @"phoneNo", self.orgCodeID, @"orgCode", self.addressInfoTextField.text, @"receiveAddress", self.provinceID, @"province", self.cityID, @"city", self.kaiHuMingTextField.text, @"bankAccountName", self.idNameTextField.text, @"identityNo", self.shoukuanBankTextField.text, @"bankAccountNo", self.bankPlaceLabel.text, @"bankCode", self.bankIdString, @"bankInfoId", self.yuliuPhoneTextField.text, @"mobile", self.idStartLabel.text, @"idcardStart", self.idEndLabel.text, @"idcardEnd", self.shopNameTextField.text, @"fullName", nil]];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivitePosInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ActivitePosInfoTableViewCell %ld", indexPath.row]];
    if (!cell) {
        cell = [[ActivitePosInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"ActivitePosInfoTableViewCell %ld", indexPath.row]];
    }
    switch (indexPath.row) {
        case 0:
            {
                cell.titleString = @"sn码";
                self.snTextField = cell.infoTextField;
                self.snTextField.text = self.appPosModel.a_sn;
            }
            break;
            
        case 1:
            {
                cell.titleString = @"商户名称";
                self.shopNameTextField = cell.infoTextField;
                self.shopNameTextField.placeholder = @"请输入商户名称";
            }
            break;
            
        case 2:
            {
                cell.titleString = @"商户姓名";
                self.shopNickNameTextField = cell.infoTextField;
                self.shopNickNameTextField.placeholder = @"请输入商户姓名";
            }
            break;
            
        case 3:
            {
                cell.titleString = @"商户手机号";
                self.phoneTextField = cell.infoTextField;
                self.phoneTextField.placeholder = @"请输您的手机号";
            }
            break;
            
            
            
        case 4:
            {
                cell.titleString = @"身份证号码";
                self.idNameTextField = cell.infoTextField;
                self.idNameTextField.placeholder = @"请输入您的身份证号码";
            }
            break;
            
        case 5:
            {
                cell.titleString = @"收款银行卡号";
                self.shoukuanBankTextField = cell.infoTextField;
                self.shoukuanBankTextField.placeholder = @"请输入您的银行卡号";
            }
            break;
            
        case 6:
            {
                cell.titleString = @"银行名称";
                self.bankNameTextField = cell.infoTextField;
                self.bankNameTextField.placeholder = @"请输入银行名称";
            }
            break;
            
        case 7:
            {
                cell.titleString = @"结算卡开户银行编码";
                self.bankPlaceLabel = cell.infoLabel;
                [cell.chooseButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBankAddress)]];
            }
            break;
            
        case 8:
            {
                cell.titleString = @"预留手机号";
                self.yuliuPhoneTextField = cell.infoTextField;
                self.yuliuPhoneTextField.placeholder = @"请输入预留手机号";
            }
            break;
            
        case 9:
            {
                cell.titleString = @"开户名";
                self.kaiHuMingTextField = cell.infoTextField;
                self.kaiHuMingTextField.placeholder = @"请输入开户名";
            }
            break;
            
            
            
        case 10:
            {
                cell.titleString = @"身份证开始日期";
                self.idStartLabel = cell.infoLabel;
                [cell.chooseButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseIdStartTime)]];
            }
            break;
            
        case 11:
            {
                cell.titleString = @"身份证结束时间";
                self.idEndLabel = cell.infoLabel;
                [cell.chooseButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseIdEndTime)]];
            }
            break;
            
        case 12:
            {
                cell.titleString = @"详细地址";
                self.addressLabel = cell.infoLabel;
                [cell.chooseButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseInfoAddress)]];
            }
            break;
            
        case 13:
            {
                self.addressInfoTextField = cell.addressTextField;
                self.addressInfoTextField.placeholder = @"请输入详细地址";
            }
            break;
            
        case 14:
            {
                [cell.nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(SelectOperationTypeView *)selectOperationTypeView{
    if (!_selectOperationTypeView) {
        _selectOperationTypeView = [[SelectOperationTypeView alloc]init];
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (QueryBankInfoByBankNameModel *model in self.dataArray) {
            [array addObject:model.full_name];
        }
        _selectOperationTypeView.titleString = @"选择银行";
        _selectOperationTypeView.typeArray = array;
        _selectOperationTypeView.delegate = self;
        [self.view addSubview:_selectOperationTypeView];
    }
    return _selectOperationTypeView;
}

@end
