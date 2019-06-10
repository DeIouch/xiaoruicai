//
//  ShippingAddressListViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ShippingAddressListViewController.h"
#import "ShippingAddressListTableViewCell.h"
#import "AddNewShipAddressViewController.h"
#import "AddNewShipAddressViewController.h"

@interface ShippingAddressListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, assign)BOOL tableHaveBool;

@property(nonatomic, strong)NSString *defaulteAddressId;

@end

@implementation ShippingAddressListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.defaulteAddressId = @"";
    [self getAddress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"收货地址管理";
    self.rightImageString = icon_addAddress;
}

-(void)getAddress{
    [self urlHeadStr:AppPostURL urlStr:UrlGetAddressAll parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
        if ([obj[@"result"][@"list"] isKindOfClass:[NSArray class]]) {
            self.tableHaveBool = YES;
            self.tableView.hidden = NO;
            [self.dataArray removeAllObjects];
            for (NSDictionary *dic in obj[@"result"][@"list"]) {
                AddressModel *model = [[AddressModel alloc]initModelWithDic:dic];
                if ([model.default_address isEqualToString:@"0"]) {
                    self.defaulteAddressId = dic[@"id"];
                }
                [self.dataArray addObject:[[AddressModel alloc]initModelWithDic:dic]];
            }
            [self.tableView reloadData];
        }else{
            self.tableView.hidden = YES;
            [self createNoAddressUI];
        }
    }];
}

-(void)createNoAddressUI{
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_zwdz, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 63, 185, 251, 132)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"您暂时没有收货地址哦", 2, 153, 153, 153, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 345, 375, 16)];
}

-(void)rightSelect{
    AddNewShipAddressViewController *vc = [[AddNewShipAddressViewController alloc]init];
    vc.addressType = @"addAddress";
    vc.defaulteAddressString = self.defaulteAddressId;
    [self.navigationController pushViewController:vc animated:YES];
//    [self pushViewControl:@"AddNewShipAddressViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:@"addAddress", @"addressType",  self.defaulteAddressId, @"defaulteAddressString", nil]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShippingAddressListTableViewCell *shippingAddressListTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ShippingAddressListTableViewCell"];
    if (!shippingAddressListTableViewCell) {
        shippingAddressListTableViewCell = [[ShippingAddressListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShippingAddressListTableViewCell"];
    }
    AddressModel *model = self.dataArray[indexPath.row];    
    shippingAddressListTableViewCell.nameString = model.consignee;
    shippingAddressListTableViewCell.phoneString = model.telephone;
    shippingAddressListTableViewCell.addressString = [NSString stringWithFormat:@"%@", [model.detail_address stringByReplacingOccurrencesOfString:@" " withString:@""]];
    shippingAddressListTableViewCell.addressModel = model;
    shippingAddressListTableViewCell.defaulteAddressString = self.defaulteAddressId;
    shippingAddressListTableViewCell.isDefaultAddressBOOL = [model.default_address isEqualToString:@"0"] ? YES : NO;
    if ([model.address_id isEqualToString:self.addressModel.address_id]) {
        shippingAddressListTableViewCell.isChooseAddressBOOL = YES;
    }else{
        shippingAddressListTableViewCell.isChooseAddressBOOL = NO;
    }
    
//    NSLog(@"defaulteAddressId  ==  %@", self.defaulteAddressId);
    
    shippingAddressListTableViewCell.editAddressInfoBlock = ^(AddressModel * _Nonnull addressModel, NSString * _Nonnull defaulteAddress) {
        AddNewShipAddressViewController *vc = [[AddNewShipAddressViewController alloc]init];
        vc.addressType = @"editAddress";
        vc.addressModel = model;
        vc.defaulteAddressString = defaulteAddress;
        [self.navigationController pushViewController:vc animated:YES];
        
//        [self pushViewControl:@"AddNewShipAddressViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:@"editAddress", @"addressType", model, @"addressModel", defaulteAddress, @"defaulteAddressString", nil]];
    };
    
//    shippingAddressListTableViewCell.editAddressInfoBlock = ^(AddressModel * _Nonnull model) {
//        [self pushViewControl:@"AddNewShipAddressViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:@"editAddress", @"addressType", model, @"addressModel", self.defaulteAddressId, @"defaulteAddressString", nil]];
//        NSLog(@"defaulteAddressId  ==  %@", self.defaulteAddressId);
//    };
    shippingAddressListTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return shippingAddressListTableViewCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![self.onVc isEqualToString:@"not"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectAddress" object:self.dataArray[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)setTableHaveBool:(BOOL)tableHaveBool{
    if (tableHaveBool) {
        self.tableView.frame = [self setTableViewNoBarFrame];
        self.tableView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
}

@end
