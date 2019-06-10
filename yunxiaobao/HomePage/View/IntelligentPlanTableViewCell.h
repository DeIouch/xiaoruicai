//
//  IntelligentPlanTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SetIntelligentPlanBlock) (NeedToPlanModel *needToPlanModel);

@interface IntelligentPlanTableViewCell : UITableViewCell

/**
 银行icon
 */
@property(nonatomic, strong)NSString *bankIconString;

/**
 银行名称
 */
@property(nonatomic, strong)NSString *bankNameString;

/**
 用户信息
 */
@property(nonatomic, strong)NSString *userNameString;

/**
 本期应还
 */
@property(nonatomic, strong)NSString *shouldAlsoString;

/**
 账单日
 */
@property(nonatomic, strong)NSString *orderDayString;

/**
 规划状态
 */
@property(nonatomic, strong)NSString *planStateString;

@property(nonnull, copy)SetIntelligentPlanBlock setIntelligentPlanBlock;

@property(nonatomic, strong)NeedToPlanModel *needToPlanModel;

@end

NS_ASSUME_NONNULL_END
