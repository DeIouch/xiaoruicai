//
//  CardManageBillingDateilsInfoTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardManageBillingDateilsInfoTableViewCell : UITableViewCell

/**
 账单名称
 */
@property(nonatomic, strong)NSString *billNameString;

/**
 账单日期
 */
@property(nonatomic, strong)NSString *billDateString;

/**
 账单价格
 */
@property(nonatomic, strong)NSString *billPriceString;

/**
 账单icon
 */
@property(nonatomic, strong)NSString *billIconString;

/**
 账单类型
 */
@property(nonatomic, strong)NSString *billTypeString;

@end

NS_ASSUME_NONNULL_END
