//
//  SetNewPwdViewController.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

@interface SetNewPwdViewController : DelouchViewController

/**
 手机号码
 */
@property(nonatomic, strong)NSString *phoneString;

/**
 验证码
 */
@property(nonatomic, strong)NSString *codeString;

@end
