//
//  CreateBuyPosOrderViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CreateBuyPosOrderViewController.h"
#import "AddNewAddressTableViewCell.h"
#import "OrderShopListTableViewCell.h"
#import "OrderOtherConfigTableViewCell.h"
#import "OrderAddressTableViewCell.h"
#import "PayMentView.h"


@interface CreateBuyPosOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UILabel *allNumberLabel;

@property(nonatomic, strong)UILabel *allPriceLabel;

@property(nonatomic, strong)UIButton *goPayButton;

@property(nonatomic, assign)NSInteger posNumberInt;

@property(nonatomic, assign)float allPriceInt;

@property(nonatomic, strong)PayMentView *paymentView;

@property(nonatomic, strong)AddressModel *addressModel;

@property(nonatomic, strong)NSMutableArray *shopArray;

@property(nonatomic, strong)NSString *shopString;

@property(nonatomic, strong)NSString *defaulteAddressId;

/**
 是否存在默认地址
 */
@property(nonatomic, assign)BOOL haveDefaulteAddressBOOL;

@property(nonatomic, strong)LongContentTextView *textField;

@end

@implementation CreateBuyPosOrderViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getAddress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"确认订单";
    self.tableView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    self.tableView.frame = CGRectMake(0, DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 49 * self.baseicFloat - DelouchTabbarSafeBottomMargin);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.posNumberInt = [self.posNumberString integerValue];
    self.allPriceInt = [self.allPriceString floatValue];;
    [self.goPayButton addTarget:self action:@selector(goPay) forControlEvents:UIControlEventTouchUpInside];
    self.haveDefaulteAddressBOOL = NO;
    [self getAddress];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectAddress:) name:@"selectAddress" object:nil];
    
    self.shopArray = [[NSMutableArray alloc]init];
    for (PosListModel *model in self.posArray) {
        [self.shopArray addObject:[[NSDictionary alloc]initWithObjectsAndKeys:model.pos_id, @"id", model.pos_number, @"num", nil]];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WxBuyNoti:) name:@"WxBuyNoti" object:nil];
}

-(void)WxBuyNoti:(NSNotification *)noti{
    [self pushViewControl:@"PosPayMentResultViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.allPriceLabel.text, @"moneyString", noti.object, @"payResultString", nil]];
}

-(void)selectAddress:(NSNotification *)noti{
    self.haveDefaulteAddressBOOL = YES;
    AddressModel *model = noti.object;
    self.addressModel = model;
    [self.tableView reloadData];
}

-(void)getAddress{
    [self urlHeadStr:AppPostURL urlStr:UrlGetAddressAll parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
        if ([obj[@"result"][@"list"] isKindOfClass:[NSArray class]]) {
            NSArray *addressArray = obj[@"result"][@"list"];
            if (self.addressModel.telephone.length == 0) {
                if (addressArray.count > 0) {
                    self.addressModel = [[AddressModel alloc]initModelWithDic:obj[@"result"][@"list"][0]];
                    self.haveDefaulteAddressBOOL = YES;
                }else{
                    self.haveDefaulteAddressBOOL = NO;
                }
                for (NSDictionary *dic in obj[@"result"][@"list"]) {
                    AddressModel *model = [[AddressModel alloc]initModelWithDic:dic];
                    if ([model.default_address isEqualToString:@"0"]) {
                        self.addressModel = model;
                        self.defaulteAddressId = model.address_id;
                    }
                }
            }else{
                if (addressArray.count == 0) {
                    self.haveDefaulteAddressBOOL = NO;
                }
            }
        }else{
            self.haveDefaulteAddressBOOL = NO;
        }
        [self.tableView reloadData];
    }];
}

-(void)getDefaultAddress{
    [self urlHeadStr:AppPostURL urlStr:UrlGetDefaultAddress parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
        if ([obj[@"result"][@"list"] isKindOfClass:[NSDictionary class]]) {
            self.haveDefaulteAddressBOOL = YES;
            self.addressModel = [[AddressModel alloc]initModelWithDic:obj[@"result"][@"list"]];
            [self.tableView reloadData];
        }
    }];
}

