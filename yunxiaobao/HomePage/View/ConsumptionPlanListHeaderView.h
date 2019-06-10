//
//  ConsumptionPlanListHeaderView.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ShrinkageBlock) (void);

@interface ConsumptionPlanListHeaderView : UIView

/**
 月份
 */
@property(nonatomic, strong)NSString *mouthDayString;

/**
 详细日期
 */
@property(nonatomic, strong)NSString *dateString;

/**
 总金额
 */
@property(nonatomic, strong)NSString *totalNumberString;

/**
 收缩按钮
 */
@property(nonatomic, assign)BOOL shrinkageBOOL;

/**
 出账日期
 */
@property(nonatomic, strong)NSString *accountDateString;

/**
 还款日期
 */
@property(nonatomic, strong)NSString *collectionDateString;

@property(nonatomic, copy)ShrinkageBlock shrinkageBlock;

@end

NS_ASSUME_NONNULL_END
