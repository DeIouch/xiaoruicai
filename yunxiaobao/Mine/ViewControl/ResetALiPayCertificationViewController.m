//
//  ResetALiPayCertificationViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "ResetALiPayCertificationViewController.h"

@interface ResetALiPayCertificationViewController ()

/**
 请输入新的支付宝账户姓名
 */
@property(nonatomic, strong)UITextField *alipayNameTextField;

/**
 请输入新的支付宝账户
 */
@property(nonatomic, strong)UITextField *alipayAccountTextField;

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
 确认修改
 */
@property(nonatomic, strong)UIButton *makeSureChangeButton;

@end

@implementation ResetALiPayCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"支付宝验证";
}

-(void)createUI{
    self.headview.lineView.hidden = YES;
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"请绑定收款账户信息", 1, 51, 51, 51, 1, 255, 255, 255, 2, 24, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 105, 345, 23)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"以保证您的资金能安全到达指定账户", 1, 153, 153, 153, 1, 255, 255, 255, 2, 13, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 137, 345, 13)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 231, 345, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 293, 345, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 355, 345, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 417, 345, 1)];
    
    self.alipayNameTextField.placeholder = @"请输入新的支付宝账户姓名";
    self.alipayAccountTextField.placeholder = @"请输入新的支付宝账户";
    self.phoneTextField.placeholder = @"请输入本人的手机号";
    self.codeTextField.placeholder = @"请输入正确的验证码";
    
    [self.getCodeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [self.makeSureChangeButton addTarget:self action:@selector(makeSureChange) forControlEvents:UIControlEventTouchUpInside];
}

-(void)getCode{
    
}

-(void)makeSureChange{
    [self pushViewControl:@"ALiPayCertificationResultViewController" propertyDic:nil];
}

-(UITextField *)alipayNameTextField{
    if (!_alipayNameTextField) {
        _alipayNameTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 183, 340, 35)];
    }
    return _alipayNameTextField;
}

-(UITextField *)alipayAccountTextField{
    if (!_alipayAccountTextField) {
        _alipayAccountTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 245, 340, 35)];
    }
    return _alipayAccountTextField;
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

-(UIButton *)makeSureChangeButton{
    if (!_makeSureChangeButton) {
        _makeSureChangeButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"确认修改", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 452, 345, 48)];
        [self setbuttonLayer:_makeSureChangeButton layerMask:24];
    }
    return _makeSureChangeButton;
}


@end
