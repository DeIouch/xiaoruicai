//
//  SetintelligentPlanInfoViewController.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetintelligentPlanInfoViewController : DelouchViewController

/**
 选择收费基数
 */
@property(nonatomic, strong)NSString *baseMoneyString;

/**
 选择套餐
 */
@property(nonatomic, strong)NSString *packageString;

@property(nonatomic, strong)NeedToPlanModel *needToPlanModel;

@property(nonatomic, strong)NSString *availableCreditString;

@property(nonatomic, strong)NSString *shouldAlsoString;

@property(nonatomic, strong)NSString *baseMoneyNumberString;

@end

NS_ASSUME_NONNULL_END
