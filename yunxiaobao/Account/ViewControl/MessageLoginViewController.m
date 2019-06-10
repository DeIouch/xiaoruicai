//
//  MessageLoginViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "MessageLoginViewController.h"

@interface MessageLoginViewController ()

/**
 发送验证码
 */
@property(nonatomic, strong)UIButton *sendCodeButton;

/**
 手机号码
 */
@property(nonatomic, strong)UITextField *phoneTextField;

/**
 验证码
 */
@property(nonatomic, strong)UITextField *codeTextField;

/**
 忘记密码
 */
@property(nonatomic, strong)UIButton *forgetPwdButton;

/**
 使用密码登陆
 */
@property(nonatomic, strong)UIButton *pwdLoginButton;

/**
 登陆
 */
@property(nonatomic, strong)UIButton *loginButton;


@end

@implementation MessageLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"";
}

-(void)createUI{
    self.headview.leftButton.hidden = YES;
    self.headview.lineView.hidden = YES;
    self.infoDic = DelouchRightButtonInfomake(@"注册", 51, 51, 51, 1, 255, 255, 255, 2, 15);
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"欢迎来到小睿财", 1, 0, 0, 0, 1, 255, 255, 255, 2, 30, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 21, 89, 350, 29)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"使用手机号登陆", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 21, 173, 300, 14)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"验证码", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 21, 258, 300, 14)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 230, 335, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 315, 335, 1)];
    
    self.phoneTextField.placeholder = @"";
    self.codeTextField.placeholder = @"";
    
    [self.pwdLoginButton addTarget:self action:@selector(pwdLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.forgetPwdButton addTarget:self action:@selector(forgetPwd) forControlEvents:UIControlEventTouchUpInside];
    
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sendCodeButton addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
}

-(void)rightSelect{
    [self pushViewControl:@"InviteCodeViewController" propertyDic:nil];
}

-(void)sendCode{
    
}

-(void)pwdLogin{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)forgetPwd{
    [self pushViewControl:@"ForgetPwdViewController" propertyDic:nil];
}

-(void)login{
    
}

-(UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 194, 335, 33)];
    }
    return _phoneTextField;
}

-(UITextField *)codeTextField{
    if (!_codeTextField) {
        _codeTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, YES, 51, 51, 51, 1, 0, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 279, 205, 33)];
    }
    return _codeTextField;
}

-(UIButton *)forgetPwdButton{
    if (!_forgetPwdButton) {
        _forgetPwdButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"忘记密码？", 3, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 283, 335, 73, 34)];
    }
    return _forgetPwdButton;
}

-(UIButton *)pwdLoginButton{
    if (!_pwdLoginButton) {
        _pwdLoginButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"使用密码登录", 2, 86, 112, 254, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 335, 120, 33)];
        _pwdLoginButton.layer.cornerRadius = 17 * (DelouchWidth / 375.0);
        _pwdLoginButton.layer.borderColor = [UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1].CGColor;
        _pwdLoginButton.layer.borderWidth = DelouchWidth / 375.0;
    }
    return _pwdLoginButton;
}

-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"登录", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 393, 335, 48)];
        [self setbuttonLayer:_loginButton layerMask:3];
    }
    return _loginButton;
}

-(UIButton *)sendCodeButton{
    if (!_sendCodeButton) {
        _sendCodeButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"发送验证码", 3, 86, 112, 254, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 277, 275, 79, 34)];
    }
    return _sendCodeButton;
}

@end
