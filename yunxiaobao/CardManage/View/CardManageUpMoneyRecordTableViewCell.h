//
//  CardManageUpMoneyRecordTableViewCell.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardManageUpMoneyRecordTableViewCell : UITableViewCell

/**
 银行icon
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
 固定额度
 */
@property(nonatomic, strong)NSString *fixedQuotaString;

/**
 临时额度
 */
@property(nonatomic, strong)NSString *temporaryLinesString;

/**
 卡贷额度
 */
@property(nonatomic, strong)NSString *cardCreditLimitString;

@end
