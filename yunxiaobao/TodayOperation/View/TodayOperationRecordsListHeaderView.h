//
//  TodayOperationRecordsListHeaderView.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayOperationRecordsListHeaderView : UIView

/**
 日期
 */
@property(nonatomic, strong)NSString *dateString;

/**
 收缩list
 */
@property(nonatomic, strong)NSString *showListString;

/**
 消费金额
 */
@property(nonatomic, strong)NSString *consumptionMoneyString;

/**
 还款金额
 */
@property(nonatomic, strong)NSString *repaymentMoneyString;

@end
