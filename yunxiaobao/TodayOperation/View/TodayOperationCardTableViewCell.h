//
//  TodayOperationCardTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/11.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TodayOperationCardImmediateConsumptionBlock) (TodayPlanListModel *todayPlanListModel);

typedef void(^TodayOperationCardImmediateRepaymentBlock) (TodayPlanListModel *todayPlanListModel);

@interface TodayOperationCardTableViewCell : UITableViewCell

/**
 银行图标
 */
@property(nonatomic, strong)NSString *bankIconString;

/**
 银行名称
 */
@property(nonatomic, strong)NSString *bankNameString;

/**
 银行卡信息
 */
@property(nonatomic, strong)NSString *bankInfoString;

/**
 操作按钮
 */
@property(nonatomic, strong)NSString *bankOperationString;

/**
 额度信息
 */
@property(nonatomic, strong)NSString *limitString;

/**
 笔数信息
 */
@property(nonatomic, strong)NSString *numberString;

/**
 操作类型
 */
@property(nonatomic, strong)NSString *operationStateString;

@property(nonatomic, strong)TodayPlanListModel *todayPlanListModel;

@property(nonatomic, copy)TodayOperationCardImmediateConsumptionBlock todayOperationCardImmediateConsumptionBlock;

@property(nonatomic, copy)TodayOperationCardImmediateRepaymentBlock todayOperationCardImmediateRepaymentBlock;

@end

NS_ASSUME_NONNULL_END
