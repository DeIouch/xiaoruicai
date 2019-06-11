//
//  LoginViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate, UIGestureRecognizerDelegate>


@property (nonatomic, assign)BOOL isCanUseSideBack;

/**
 查看密码
 */
@property(nonatomic, strong)UIImageView *seePwdButton;


/**
 是否查看密码
 */
@property(nonatomic, assign)BOOL seePwdBOOL;

/**
 忘记密码
 */
@property(nonatomic, strong)UIButton *forgetPwdButton;

/**
 使用短信登陆
 */
@property(nonatomic, strong)UIButton *messageLoginButton;

/**
 登陆
 */
@property(nonatomic, strong)UIButton *loginButton;

@end

@implementation LoginViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self cancelSideBack];
}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    [self startSideBack];
//}

/**
 * 关闭ios右滑返回
 */
-(void)cancelSideBack{
    self.isCanUseSideBack = NO;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate=self;
    }
}

///*
// 开启ios右滑返回
// */
//- (void)startSideBack {
//    self.isCanUseSideBack=YES;
//    
//    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
//}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanUseSideBack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"";
}

-(void)createUI{
    self.headview.leftButton.hidden = YES;
    self.headview.lineView.hidden = YES;
    self.infoDic = DelouchRightButtonInfomake(@"注册", 51, 51, 51, 1, 255, 255, 255, 2, 15);
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"欢迎来到小睿财", 1, 0, 0, 0, 1, 255, 255, 255, 2, 30, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 21, 89, 350, 29)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"账号/手机号", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 21, 173, 300, 14)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"密码", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 21, 258, 300, 14)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 230, 335, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 315, 335, 1)];
    
    self.phoneTextField.placeholder = @"";
    self.pwdTextField.placeholder = @"";
    [self.seePwdButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seePwd)]];
    
//    [self.messageLoginButton addTarget:self action:@selector(messageLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.forgetPwdButton addTarget:self action:@selector(forgetPwd) forControlEvents:UIControlEventTouchUpInside];
    
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    self.seePwdBOOL = NO;
}

-(void)seePwd{
    self.seePwdBOOL = !self.seePwdBOOL;
}

-(void)rightSelect{
    [self pushViewControl:@"InviteCodeViewController" propertyDic:nil];
}

-(void)messageLogin{
    [self pushViewControl:@"MessageLoginViewController" propertyDic:nil];
}

-(void)forgetPwd{
    [self pushViewControl:@"ForgetPwdViewController" propertyDic:nil];
}

-(void)login{
    if (self.phoneTextField.text.length == 0) {
        self.notiString = @"手机号码为空";
    }else if (self.pwdTextField.text.length == 0) {
        self.notiString = @"密码为空";
    }else{
        [self urlHeadStr:MyinfoIPURL urlStr:UrlFrontLogin parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text, @"phone", [self md5:self.pwdTextField.text], @"user_pwd", nil] Success:^(NSDictionary *obj) {
            [self preservationPhone:self.phoneTextField.text pwd:self.pwdTextField.text];
            [self preservationUserinfo:obj[@"result"]];
            [self pushViewControl:@"MainViewController" propertyDic:nil];
            self.phoneTextField.text = @"";
            self.pwdTextField.text = @"";
        }];
    }
    
//    [self pushViewControl:@"MainViewController" propertyDic:nil];
}

-(UIImageView *)seePwdButton{
    if (!_seePwdButton) {
        _seePwdButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_password_, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 322, 280, 37, 31)];
        _seePwdButton.contentMode = UIViewContentModeCenter;
    }
    return _seePwdButton;
}

-(UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 194, 335, 33)];
    }
    return _phoneTextField;
}

-(UITextField *)pwdTextField{
    if (!_pwdTextField) {
        _pwdTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, YES, 51, 51, 51, 1, 0, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 279, 305, 33)];
        _pwdTextField.clearButtonMode = UITextFieldViewModeAlways;
        _pwdTextField.delegate = self;
    }
    return _pwdTextField;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

-(void)setSeePwdBOOL:(BOOL)seePwdBOOL{
    _seePwdBOOL = seePwdBOOL;
    self.pwdTextField.secureTextEntry = !seePwdBOOL;
    if (seePwdBOOL) {
        self.seePwdButton.image = [UIImage imageNamed:icon_password_unwrap];
    }else{
        self.seePwdButton.image = [UIImage imageNamed:icon_password_];
    }
}

-(UIButton *)forgetPwdButton{
    if (!_forgetPwdButton) {
        _forgetPwdButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"忘记密码？", 3, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 283, 335, 73, 34)];
    }
    return _forgetPwdButton;
}

-(UIButton *)messageLoginButton{
    if (!_messageLoginButton) {
        _messageLoginButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"使用短信登录", 2, 86, 112, 254, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 335, 120, 33)];
        _messageLoginButton.layer.cornerRadius = 17 * (DelouchWidth / 375.0);
        _messageLoginButton.layer.borderColor = [UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1].CGColor;
        _messageLoginButton.layer.borderWidth = DelouchWidth / 375.0;
    }
    return _messageLoginButton;
}

-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"登录", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 452, 345, 48)];
        [self setbuttonLayer:_loginButton layerMask:3];
    }
    return _loginButton;
}

@end
