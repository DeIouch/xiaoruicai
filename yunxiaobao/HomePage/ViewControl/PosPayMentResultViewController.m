//
//  PosPayMentResultViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "PosPayMentResultViewController.h"
#import "HomePageViewController.h"
#import "MainViewController.h"

@interface PosPayMentResultViewController ()

@property(nonatomic, strong)UIButton *seeOrderButton;

@property(nonatomic, strong)UIButton *goHomeButton;

@property(nonatomic, strong)UIButton *resetPaymentButton;

@property(nonatomic, strong)UILabel *orderMoneyLabel;

@end

@implementation PosPayMentResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"支付结果";    
    if ([self.payResultString isEqualToString:@"success"]) {
        [self createSuccessUI];
    }else{
        [self createFailureUI];
    }
}

-(void)createSuccessUI{
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_zfcg, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 136, 124, 105, 87)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"订单支付成功", 2, 51, 51, 51, 1, 255, 255, 255, 2, 20, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 236, 375, 20)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"我们将尽快为您安排发货", 2, 153, 153, 153, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 312, 375, 13)];
    
    self.orderMoneyLabel.text = self.moneyString;
    [self.seeOrderButton addTarget:self action:@selector(seeOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.goHomeButton addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
}

-(void)seeOrder{
    [self pushViewControl:@"HomePageBuyedPosViewController" propertyDic:nil];
}

-(void)goHome{
    MainViewController *mainVC = nil;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[MainViewController class]]) {
            mainVC = (MainViewController *)vc;
        }
    }
    [self.navigationController popToViewController:mainVC animated:YES];
}

-(void)resetPayment{
    [self popVC];
}

-(void)createFailureUI{
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_zfsb, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 136, 124, 105, 87)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"订单支付失败", 2, 51, 51, 51, 1, 255, 255, 255, 2, 20, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 236, 375, 20)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"检查是否确认支付", 2, 153, 153, 153, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 312, 375, 13)];
    
    self.orderMoneyLabel.text = self.moneyString;
    [self.resetPaymentButton addTarget:self action:@selector(resetPayment) forControlEvents:UIControlEventTouchUpInside];
    [self.goHomeButton addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
}

-(UILabel *)orderMoneyLabel{
    if (!_orderMoneyLabel) {
        _orderMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 51, 51, 51, 1, 255, 255, 255, 2, 24, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 275, 375, 24)];
    }
    return _orderMoneyLabel;
}

-(UIButton *)seeOrderButton{
    if (!_seeOrderButton) {
        _seeOrderButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"查看订单", 2, 86, 112, 254, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 40, 361, 120, 44)];
        [self setbuttonLayer:_seeOrderButton layerMask:3];
        _seeOrderButton.layer.borderColor = [UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1].CGColor;//设置边框颜色
        _seeOrderButton.layer.borderWidth = self.baseicFloat;
    }
    return _seeOrderButton;
}

-(UIButton *)goHomeButton{
    if (!_goHomeButton) {
        _goHomeButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"返回首页", 2, 153, 153, 153, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 215, 361, 120, 44)];
        [self setbuttonLayer:_goHomeButton layerMask:3];
        _goHomeButton.layer.borderColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1].CGColor;//设置边框颜色
        _goHomeButton.layer.borderWidth = self.baseicFloat;
    }
    return _goHomeButton;
}

-(UIButton *)resetPaymentButton{
    if (!_resetPaymentButton) {
        _resetPaymentButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"重新支付", 2, 86, 112, 254, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 40, 361, 120, 44)];
        [self setbuttonLayer:_resetPaymentButton layerMask:3];
        _resetPaymentButton.layer.borderColor = [UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1].CGColor;//设置边框颜色
        _resetPaymentButton.layer.borderWidth = self.baseicFloat;
    }
    return _resetPaymentButton;
}

@end
