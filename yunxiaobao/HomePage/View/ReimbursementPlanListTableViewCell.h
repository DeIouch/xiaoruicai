//
//  ReimbursementPlanListTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReimbursementPlanListTableViewCell : UITableViewCell

/**
 还款日期
 */
@property(nonatomic, strong)NSString *dateString;

/**
 还款金额
 */
@property(nonatomic, strong)NSString *moneyString;

@end

NS_ASSUME_NONNULL_END
