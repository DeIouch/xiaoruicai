//
//  MakeSureIntelligentPlanViewController.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MakeSureIntelligentPlanViewController : DelouchViewController

/**
 消费总额
 */
@property(nonatomic, strong)NSString *totalConsumptionString;

/**
 还款总额
 */
@property(nonatomic, strong)NSString *totalReimbursementString;

/**
 成本
 */
@property(nonatomic, strong)NSString *costString;

@property(nonatomic, strong)NSString *packageString;

@property(nonatomic, strong)NSString *baseMoneyString;

@property(nonatomic, strong)NSString *haveZhouliu;

@property(nonatomic, strong)NSString *haveZhouRi;

@property(nonatomic, strong)NSString *modeType;

@property(nonatomic, strong)NSString *leshua;

@property(nonatomic, strong)NSString *fulingmen;

@property(nonatomic, strong)NSString *number;

@property(nonatomic, strong)NeedToPlanModel *needToPlanModel;

@property(nonatomic, strong)NSString *availableCreditString;

@property(nonatomic, strong)NSString *shouldAlsoString;

@property(nonatomic, strong)NSString *baseMoneyNumberString;

@end

NS_ASSUME_NONNULL_END
