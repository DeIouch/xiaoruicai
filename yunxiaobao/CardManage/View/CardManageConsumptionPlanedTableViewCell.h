//
//  CardManageConsumptionPlanedTableViewCell.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CardManageConsumptionPlanedSelectShopBlock) (NSString *planId);

typedef void(^CardManageConsumptionPlanedDeleteShopBlock) (NSString *planId);

@interface CardManageConsumptionPlanedTableViewCell : UITableViewCell

/**
 是否已消费
 */
@property(nonatomic, strong)NSString *consumeredString;

/**
 等待消费
 */
@property(nonatomic, strong)UILabel *waitConsumerLabel;

/**
 消费类型
 */
@property(nonatomic, strong)NSString *consumerTypeString;

/**
 消费商户
 */
@property(nonatomic, strong)NSString *consumerShopString;

/**
 消费金额
 */
@property(nonatomic, strong)NSString *consumerMoneyString;

//@property(nonatomic, strong)GetOperatingInfoModel *getOperatingInfoModel;

@property(nonatomic, strong)NSString *planIdString;

//@property(nonatomic, strong)OperatingListModel *operatingListModel;

@property(nonatomic, copy)CardManageConsumptionPlanedSelectShopBlock cardManageConsumptionPlanedSelectShopBlock;

@property(nonatomic, copy)CardManageConsumptionPlanedDeleteShopBlock cardManageConsumptionPlanedDeleteShopBlock;

@end
