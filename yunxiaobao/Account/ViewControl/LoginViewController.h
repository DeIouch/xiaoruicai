//
//  LoginViewController.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

@interface LoginViewController : DelouchViewController

/**
 手机号码
 */
@property(nonatomic, strong)UITextField *phoneTextField;

/**
 密码
 */
@property(nonatomic, strong)UITextField *pwdTextField;

@end
