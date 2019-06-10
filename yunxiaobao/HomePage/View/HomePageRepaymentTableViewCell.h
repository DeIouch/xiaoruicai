//
//  HomePageRepaymentTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/11.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageRepaymentTableViewCell : UITableViewCell

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
 剩余额度
 */
@property(nonatomic, strong)NSString *remainingString;

/**
 本期应还
 */
@property(nonatomic, strong)NSString *shouldAsloString;

/**
 到期日期
 */
@property(nonatomic, strong)NSString *endTimeString;

/**
 剩余天数
 */
@property(nonatomic, strong)NSString *endDayString;

/**
 到期说明
 */
@property(nonatomic, strong)NSString *endInstrucString;

/**
 还款状态
 */
@property(nonatomic, strong)NSString *asloStateString;

/**
 规划状态
 */
@property(nonatomic, strong)NSString *planStateString;

@end

NS_ASSUME_NONNULL_END
