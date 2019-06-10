//
//  ALiPayCertificationViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "ALiPayCertificationViewController.h"
#import "GoRealNameViewController.h"

@interface ALiPayCertificationViewController ()

/**
 请输入支付宝名称
 */
@property(nonatomic, strong)UITextField *alipayNameTextField;

/**
 请输入支付宝帐号
 */
@property(nonatomic, strong)UITextField *alipayAccountTextField;

/**
 确认绑定
 */
@property(nonatomic, strong)UIButton *makeSureBindButton;

@end

@implementation ALiPayCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"支付宝认证";
}

-(void)createUI{
    self.headview.lineView.hidden = YES;
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"请绑定收款账户信息", 1, 51, 51, 51, 1, 255, 255, 255, 2, 24, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 105, 345, 23)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"以保证您的资金能安全到达指定账户", 1, 153, 153, 153, 1, 255, 255, 255, 2, 13, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 137, 345, 13)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 231, 345, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 293, 345, 1)];
    
    self.alipayNameTextField.placeholder = @"请输入支付宝账户姓名";
    self.alipayAccountTextField.placeholder = @"请输入支付宝账户";
    
    [self.makeSureBindButton addTarget:self action:@selector(makeSureBind) forControlEvents:UIControlEventTouchUpInside];
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

-(UIButton *)makeSureBindButton{
    if (!_makeSureBindButton) {
        _makeSureBindButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"确认绑定", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 328, 345, 48)];
        [self setbuttonLayer:_makeSureBindButton layerMask:24];
    }
    return _makeSureBindButton;
}

-(void)makeSureBind{
    __weak typeof(self) weakSelf = self;
    [self urlHeadStr:AppInfoURL urlStr:UrlAlipayaAttestation parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"id", self.alipayAccountTextField.text, @"alipay_account", self.alipayNameTextField.text, @"alipay_name", nil] Success:^(NSDictionary *obj) {
//        self.notiString = @"绑定成功";
        [weakSelf freshUserInfo];
        
//        [self.navigationController popViewControllerAnimated:YES];
    }];
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

-(void)freshUserInfo{
    [self urlHeadStr:AppInfoURL urlStr:UrlMyList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"id", nil] Success:^(NSDictionary *obj) {
        [self preservationUserinfo:obj[@"result"][@"list"]];
        self.notiString = @"绑定成功";
        [self pushViewControl:@"ALiPayCertificationResultViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.alipayNameTextField.text, @"alipayNameString", self.alipayAccountTextField.text, @"alipayAccountString", nil]];
    }];
}

@end