-(void)goPay{
    if (self.addressModel.consignee.length == 0 && !self.haveDefaulteAddressBOOL) {
        self.notiString = @"请先选择地址";
    }else{
//        NSString *oneString = [[weakSelf.shopArray componentsJoinedByString:@","] stringByReplacingOccurrencesOfString:@";" withString:@","];
//        NSString *twoString = [oneString stringByReplacingOccurrencesOfString:@"=" withString:@":"];
//        [weakSelf urlHeadStr:AppPostURL urlStr:UrlAlipay parameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"[%@]", twoString], @"packageOrders", weakSelf.userInfoModel.user_id, @"user_id", [NSString stringWithFormat:@"收货人信息:%@(联系电话:%@),,备注:%@收货地址:%@", weakSelf.addressModel.consignee, weakSelf.addressModel.telephone, weakSelf.textField.text, weakSelf.addressModel.detail_address], @"order_detail", nil] Success:^(NSDictionary *obj) {
//            [weakSelf goALiPay:obj[@"msg"]];
//        }];
        self.paymentView.hidden = NO;
        self.paymentView.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight);
        [UIView animateWithDuration:0.3 animations:^{
            self.paymentView.backView.frame = CGRectMake(0, DelouchHeight - 267 * (DelouchWidth / 375.0) - DelouchTabbarSafeBottomMargin, DelouchWidth, 267 * (DelouchWidth / 375.0) + DelouchTabbarSafeBottomMargin);
        }];
    }
    
    
    
//    self.paymentView.hidden = NO;
//    self.paymentView.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight);
//    [UIView animateWithDuration:0.3 animations:^{
//        self.paymentView.backView.frame = CGRectMake(0, DelouchHeight - 267 * (DelouchWidth / 375.0) - DelouchTabbarSafeBottomMargin, DelouchWidth, 267 * (DelouchWidth / 375.0) + DelouchTabbarSafeBottomMargin);
//    }];
}

-(void)chooseAddress{
    [self pushViewControl:@"ShippingAddressListViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.addressModel, @"addressModel", nil]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.posArray.count + 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (self.haveDefaulteAddressBOOL) {
            return 112 * self.baseicFloat;
        }
        return 74 * self.baseicFloat;
    }else if (indexPath.row == self.posArray.count + 1) {
        return 203 * self.baseicFloat;
    }else {
        return 97 * self.baseicFloat;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        if (self.haveDefaulteAddressBOOL) {
            OrderAddressTableViewCell *orderAddressTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"OrderAddressTableViewCell"];
            if (!orderAddressTableViewCell) {
                orderAddressTableViewCell = [[OrderAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderAddressTableViewCell"];
            }
            orderAddressTableViewCell.nameString = self.addressModel.consignee;
            orderAddressTableViewCell.phoneString = self.addressModel.telephone;
            orderAddressTableViewCell.addressString = [NSString stringWithFormat:@"%@", self.addressModel.detail_address];
            [orderAddressTableViewCell.chooseAddressButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAddress)]];
            cell = orderAddressTableViewCell;
        }else{
            AddNewAddressTableViewCell *addNewAddressTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"AddNewAddressTableViewCell"];
            if (!addNewAddressTableViewCell) {
                addNewAddressTableViewCell = [[AddNewAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddNewAddressTableViewCell"];
            }
            addNewAddressTableViewCell.addNewAddressBlock = ^{
                [self pushViewControl:@"AddNewShipAddressViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:@"addAddress", @"addressType", @"NO", @"haveDefaulteAddress", self.defaulteAddressId, @"defaulteAddressString", nil]];
            };
            cell = addNewAddressTableViewCell;
        }
    }else if (indexPath.row == self.posArray.count + 1) {
        OrderOtherConfigTableViewCell *orderOtherConfigTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"OrderOtherConfigTableViewCell"];
        if (!orderOtherConfigTableViewCell) {
            orderOtherConfigTableViewCell = [[OrderOtherConfigTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderOtherConfigTableViewCell"];
        }
        self.textField = orderOtherConfigTableViewCell.textField;
        cell = orderOtherConfigTableViewCell;
    }else {
        OrderShopListTableViewCell *orderShopListTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"OrderShopListTableViewCell"];
        if (!orderShopListTableViewCell) {
            orderShopListTableViewCell = [[OrderShopListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderShopListTableViewCell"];
        }
        PosListModel *model = self.posArray[indexPath.row - 1];
        orderShopListTableViewCell.posNameString = model.pos_name;
        orderShopListTableViewCell.posPriceString = model.pos_price;
        orderShopListTableViewCell.posNumberString = model.pos_number;
        orderShopListTableViewCell.posIconString = model.pos_img;
        cell = orderShopListTableViewCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIButton *)goPayButton{
    if (!_goPayButton) {
        _goPayButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"去付款", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 260 * self.baseicFloat, DelouchHeight - DelouchTabbarSafeBottomMargin - 45 * self.baseicFloat, 100 * self.baseicFloat, 40 * self.baseicFloat)];
        [self setbuttonLayer:_goPayButton layerMask:3];
    }
    return _goPayButton;
}

-(UILabel *)allNumberLabel{
    if (!_allNumberLabel) {
        _allNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 15 * self.baseicFloat, DelouchHeight - DelouchTabbarSafeBottomMargin - 30 * self.baseicFloat, 70 * self.baseicFloat, 12 * self.baseicFloat)];
    }
    return _allNumberLabel;
}

