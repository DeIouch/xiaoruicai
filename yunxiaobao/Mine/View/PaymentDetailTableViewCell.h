//
//  PaymentDetailTableViewCell.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/26.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentDetailTableViewCell : UITableViewCell

/**
 图标
 */
@property(nonatomic, strong)NSString *iconString;

/**
 收支名称
 */
@property(nonatomic, strong)NSString *paymentNameString;

/**
 收支时间
 */
@property(nonatomic, strong)NSString *paymentTimeString;

/**
 收支类型   0收入 1支出
 */
@property(nonatomic, strong)NSString *paymentTypeString;

/**
 金额
 */
@property(nonatomic, strong)NSString *moneyNumberString;

@end
