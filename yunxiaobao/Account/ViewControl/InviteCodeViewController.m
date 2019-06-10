//
//  InviteCodeViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "InviteCodeViewController.h"
#import "LQ_PasswordView.h"

@interface InviteCodeViewController ()

/**
 下一步
 */
@property(nonatomic, strong)UIButton *nextStepButton;

/**
 推荐码
 */
@property(nonatomic, strong)NSString *inviteCodeString;

/**
 推荐码输入框
 */
@property(nonatomic, strong)UITextField *inviteCodeTextField;

@end

@implementation InviteCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"";
}

-(void)createUI{
    self.headview.lineView.hidden = YES;
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"输入推荐码", 1, 0, 0, 0, 1, 255, 255, 255, 2, 30, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 22, 88, 200, 30)];
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"请将11位推荐码填入框内", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 173, 335, 14)];
    
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 266, 335, 1)];
    
    [self.nextStepButton addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    
    self.inviteCodeTextField.text = @"";
//    LQ_PasswordView *view = [[LQ_PasswordView alloc]initWithFrame:CGRectMake(20 * self.baseicFloat, 160 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 335 * self.baseicFloat, 40 * self.baseicFloat)];
//    view.num = 6;
//    view.callBackBlock = ^(NSString *text) {
//        self.inviteCodeString = text;
//    };
//    [view showPassword];
//    [self.view addSubview:view];
}

-(void)nextStep{
    if (self.inviteCodeTextField.text.length == 11) {
        [self urlHeadStr:MyinfoIPURL urlStr:UrlCheckPhone parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.inviteCodeTextField.text, @"phone", nil] Success:^(NSDictionary *obj) {
            [self pushViewControl:@"RegisterViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.inviteCodeTextField.text, @"inviteCodeString", nil]];
        }];
    }else{
        self.notiString = @"请先输入正确的推荐码";
    }
}

-(UIButton *)nextStepButton{
    if (!_nextStepButton) {
        _nextStepButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"下一步", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 327, 335, 50)];
        [self setbuttonLayer:_nextStepButton layerMask:3];
    }
    return _nextStepButton;
}

-(UITextField *)inviteCodeTextField{
    if (!_inviteCodeTextField) {
        _inviteCodeTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 24, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 226, 335, 38)];
    }
    return _inviteCodeTextField;
}

@end
