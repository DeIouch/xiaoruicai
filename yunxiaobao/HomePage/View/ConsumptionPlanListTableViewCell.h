//
//  ConsumptionPlanListTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConsumptionPlanListTableViewCell : UITableViewCell

/**
 消费头像
 */
@property(nonatomic, strong)NSString *typeString;

/**
 消费名称
 */
@property(nonatomic, strong)NSString *consumptionNameString;

/**
 消费类型
 */
@property(nonatomic, strong)NSString *consumptionTypeString;

/**
 消费金额
 */
@property(nonatomic, strong)NSString *consumptionNumberString;

@end

NS_ASSUME_NONNULL_END
