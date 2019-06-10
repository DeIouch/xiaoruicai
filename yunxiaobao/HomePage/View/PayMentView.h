//
//  PayMentView.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/20.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PayMentBlock) (void);

@interface PayMentView : UIView

/**
 付款金额
 */
@property(nonatomic, strong)NSString *moneyString;

/**
 付款方式
 */
@property(nonatomic, assign)BOOL choosePaymentTypeBOOL;

/**
 背景view
 */
@property(nonatomic, strong)UIView *backView;


@property(nonatomic, copy)PayMentBlock payMentBlock;

@end
