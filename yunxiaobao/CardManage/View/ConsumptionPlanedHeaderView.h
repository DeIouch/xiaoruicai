//
//  ConsumptionPlanedHeaderView.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsumptionPlanedHeaderView : UIView

/**
 消费日期
 */
@property(nonatomic, strong)NSString *dateString;

/**
 消费金额
 */
@property(nonatomic, strong)NSString *consumptionString;

/**
 消费类型
 */
@property(nonatomic, strong)NSString *consumptionTypeString;

@end
