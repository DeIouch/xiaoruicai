//
//  CreditCardLoginViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CreditCardLoginViewController.h"

@interface CreditCardLoginViewController ()

@property(nonatomic, strong)UITextField *cardNumberTextField;

@property(nonatomic, strong)UITextField *cardPassWordTextField;

@property(nonatomic, strong)UIButton *cleanCardnumberButton;

@property(nonatomic, strong)UIButton *seeCardPassWordButton;

@property(nonatomic, strong)UIButton *agreeDealButton;

@property(nonatomic, strong)UIButton *rememberPassWordButton;

@property(nonatomic, strong)UIButton *loginBankButton;

@property(nonatomic, assign)BOOL agreeDealBOOL;

@property(nonatomic, assign)BOOL rememberPassWordBOOL;

@end

@implementation CreditCardLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cardNumberTextField.placeholder = @"银行卡卡号";
    self.cardPassWordTextField.placeholder = @"查询密码";
    
    [self.cleanCardnumberButton addTarget:self action:@selector(cleanCardNumber) forControlEvents:UIControlEventTouchUpInside];
    [self.seeCardPassWordButton addTarget:self action:@selector(seeCardPassWord) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBankButton addTarget:self action:@selector(loginBank) forControlEvents:UIControlEventTouchUpInside];
    [self.agreeDealButton addTarget:self action:@selector(agreeDeal) forControlEvents:UIControlEventTouchUpInside];
    [self.rememberPassWordButton addTarget:self action:@selector(rememberPassWord) forControlEvents:UIControlEventTouchUpInside];
    self.agreeDealBOOL = YES;
    self.rememberPassWordBOOL = YES;
}

-(void)cleanCardNumber{
    
}

-(void)seeCardPassWord{
    
}

-(void)loginBank{
    
}

-(void)agreeDeal{
    if (self.agreeDealBOOL) {
        self.agreeDealBOOL = NO;
        [self.agreeDealButton setImage:[UIImage imageNamed:icon_disagree] forState:UIControlStateNormal];
    }else{
        self.agreeDealBOOL = YES;
        [self.agreeDealButton setImage:[UIImage imageNamed:icon_assent] forState:UIControlStateNormal];
    }
}

-(void)rememberPassWord{
    if (self.rememberPassWordBOOL) {
        self.rememberPassWordBOOL = NO;
        [self.rememberPassWordButton setImage:[UIImage imageNamed:icon_disagree] forState:UIControlStateNormal];
    }else{
        self.rememberPassWordBOOL = YES;
        [self.rememberPassWordButton setImage:[UIImage imageNamed:icon_assent] forState:UIControlStateNormal];
    }
}


-(UITextField *)cardNumberTextField{
    if (!_cardNumberTextField) {
        _cardNumberTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameCellView, 15, 24, 250, 16)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"必须填写信用卡正面的完整卡号", 1, 153, 153, 153, 1, 255, 255, 255, 2, 10, YES, self.view) setFrame:DelouchFrameMake(FrameCellView, 15, 53, 300, 10)];
    }
    return _cardNumberTextField;
}

-(UITextField *)cardPassWordTextField{
    if (!_cardPassWordTextField) {
        _cardPassWordTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameCellView, 15, 95, 250, 16)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"6-9位数字", 1, 255, 68, 32, 1, 255, 255, 255, 2, 10, YES, self.view) setFrame:DelouchFrameMake(FrameCellView, 15, 125, 300, 10)];
    }
    return _cardPassWordTextField;
}

-(UIButton *)cleanCardnumberButton{
    if (!_cleanCardnumberButton) {
        _cleanCardnumberButton = [[DelouchImageButton alloc]initButton:DelouchImageButtonInfomake(icon_delete_Shutdown, self.view) setFrame:DelouchFrameMake(FrameCellView, 329, 13, 33, 33)];
        _cleanCardnumberButton.contentMode = UIViewContentModeCenter;
    }
    return _cleanCardnumberButton;
}

-(UIButton *)seeCardPassWordButton{
    if (!_seeCardPassWordButton) {
        _seeCardPassWordButton = [[DelouchImageButton alloc]initButton:DelouchImageButtonInfomake(icon_password_, self.view) setFrame:DelouchFrameMake(FrameCellView, 327, 87, 37, 31)];
    }
    return _seeCardPassWordButton;
}

-(UIButton *)agreeDealButton{
    if (!_agreeDealButton) {
        _agreeDealButton = [[DelouchImageButton alloc]initButton:DelouchImageButtonInfomake(icon_assent, self.view) setFrame:DelouchFrameMake(FrameCellView, 8, 150, 36, 36)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"同意用户授权协议", 1, 153, 153, 153, 1, 255, 255, 255, 1, 14, YES, self.view) setFrame:DelouchFrameMake(FrameCellView, 40, 162, 150, 14)];
    }
    return _agreeDealButton;
}

-(UIButton *)rememberPassWordButton{
    if (!_rememberPassWordButton) {
        _rememberPassWordButton = [[DelouchImageButton alloc]initButton:DelouchImageButtonInfomake(icon_assent, self.view) setFrame:DelouchFrameMake(FrameCellView, 271, 150, 36, 36)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"记住密码", 1, 153, 153, 153, 1, 255, 255, 255, 1, 14, YES, self.view) setFrame:DelouchFrameMake(FrameCellView, 303, 162, 70, 14)];
    }
    return _rememberPassWordButton;
}

-(UIButton *)loginBankButton{
    if (!_loginBankButton) {
        _loginBankButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"开始登录", 2, 255, 254, 254, 1, 149, 165, 253, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameCellView, 15, 201, 345, 44)];
        [self setbuttonLayer:_loginBankButton layerMask:3];
    }
    return _loginBankButton;
}

@end
