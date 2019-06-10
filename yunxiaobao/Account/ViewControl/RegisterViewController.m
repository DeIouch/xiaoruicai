//
//  RegisterViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"

@interface RegisterViewController ()<UITextViewDelegate>

/**
 登陆
 */
@property(nonatomic, strong)UIButton *loginButton;

/**
 手机号
 */
@property(nonatomic, strong)UITextField *phoneTextField;

/**
 验证码
 */
@property(nonatomic, strong)UITextField *codeTextField;

/**
 密码
 */
@property(nonatomic, strong)UITextField *pwdTextField;

/**
 发送验证码
 */
@property(nonatomic, strong)UIButton *sendCodeButton;

/**
 同意协议
 */
@property(nonatomic, strong)UIImageView *agreementButton;

/**
 是否同意协议
 */
@property(nonatomic, assign)BOOL agreeBOOL;

/**
 注册结果
 */
@property(nonatomic, strong)NSDictionary *registDic;

/**
 登陆结果
 */
@property(nonatomic, strong)NSDictionary *loginDic;

@end

@implementation RegisterViewController{
    dispatch_source_t registerCodeTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"";
}

-(void)createUI{
    self.headview.lineView.hidden = YES;
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"请完善注册信息", 1, 0, 0, 0, 1, 255, 255, 255, 2, 30, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 22, 88, 331, 30)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 230, 335, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 315, 335, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 401, 335, 1)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"手机号", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 173, 300, 14)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"验证码", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 259, 300, 14)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"密码", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 344, 300, 14)];
    
    [self.loginButton addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sendCodeButton addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    
    self.codeTextField.placeholder = @"输入验证码";
    
    self.phoneTextField.placeholder = @"11位数字电话号码";
    
    self.pwdTextField.placeholder = @"请输入8~16位字母数字组合";
    
    UITextView *serviceTextView = [[UITextView alloc]initWithFrame:CGRectMake(35 * self.baseicFloat, 354 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 300 * self.baseicFloat, 24 * self.baseicFloat)];
    serviceTextView.editable = NO;
    serviceTextView.selectable = YES;
    serviceTextView.delegate = self;
    [self.view addSubview:serviceTextView];
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:@"同意并已阅读《小睿财服务协议》"];
    [abs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 * self.baseicFloat] range:NSMakeRange(0, abs.length)];
    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    [abs addAttribute:NSLinkAttributeName value:url range:NSMakeRange(abs.length - 9, 9)];
    serviceTextView.attributedText = abs;
    [self.agreementButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(agreement)]];
    self.agreeBOOL = NO;
}

-(void)agreement{
    self.agreeBOOL = !self.agreeBOOL;
}

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    [self pushViewControl:@"ViewController" propertyDic:nil];
    return YES;
}

static int registCodeSec = 60;
-(void)sendCode{
    if (self.phoneTextField.text.length == 11) {
        [self urlHeadStr:MyinfoIPURL urlStr:UrlAppPhoneCodeRegister parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text, @"phone", nil] Success:^(NSDictionary *obj) {
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

-(void)regist{
    if (self.phoneTextField.text.length != 11) {
        self.notiString = @"请先输入正确的手机号";
    }else if (self.codeTextField.text.length != 6) {
        self.notiString = @"请先输入正确的验证码";
    }else if (self.pwdTextField.text.length < 8 || self.pwdTextField.text.length > 16) {
        self.notiString = @"密码为8~16位字母数字组合";
    }else if (!self.agreeBOOL) {
        self.notiString = @"请先同意注册协议";
    }else{
//        __weak typeof(self) weakSelf = self;
        [self urlHeadStr:MyinfoIPURL urlStr:UrlRegster parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text, @"phone", self.codeTextField.text, @"code", self.inviteCodeString, @"parent_phone", [self md5:self.pwdTextField.text], @"user_pwd", nil] Success:^(NSDictionary *obj) {
//            [weakSelf login];
            
            self.notiString = @"注册成功";
            LoginViewController *mainVC = nil;
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[LoginViewController class]]) {
                    mainVC = (LoginViewController *)vc;
                }
            }
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                sleep(1);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popToViewController:mainVC animated:YES];
                });
            });
            
        }];
    }
}

-(void)login{
    [self preservationPhone:self.phoneTextField.text pwd:self.pwdTextField.text];
    [self urlHeadStr:MyinfoIPURL urlStr:UrlFrontLogin parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text, @"phone", [self md5:self.pwdTextField.text], @"user_pwd", nil] Success:^(NSDictionary *obj) {
        [self preservationUserinfo:obj[@"result"]];
        [self pushViewControl:@"MainViewController" propertyDic:nil];
    }];
}

-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"登录", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 470, 345, 48)];
        [self setbuttonLayer:_loginButton layerMask:3];
    }
    return _loginButton;
}

-(UIButton *)sendCodeButton{
    if (!_sendCodeButton) {
        _sendCodeButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"发送验证码", 3, 86, 112, 254, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 277, 276, 79, 34)];
    }
    return _sendCodeButton;
}

-(UITextField *)codeTextField{
    if (!_codeTextField) {
        _codeTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 279, 205, 33)];
        _codeTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _codeTextField;
}

-(UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 194, 335, 33)];
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneTextField;
}

-(UITextField *)pwdTextField{
    if (!_pwdTextField) {
        _pwdTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, YES, 51, 51, 51, 1, 0, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 365, 335, 33)];
        _pwdTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    return _pwdTextField;
}

-(UIImageView *)agreementButton{
    if (!_agreementButton) {
        _agreementButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_agreement_assent, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 416, 24, 34)];
        _agreementButton.contentMode = UIViewContentModeLeft;
    }
    return _agreementButton;
}

-(void)setAgreeBOOL:(BOOL)agreeBOOL{
    _agreeBOOL = agreeBOOL;
    if (!agreeBOOL) {
        self.agreementButton.image = [UIImage imageNamed:icon_agreement_nonconsent];
    }else{
        self.agreementButton.image = [UIImage imageNamed:icon_agreement_assent];
    }
}

@end
