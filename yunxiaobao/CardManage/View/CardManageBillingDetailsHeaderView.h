//
//  CardManageBillingDetailsHeadView.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardManageBillingDetailsHeaderView : UIView

/**
 月份
 */
@property(nonatomic, strong)NSString *mouthString;

/**
 日期
 */
@property(nonatomic, strong)NSString *dateString;

/**
 金额
 */
@property(nonatomic, strong)NSString *moneyNumberString;

/**
 还款金额
 */
@property(nonatomic, strong)NSString *repaymentMoneyNumberString;

/**
 出帐日期
 */
@property(nonatomic, strong)NSString *billTypeString;

/**
 到期时间
 */
@property(nonatomic, strong)NSString *endDayString;

@end

NS_ASSUME_NONNULL_END
