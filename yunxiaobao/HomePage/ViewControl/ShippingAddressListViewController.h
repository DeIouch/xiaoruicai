//
//  ShippingAddressListViewController.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShippingAddressListViewController : DelouchViewController

@property(nonatomic, strong)AddressModel *addressModel;

@property(nonatomic, strong)NSString *onVc;

@end

NS_ASSUME_NONNULL_END
