//
//  GoRealNameViewController.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

@interface GoRealNameViewController : DelouchViewController

/**
 认证头像
 */
@property(nonatomic, copy)NSString *iconString;

/**
 认证姓名
 */
@property(nonatomic, copy)NSString *nameString;

/**
 身份证信息
 */
@property(nonatomic, copy)NSString *idCardCertificationInfoString;

/**
 支付宝信息
 */
@property(nonatomic, copy)NSString *aliPayCertificationInfoString;

/**
 身份证认证状态
 */
@property(nonatomic, assign)BOOL idCardCertificationStateBOOL;

/**
 支付宝认证状态
 */
@property(nonatomic, assign)BOOL aliPayCertificationStateBOOL;

@end
