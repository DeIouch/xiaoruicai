//
//  ChangeNickNameViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/18.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "ChangeNickNameViewController.h"

@interface ChangeNickNameViewController ()<UITextFieldDelegate>

/**
 保存
 */
@property(nonatomic, strong)UIButton *saveButton;

/**
 用户昵称
 */
@property(nonatomic, strong)UITextField *nickNameTextField;

@end

@implementation ChangeNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"修改昵称";
}

-(void)createUI{
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 84, 375, 55)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"昵称", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 104, 50, 15)];
    
    [self.saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    self.nickNameTextField.placeholder = @"2-10个字符";
}

-(void)save{
    if (self.nickNameTextField.text.length == 0) {
        self.notiString = @"请输入昵称";
    }else{
        [self urlHeadStr:AppInfoURL urlStr:UrlUpdateName parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.nickNameTextField.text, @"user_name", self.userInfoModel.user_id, @"id", nil] Success:^(NSDictionary *obj) {
            self.notiString = @"修改成功";
            [self popVC];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNickName" object:self.nickNameTextField.text];
        }];
    }
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

-(UITextField *)nickNameTextField{
    if (!_nickNameTextField) {
        _nickNameTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 77, 94, 283, 35)];
        _nickNameTextField.delegate = self;
        _nickNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _nickNameTextField;
}

-(UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"保存", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 249, 345, 44)];
        [self setbuttonLayer:_saveButton layerMask:3];
    }
    return _saveButton;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL isAllowEdit = YES;
    if([string length] > range.length && [textField.text length] + [string length] - range.length > 10)
    {
        isAllowEdit = NO;
    }
    return isAllowEdit;
}

@end
