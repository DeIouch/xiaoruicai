//
//  ChangePwdViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/18.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "ChangePwdViewController.h"

@interface ChangePwdViewController ()<UITextFieldDelegate>

/**
 原密码
 */
@property(nonatomic, strong)UITextField *oldPwdTextField;

/**
 新密码
 */
@property(nonatomic, strong)UITextField *nowPwdTextField;

/**
 确认密码
 */
@property(nonatomic, strong)UITextField *makeSurePwdTextField;

/**
 保存
 */
@property(nonatomic, strong)UIButton *saveButton;

/**
 密码是否可见
 */
@property(nonatomic, strong)UIImageView *seeOldPwdButton;

/**
 密码是否可见
 */
@property(nonatomic, strong)UIImageView *seeNowPwdButton;

/**
 密码是否可见
 */
@property(nonatomic, strong)UIImageView *seeMakeSurePwdButton;

@property(nonatomic, assign)BOOL seeOldPwdBOOL;

@property(nonatomic, assign)BOOL seeNowPwdBOOL;

@property(nonatomic, assign)BOOL seeMakeSurePwdBOOL;

@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"修改密码";
}

-(void)createUI{
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 84, 375, 55)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 159, 375, 55)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 234, 375, 55)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"原密码", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 104, 100, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"新密码", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 179, 100, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"确认新密码", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 254, 100, 15)];
    
    self.oldPwdTextField.placeholder = @"请输入原密码";
    
    self.nowPwdTextField.placeholder = @"请输入8-16位字母数字组合";
    
    self.makeSurePwdTextField.placeholder = @"请确认新密码一致";
    
    [self.saveButton addTarget:self action:@selector(savePwd) forControlEvents:UIControlEventTouchUpInside];
    
    [self.seeOldPwdButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeOldPwd)]];
    
    [self.seeNowPwdButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeNowPwd)]];
    
    [self.seeMakeSurePwdButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeMakeSurePwd)]];
    
    self.seeOldPwdBOOL = NO;
    
    self.seeNowPwdBOOL = NO;
    
    self.seeMakeSurePwdBOOL = NO;
}

-(void)seeOldPwd{
    self.seeOldPwdBOOL = !self.seeOldPwdBOOL;
}

-(void)seeNowPwd{
    self.seeNowPwdBOOL = !self.seeNowPwdBOOL;
}

-(void)seeMakeSurePwd{
    self.seeMakeSurePwdBOOL = !self.seeMakeSurePwdBOOL;
}

-(void)savePwd{
    if (self.oldPwdTextField.text.length < 8 || self.oldPwdTextField.text.length > 16) {
        self.notiString = @"旧密码错误";
    }else if (self.nowPwdTextField.text.length < 8 || self.nowPwdTextField.text.length > 16) {
        self.notiString = @"密码长度为8-16位";
    }else if (![self.nowPwdTextField.text isEqualToString:self.makeSurePwdTextField.text]) {
        self.notiString = @"两次密码不一样";
    }else{
        [self urlHeadStr:AppInfoURL urlStr:UrlUpdatePwd parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"id", self.userInfoModel.phone, @"phone", [self md5:self.oldPwdTextField.text], @"user_pwd", [self md5:self.nowPwdTextField.text], @"user_newPwd", [self md5:self.makeSurePwdTextField.text], @"user_surePwd", nil] Success:^(NSDictionary *obj) {
            [self preservationPhone:self.userInfoModel.phone pwd:self.nowPwdTextField.text];
            self.notiString = @"密码修改成功";
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

-(UITextField *)oldPwdTextField{
    if (!_oldPwdTextField) {
        _oldPwdTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, YES, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 123, 100, 200, 23)];
        _oldPwdTextField.clearButtonMode = UITextFieldViewModeAlways;
        _oldPwdTextField.delegate = self;
    }
    return _oldPwdTextField;
}

-(UITextField *)nowPwdTextField{
    if (!_nowPwdTextField) {
        _nowPwdTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, YES, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 123, 175, 200, 23)];
        _nowPwdTextField.clearButtonMode = UITextFieldViewModeAlways;
        _nowPwdTextField.delegate = self;
    }
    return _nowPwdTextField;
}

-(UITextField *)makeSurePwdTextField{
    if (!_makeSurePwdTextField) {
        _makeSurePwdTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, YES, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 123, 250, 200, 23)];
        _makeSurePwdTextField.clearButtonMode = UITextFieldViewModeAlways;
        _makeSurePwdTextField.delegate = self;
    }
    return _makeSurePwdTextField;
}

-(UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"保存", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 309, 345, 44)];
        [self setbuttonLayer:_saveButton layerMask:3];
    }
    return _saveButton;
}

-(UIImageView *)seeOldPwdButton{
    if (!_seeOldPwdButton) {
        _seeOldPwdButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_password_, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 322, 96, 37, 31)];
        _seeOldPwdButton.contentMode = UIViewContentModeCenter;
    }
    return _seeOldPwdButton;
}

-(UIImageView *)seeNowPwdButton{
    if (!_seeNowPwdButton) {
        _seeNowPwdButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_password_, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 322, 171, 37, 31)];
        _seeNowPwdButton.contentMode = UIViewContentModeCenter;
    }
    return _seeNowPwdButton;
}

-(UIImageView *)seeMakeSurePwdButton{
    if (!_seeMakeSurePwdButton) {
        _seeMakeSurePwdButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_password_, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 322, 246, 37, 31)];
        _seeMakeSurePwdButton.contentMode = UIViewContentModeCenter;
    }
    return _seeMakeSurePwdButton;
}

-(void)setSeeOldPwdBOOL:(BOOL)seeOldPwdBOOL{
    _seeOldPwdBOOL = seeOldPwdBOOL;
    self.oldPwdTextField.secureTextEntry = !seeOldPwdBOOL;
    if (seeOldPwdBOOL) {
        self.seeOldPwdButton.image = [UIImage imageNamed:icon_password_unwrap];
    }else{
        self.seeOldPwdButton.image = [UIImage imageNamed:icon_password_];
    }
}

-(void)setSeeNowPwdBOOL:(BOOL)seeNowPwdBOOL{
    _seeNowPwdBOOL = seeNowPwdBOOL;
    self.nowPwdTextField.secureTextEntry = !seeNowPwdBOOL;
    if (seeNowPwdBOOL) {
        self.seeNowPwdButton.image = [UIImage imageNamed:icon_password_unwrap];
    }else{
        self.seeNowPwdButton.image = [UIImage imageNamed:icon_password_];
    }
}

-(void)setSeeMakeSurePwdBOOL:(BOOL)seeMakeSurePwdBOOL{
    _seeMakeSurePwdBOOL = seeMakeSurePwdBOOL;
    self.makeSurePwdTextField.secureTextEntry = !seeMakeSurePwdBOOL;
    if (seeMakeSurePwdBOOL) {
        self.seeMakeSurePwdButton.image = [UIImage imageNamed:icon_password_unwrap];
    }else{
        self.seeMakeSurePwdButton.image = [UIImage imageNamed:icon_password_];
    }
}

@end
