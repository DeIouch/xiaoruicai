//
//  HomePageAddCareHolderViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageAddCareHolderViewController.h"

@interface HomePageAddCareHolderViewController ()

/**
 持卡人
 */
@property(nonatomic, strong)UITextField *nameTextField;

/**
 手机号
 */
@property(nonatomic, strong)UITextField *phoneTextField;

/**
 身份证号
 */
@property(nonatomic, strong)UITextField *idNumberTextField;

/**
 保存银行卡信息
 */
@property(nonatomic, strong)UIButton *saveCardInfoButton;

@end

@implementation HomePageAddCareHolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"新增持卡人";
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 74, 375, 192)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 136, 360, 2)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 200, 360, 2)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"持卡人", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 99, 90, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"手机号", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 163, 90, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"身份证号", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 227, 90, 15)];
    
    self.nameTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"输入持卡人姓名", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 99, 252, 15)];
    
    self.phoneTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"输入持卡人手机号码", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 163, 252, 15)];
    
    self.idNumberTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"输入持卡人身份证号码", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 227, 252, 15)];
    
    self.saveCardInfoButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"保存", 2, 255, 255, 255, 1, 86, 112, 254, 1, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 306, 345, 48)];
    [self setbuttonLayer:self.saveCardInfoButton layerMask:5];
    
    [self.saveCardInfoButton addTarget:self action:@selector(saveCardInfo) forControlEvents:UIControlEventTouchUpInside];
}

-(void)saveCardInfo{
    if (self.phoneTextField.text.length != 11 || self.nameTextField.text.length == 0 || self.idNumberTextField.text.length != 18) {
        self.notiString = @"请将资料填写完整";
    }else{
        [self urlHeadStr:AppCustomersURL urlStr:UrlAppAddCustomersList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.nameTextField.text, @"credit_real_name", self.phoneTextField.text, @"contact_phone", self.idNumberTextField.text, @"id_no", self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
            self.notiString = @"添加成功";
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

@end
