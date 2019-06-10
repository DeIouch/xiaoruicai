//
//  CardManageBillingDetailsTimeTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardManageBillingDetailsTimeTableViewCell : UITableViewCell

/**
 出账日期
 */
@property(nonatomic, strong)NSString *outAccountDayString;

/**
 还款日期
 */
@property(nonatomic, strong)NSString *payMentDayString;

@end

NS_ASSUME_NONNULL_END
