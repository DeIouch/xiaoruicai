//
//  AddNewShipAddressViewController.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddNewShipAddressViewController : DelouchViewController

@property(nonatomic, strong)NSString *addressType;

/**
 是否有默认地址
 */
@property(nonatomic, strong)NSString *haveDefaulteAddress;

@property(nonatomic, strong)AddressModel *addressModel;

@property(nonatomic, strong)NSString *defaulteAddressString;

@end

NS_ASSUME_NONNULL_END
