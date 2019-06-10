//
//  ALiPayCertificationResultViewController.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

@interface ALiPayCertificationResultViewController : DelouchViewController

/**
 支付宝姓名
 */
@property(nonatomic, strong)NSString *alipayNameString;

/**
 支付宝账号
 */
@property(nonatomic, strong)NSString *alipayAccountString;

@end
