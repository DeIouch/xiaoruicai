//
//  CardListTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardListTableViewCell : UITableViewCell

/**
 背景图片
 */
@property(nonatomic, strong)NSString *backString;

/**
 银行icon
 */
@property(nonatomic, strong)NSString *bankIconString;

/**
 银行名称
 */
@property(nonatomic, strong)NSString *bankNameString;

/**
 银行卡尾号
 */
@property(nonatomic, strong)NSString *bankNumberString;

/**
 本期应还
 */
@property(nonatomic, strong)NSString *shouldAlsoString;

/**
 总金额(元)
 */
@property(nonatomic, strong)NSString *totalAmountString;

/**
 账单日
 */
@property(nonatomic, strong)NSString *billDayString;

/**
 还款日
 */
@property(nonatomic, strong)NSString *reimbursementDayString;

@end

NS_ASSUME_NONNULL_END
