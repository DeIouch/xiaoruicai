//
//  IdCardCertificationResultViewController.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

@interface IdCardCertificationResultViewController : DelouchViewController

/**
 认证状态
 */
@property(nonatomic, strong)NSString *certificationResultString;

/**
 用户姓名
 */
@property(nonatomic, strong)NSString *userNameString;

/**
 身份证号
 */
@property(nonatomic, strong)NSString *idCardString;

@end
