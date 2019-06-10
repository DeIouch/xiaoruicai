//
//  TodayOperationAllTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/11.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodayOperationAllTableViewCell : UITableViewCell

/**
 消费总额
 */
@property(nonatomic, strong)UILabel *totalConsumptionLabel;

/**
 还款总额
 */
@property(nonatomic, strong)UILabel *reimbursementAmountLabel;

/**
 消费总额
 */
@property(nonatomic, strong)NSString *totalConsumptionString;

/**
 还款总额
 */
@property(nonatomic, strong)NSString *reimbursementAmountString;

@end

NS_ASSUME_NONNULL_END
