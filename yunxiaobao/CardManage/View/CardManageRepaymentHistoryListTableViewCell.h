//
//  CardManageRepaymentHistoryListTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardManageRepaymentHistoryListTableViewCell : UITableViewCell

/**
 账单icon
 */
@property(nonatomic, strong)NSString *repaymentHistoryIconString;

/**
 账单金额
 */
@property(nonatomic, strong)NSString *moneyString;

/**
 账单类型
 */
@property(nonatomic, strong)NSString *typeString;

/**
 日期
 */
@property(nonatomic, strong)NSString *dateString;

@end

NS_ASSUME_NONNULL_END
