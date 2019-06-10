//
//  ShippingAddressListTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^EditAddressInfoBlock) (AddressModel *addressModel, NSString *defaulteAddress);

@interface ShippingAddressListTableViewCell : UITableViewCell

/**
 用户姓名
 */
@property(nonatomic, strong)NSString *nameString;

/**
 手机号码
 */
@property(nonatomic, strong)NSString *phoneString;

/**
 详细地址
 */
@property(nonatomic, strong)NSString *addressString;

/**
 默认地址id
 */
@property(nonatomic, strong)NSString *defaulteAddressString;

/**
 是否选中
 */
@property(nonatomic, assign)BOOL isChooseAddressBOOL;

/**
 是否默认地址
 */
@property(nonatomic, assign)BOOL isDefaultAddressBOOL;

@property(nonatomic, strong)AddressModel *addressModel;

@property(nonnull, copy)EditAddressInfoBlock editAddressInfoBlock;

@end

NS_ASSUME_NONNULL_END
