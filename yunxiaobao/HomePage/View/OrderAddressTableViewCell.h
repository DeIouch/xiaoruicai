//
//  OrderAddressTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderAddressTableViewCell : UITableViewCell

/**
 用户姓名
 */
@property(nonatomic, strong)NSString *nameString;

/**
 用户号码
 */
@property(nonatomic, strong)NSString *phoneString;

/**
 收货地址
 */
@property(nonatomic, strong)NSString *addressString;

/**
 选择收货地址
 */
@property(nonatomic, strong)UIImageView *chooseAddressButton;

@end

NS_ASSUME_NONNULL_END
