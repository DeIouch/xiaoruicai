//
//  SetNewPwdViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "SetNewPwdViewController.h"
#import "LoginViewController.h"

@interface SetNewPwdViewController ()

/**
 新密码
 */
@property(nonatomic, strong)UITextField *nowPwdTextField;

/**
 确认密码
 */
@property(nonatomic, strong)UITextField *makeSurePwdTextField;

/**
 完成按钮
 */
@property(nonatomic, strong)UIButton *makeSureButton;

@end

@implementation SetNewPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"";
}

-(void)createUI{
    self.headview.lineView.hidden = YES;
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"设置新密码", 1, 0, 0, 0, 1, 255, 255, 255, 2, 30, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 88, 300, 30)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"密码必须为8~16位数字字母组合", 1, 0, 0, 0, 1, 255, 255, 255, 2, 20, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 135, 335, 19)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"密码", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 204, 300, 14)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"确认密码", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 289, 300, 14)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 260, 335, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 346, 335, 1)];
    
    self.nowPwdTextField.placeholder = @"请输入新密码";
    
    self.makeSurePwdTextField.placeholder = @"请再次输入新密码";
    
    [self.makeSureButton addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
}

-(void)makeSure{
    if (self.nowPwdTextField.text.length < 6 || self.nowPwdTextField.text.length > 16 || ![self.nowPwdTextField.text isEqualToString:self.makeSurePwdTextField.text]) {
        self.notiString = @"请填写正确的资料";
    }else{
        [self urlHeadStr:AppInfoURL urlStr:UrlPhoneUpdatePwd parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.phoneString, @"phone", self.codeString, @"code", [self md5:self.nowPwdTextField.text], @"user_pwd", [self md5:self.makeSurePwdTextField.text], @"user_surePwd", nil] Success:^(NSDictionary *obj) {
            self.notiString = @"修改成功";
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

-(UITextField *)nowPwdTextField{
    if (!_nowPwdTextField) {
        _nowPwdTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, YES, 51, 51, 51, 1, 0, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 222, 335, 37)];
    }
    return _nowPwdTextField;
}

-(UITextField *)makeSurePwdTextField{
    if (!_makeSurePwdTextField) {
        _makeSurePwdTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, YES, 51, 51, 51, 1, 0, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 308, 335, 37)];
    }
    return _makeSurePwdTextField;
}

-(UIButton *)makeSureButton{
    if (!_makeSureButton) {
        _makeSureButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"完成", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 371, 335, 50)];
        [self setbuttonLayer:_makeSureButton layerMask:3];
    }
    return _makeSureButton;
}

@end
