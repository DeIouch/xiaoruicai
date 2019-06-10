//
//  CardManageRecordsConsumptionListTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardManageRecordsConsumptionListTableViewCell : UITableViewCell

/**
 消费icon
 */
@property(nonatomic, strong)NSString *recordsConsumptionIconString;

/**
 消费金额
 */
@property(nonatomic, strong)NSString *moneyString;

/**
 消费类型
 */
@property(nonatomic, strong)NSString *typeString;

/**
 消费时间
 */
@property(nonatomic, strong)NSString *dateString;

/**
 消费名称
 */
@property(nonatomic, strong)NSString *nameString;

@end

NS_ASSUME_NONNULL_END
