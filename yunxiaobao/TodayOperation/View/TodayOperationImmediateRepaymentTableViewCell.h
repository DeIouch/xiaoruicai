//
//  TodayOperationImmediateRepaymentTableViewCell.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TodayOperationImmediateRepaymentBlock) (PlanOperationalModel *planOperationalModel);

@interface TodayOperationImmediateRepaymentTableViewCell : UITableViewCell

/**
 还款金额
 */
@property(nonatomic, strong)NSString *repaymentMoneyString;

/**
 还款日期
 */
@property(nonatomic, strong)NSString *repaymentDateString;

/**
 还款类型
 */
@property(nonatomic, strong)NSString *repaymentTypeString;


@property(nonatomic, copy)TodayOperationImmediateRepaymentBlock todayOperationImmediateRepaymentBlock;


@property(nonatomic, strong)PlanOperationalModel *planOperationalModel;

@end
