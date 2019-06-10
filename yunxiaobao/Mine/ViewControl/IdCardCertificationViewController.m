//
//  IdCardCertificationViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "IdCardCertificationViewController.h"
#import "GoRealNameViewController.h"

@interface IdCardCertificationViewController ()

/**
 请输入本人姓名
 */
@property(nonatomic, strong)UITextField *userNameTextField;

/**
 请输入本人的身份证号码
 */
@property(nonatomic, strong)UITextField *idCardNumberTextField;

/**
 请输入本人的手机号
 */
@property(nonatomic, strong)UITextField *phoneTextField;

/**
 请输入正确的验证码
 */
@property(nonatomic, strong)UITextField *codeTextField;

/**
 获取验证码
 */
@property(nonatomic, strong)UIButton *getCodeButton;

/**
 提交审核
 */
@property(nonatomic, strong)UIButton *updateInfoButton;

@end

@implementation IdCardCertificationViewController{
    dispatch_source_t registerCodeTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"身份证验证";
}

-(void)createUI{
    self.headview.lineView.hidden = YES;
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"请填写实名认证信息", 1, 51, 51, 51, 1, 255, 255, 255, 2, 24, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 105, 345, 23)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"以保证您的资金账户安全", 1, 153, 153, 153, 1, 255, 255, 255, 2, 13, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 137, 345, 13)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 231, 345, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 293, 345, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 355, 345, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 417, 345, 1)];
    
    self.userNameTextField.placeholder = @"请输入本人姓名";
    self.idCardNumberTextField.placeholder = @"请输入本人的身份证号码";
    self.phoneTextField.placeholder = @"请输入本人的手机号";
    self.codeTextField.placeholder = @"请输入正确的验证码";
    
    [self.getCodeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [self.updateInfoButton addTarget:self action:@selector(updateInfo) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftSelect{
    GoRealNameViewController *mainVC = nil;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[GoRealNameViewController class]]) {
            mainVC = (GoRealNameViewController *)vc;
        }
    }
    if (mainVC == nil) {
        mainVC = [[GoRealNameViewController alloc]init];
    }
    [self.navigationController popToViewController:mainVC animated:YES];
}

static int registCodeSec = 60;
-(void)getCode{
    if (self.phoneTextField.text.length != 11) {
        self.notiString = @"请输入正确的手机号码";
    }else{
        [self urlHeadStr:AppInfoURL urlStr:UrlPhoneCode parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text, @"phone", nil] Success:^(NSDictionary *obj) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            self->registerCodeTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC);
            uint64_t interval = 1 * NSEC_PER_SEC;
            dispatch_source_set_timer(self->registerCodeTimer, start, interval, 0);
            dispatch_resume(self->registerCodeTimer);
            dispatch_source_set_event_handler(self->registerCodeTimer, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.getCodeButton setTitle:[NSString stringWithFormat:@"%d S  ",registCodeSec] forState:UIControlStateNormal];
                    registCodeSec--;
                    self.getCodeButton.userInteractionEnabled = NO;
                    [self.getCodeButton setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
                    if (registCodeSec == 0) {
                        dispatch_source_cancel(self->registerCodeTimer);
                        registCodeSec = 60;
                        self.getCodeButton.userInteractionEnabled = YES;
                        [self.getCodeButton setTitleColor:[UIColor colorWithRed:86/255.0 green:112/255.0 blue:254/255.0 alpha:1] forState:UIControlStateNormal];
                        [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                    }
                });
            });
        }];
    }
}

-(void)updateInfo{
    if (self.phoneTextField.text.length != 11 || self.userNameTextField.text.length == 0 || self.idCardNumberTextField.text.length != 18 || self.codeTextField.text.length != 6) {
        self.notiString = @"请输入正确的资料";
    }else{
        __weak typeof(self) weakSelf = self;
        [self urlHeadStr:AppInfoURL urlStr:UrlIdnoVerify parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"id", self.userNameTextField.text, @"user_real_name", self.idCardNumberTextField.text, @"user_idno", self.phoneTextField.text, @"phone", self.codeTextField.text, @"code", nil] Success:^(NSDictionary *obj) {
            [weakSelf freshUserInfo];
        }];
    }
}

-(void)freshUserInfo{
    [self urlHeadStr:AppInfoURL urlStr:UrlMyList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"id", nil] Success:^(NSDictionary *obj) {
        [self preservationUserinfo:obj[@"result"][@"list"]];
        [self pushViewControl:@"IdCardCertificationResultViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.userNameTextField.text, @"userNameString", self.idCardNumberTextField.text, @"idCardString", nil]];
    }];
}

-(UITextField *)userNameTextField{
    if (!_userNameTextField) {
        _userNameTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 183, 340, 35)];
    }
    return _userNameTextField;
}

-(UITextField *)idCardNumberTextField{
    if (!_idCardNumberTextField) {
        _idCardNumberTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 245, 340, 35)];
    }
    return _idCardNumberTextField;
}

-(UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 307, 340, 35)];
    }
    return _phoneTextField;
}

-(UITextField *)codeTextField{
    if (!_codeTextField) {
        _codeTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 369, 200, 35)];
    }
    return _codeTextField;
}

-(UIButton *)getCodeButton{
    if (!_getCodeButton) {
        _getCodeButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"获取验证码", 2, 86, 112, 254, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 256, 368, 94, 36)];
        _getCodeButton.layer.borderColor = [UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1].CGColor;//设置边框颜色
        _getCodeButton.layer.borderWidth = self.baseicFloat;
        [self setbuttonLayer:_getCodeButton layerMask:3];
    }
    return _getCodeButton;
}

-(UIButton *)updateInfoButton{
    if (!_updateInfoButton) {
        _updateInfoButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"提交审核", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 452, 345, 48)];
        [self setbuttonLayer:_updateInfoButton layerMask:24];
    }
    return _updateInfoButton;
}

@end
