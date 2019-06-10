//
//  ALiPayCertificationResultViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "ALiPayCertificationResultViewController.h"
#import "GoRealNameViewController.h"

@interface ALiPayCertificationResultViewController ()

/**
 认证结果
 */
@property(nonatomic, strong)UIImageView *certificationResultImageView;

/**
 认证结果
 */
@property(nonatomic, strong)UILabel *CertificationResultLabel;

/**
 支付宝姓名
 */
@property(nonatomic, strong)UILabel *alipayNameLabel;

/**
 支付宝账号
 */
@property(nonatomic, strong)UILabel *alipayAccountLabel;

/**
 重置修改
 */
@property(nonatomic, strong)UIButton *resetBindButton;

@end

@implementation ALiPayCertificationResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"支付宝绑定";
}

-(void)createUI{
    self.headview.lineView.hidden = YES;
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"账户姓名", 1, 153, 153, 153, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 280, 80, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"支付宝账户", 1, 153, 153, 153, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 342, 80, 15)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 318, 345, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 380, 345, 1)];
    
    self.certificationResultImageView.image = [UIImage imageNamed:bg_zfb_rzcg];
    
    self.CertificationResultLabel.text = @"绑定成功";
    
//    self.alipayNameLabel.text = self.userInfoModel.alipay_name;
//
//    self.alipayAccountLabel.text = self.userInfoModel.alipay_account;
    
    [self.resetBindButton addTarget:self action:@selector(resetBind) forControlEvents:UIControlEventTouchUpInside];
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

-(void)resetBind{
    [self pushViewControl:@"ALiPayCertificationViewController" propertyDic:nil];
}

-(UIImageView *)certificationResultImageView{
    if (!_certificationResultImageView) {
        _certificationResultImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(bg_zfb_rzcg, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 90, 65, 196, 145)];
    }
    return _certificationResultImageView;
}

-(UILabel *)CertificationResultLabel{
    if (!_CertificationResultLabel) {
        _CertificationResultLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 225, 375, 17)];
    }
    return _CertificationResultLabel;
}

-(UILabel *)alipayNameLabel{
    if (!_alipayNameLabel) {
        _alipayNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 105, 280, 255, 15)];
    }
    return _alipayNameLabel;
}

-(UILabel *)alipayAccountLabel{
    if (!_alipayAccountLabel) {
        _alipayAccountLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 105, 343, 255, 15)];
    }
    return _alipayAccountLabel;
}

-(UIButton *)resetBindButton{
    if (!_resetBindButton) {
        _resetBindButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"重置修改", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 415, 345, 48)];
        [self setbuttonLayer:_resetBindButton layerMask:24];
    }
    return _resetBindButton;
}

-(void)setAlipayNameString:(NSString *)alipayNameString{
    self.alipayNameLabel.text = alipayNameString;
}

-(void)setAlipayAccountString:(NSString *)alipayAccountString{
    self.alipayAccountLabel.text = alipayAccountString;
}

@end
