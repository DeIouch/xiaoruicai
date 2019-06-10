//
//  ForgetPwdViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "ForgetPwdViewController.h"

@interface ForgetPwdViewController ()

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
 下一步
 */
@property(nonatomic, strong)UIButton *nextStepButton;

@end

@implementation ForgetPwdViewController{
    dispatch_source_t registerCodeTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"";
}

-(void)createUI{
    self.headview.lineView.hidden = YES;
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"忘记密码", 1, 0, 0, 0, 1, 255, 255, 255, 2, 30, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 22, 88, 200, 30)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"使用手机号登陆", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 21, 173, 300, 14)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"验证码", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 21, 258, 300, 14)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 230, 335, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 315, 335, 1)];
    
    self.phoneTextField.placeholder = @"";
    self.codeTextField.placeholder = @"";
    
    [self.nextStepButton addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sendCodeButton addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
}

static int registCodeSec = 60;
-(void)sendCode{
    if (self.phoneTextField.text.length == 11) {
        [self urlHeadStr:AppInfoURL urlStr:UrlPhoneCodePwd parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text, @"phone", nil] Success:^(NSDictionary *obj) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            self->registerCodeTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC);
            uint64_t interval = 1 * NSEC_PER_SEC;
            dispatch_source_set_timer(self->registerCodeTimer, start, interval, 0);
            dispatch_resume(self->registerCodeTimer);
            dispatch_source_set_event_handler(self->registerCodeTimer, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.sendCodeButton setTitle:[NSString stringWithFormat:@"%d S  ",registCodeSec] forState:UIControlStateNormal];
                    registCodeSec--;
                    self.sendCodeButton.userInteractionEnabled = NO;
                    [self.sendCodeButton setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
                    if (registCodeSec == 0) {
                        dispatch_source_cancel(self->registerCodeTimer);
                        registCodeSec = 60;
                        self.sendCodeButton.userInteractionEnabled = YES;
                        [self.sendCodeButton setTitleColor:[UIColor colorWithRed:86/255.0 green:112/255.0 blue:254/255.0 alpha:1] forState:UIControlStateNormal];
                        [self.sendCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                    }
                });
            });
        }];
    }else{
        self.notiString = @"请先输入正确的手机号";
    }
}

-(void)nextStep{
    if (self.phoneTextField.text.length != 11 || self.codeTextField.text.length != 6) {
        self.notiString = @"请填写正确的资料";
    }else{
        [self pushViewControl:@"SetNewPwdViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text, @"phoneString", self.codeTextField.text, @"codeString", nil]];
    }
}

-(UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 194, 335, 33)];
    }
    return _phoneTextField;
}

-(UITextField *)codeTextField{
    if (!_codeTextField) {
        _codeTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 279, 205, 33)];
    }
    return _codeTextField;
}

-(UIButton *)sendCodeButton{
    if (!_sendCodeButton) {
        _sendCodeButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"发送验证码", 3, 86, 112, 254, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 277, 275, 79, 34)];
    }
    return _sendCodeButton;
}

-(UIButton *)nextStepButton{
    if (!_nextStepButton) {
        _nextStepButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"下一步", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 340, 335, 50)];
        [self setbuttonLayer:_nextStepButton layerMask:3];
    }
    return _nextStepButton;
}

@end