-(UILabel *)allPriceLabel{
    if (!_allPriceLabel) {
        _allPriceLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 86, 112, 254, 1, 255, 255, 255, 2, 18, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 90 * self.baseicFloat, DelouchHeight - DelouchTabbarSafeBottomMargin - 34 * self.baseicFloat, 100 * self.baseicFloat, 17 * self.baseicFloat)];
    }
    return _allPriceLabel;
}

-(void)setPosNumberInt:(NSInteger)posNumberInt{
    _posNumberInt = posNumberInt;
    self.allNumberLabel.frame = CGRectMake(self.allNumberLabel.frame.origin.x, self.allNumberLabel.frame.origin.y, [DelouchLibrary sizeWithText:self.allNumberLabel.text withFont:12].width, self.allNumberLabel.frame.size.height);
    self.allPriceLabel.frame = CGRectMake(5 * (DelouchWidth / 375.0) +self.allNumberLabel.frame.origin.x + self.allNumberLabel.frame.size.width, self.allPriceLabel.origin.y, self.allPriceLabel.frame.size.width, self.allPriceLabel.frame.size.height);
    self.allNumberLabel.text = [NSString stringWithFormat:@"共%ld件，总计:", posNumberInt];
}

-(void)setAllPriceInt:(float)allPriceInt{
    _allPriceInt = allPriceInt;
    self.allPriceLabel.text = [NSString stringWithFormat:@"¥%0.2lf", allPriceInt];
}

-(PayMentView *)paymentView{
    if(!_paymentView){
        _paymentView = [[PayMentView alloc]init];
        _paymentView.moneyString = [NSString stringWithFormat:@"¥%@", self.allPriceString];
        _paymentView.choosePaymentTypeBOOL = YES;
        [[[UIApplication sharedApplication] keyWindow]addSubview:_paymentView];
        __weak typeof(self) weakSelf = self;
        _paymentView.payMentBlock = ^{
//            if (weakSelf.addressModel.consignee.length == 0 && !self.haveDefaulteAddressBOOL) {
//                weakSelf.notiString = @"请先选择地址";
//            }else{
                NSString *oneString = [[weakSelf.shopArray componentsJoinedByString:@","] stringByReplacingOccurrencesOfString:@";" withString:@","];
                NSString *twoString = [oneString stringByReplacingOccurrencesOfString:@"=" withString:@":"];
                [weakSelf urlHeadStr:AppPostURL urlStr:UrlAlipay parameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"[%@]", twoString], @"packageOrders", weakSelf.userInfoModel.user_id, @"user_id", [NSString stringWithFormat:@"收货人信息:%@(联系电话:%@),,备注:%@收货地址:%@", weakSelf.addressModel.consignee, weakSelf.addressModel.telephone, weakSelf.textField.text, weakSelf.addressModel.detail_address], @"order_detail", nil] Success:^(NSDictionary *obj) {
                    [weakSelf goALiPay:obj[@"msg"]];
                }];
//            }
        };
    }
    return _paymentView;
}

-(void)goALiPay:(NSString *)str{
    [[AlipaySDK defaultService] payOrder:str fromScheme:@"rzjfDelouch" callback:^(NSDictionary *resultDic) {
        NSLog(@"resultDic  ==  %@", [self dictionaryWithJsonString:resultDic[@"result"]]);
        NSDictionary *dic = [self dictionaryWithJsonString:resultDic[@"result"]];
        if ([dic[@"alipay_trade_app_pay_response"][@"msg"] isEqualToString:@"Success"]) {
//            self.notiString = @"购买成功";
            
            [self pushViewControl:@"PosPayMentResultViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.allPriceLabel.text, @"moneyString", @"success", @"payResultString", nil]];
//            [self popVC];
        }else{
//            self.notiString = @"购买失败";
            
            [self pushViewControl:@"PosPayMentResultViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.allPriceLabel.text, @"moneyString", @"error", @"payResultString", nil]];
            
        }
    }];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        return nil;
    }
    return dic;
}

@end
