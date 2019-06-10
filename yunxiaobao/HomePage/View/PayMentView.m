//
//  PayMentView.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/20.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "PayMentView.h"

@interface PayMentView ()

/**
 隐藏按钮
 */
@property(nonatomic, strong)UIImageView *hiddenButton;

/**
 支付宝支付
 */
@property(nonatomic, strong)UIImageView *chooseAlipayButton;

///**
// 微信支付
// */
//@property(nonatomic, strong)UIImageView *chooseWechatButton;

/**
 立即付款
 */
@property(nonatomic, strong)UIButton *goPaymentButton;

/**
 付款金额
 */
@property(nonatomic, strong)UILabel *moneyLabel;

@end

@implementation PayMentView

-(UIView *)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:0.6];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"确定付款", 2, 34, 34, 34, 1, 255, 255, 255, 2, 18, YES, self.backView) setFrame:DelouchFrameMake(FrameCellView, 0, 17 * (DelouchWidth / 375.0), DelouchWidth, 18 * (DelouchWidth / 375.0))];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(238, 238, 238, 1, NO, 0, self.backView) setFrame:DelouchFrameMake(FrameCellView, 15, 183, 360, 1)];
        
//        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(238, 238, 238, 1, NO, 0, self.backView) setFrame:DelouchFrameMake(FrameCellView, 15, 240, 360, 1)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"支付宝", 1, 51, 51, 51, 1, 255, 255, 255, 2, 17, YES, self.backView) setFrame:DelouchFrameMake(FrameCellView, 62, 146, 150, 17)];
        
//        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"微信", 1, 51, 51, 51, 1, 255, 255, 255, 2, 17, YES, self.backView) setFrame:DelouchFrameMake(FrameCellView, 62, 203, 150, 17)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(logo_zfb, NO, 0, self.backView) setFrame:DelouchFrameMake(FrameCellView, 15, 139, 32, 32)];
        
//        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(logo_wx, NO, 0, self.backView) setFrame:DelouchFrameMake(FrameCellView, 15, 196, 32, 32)];
        
        [self.hiddenButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)]];
        
        [self.chooseAlipayButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlipay)]];
        
//        [self.chooseWechatButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseWechat)]];
        
        [self.goPaymentButton addTarget:self action:@selector(goPayment) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)goPayment{
    self.hidden = YES;
    self.payMentBlock();
}

-(void)chooseAlipay{
    self.choosePaymentTypeBOOL = YES;
}

-(void)chooseWechat{
    self.choosePaymentTypeBOOL = NO;
}

-(void)hidden{
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.frame = CGRectMake(0, DelouchHeight, DelouchWidth, 0);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

-(UIImageView *)hiddenButton{
    if(!_hiddenButton){
        _hiddenButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_guanbi_other, NO, 0, _backView) setFrame:DelouchFrameMake(FrameCellView, 337, 5, 34, 34)];
        _hiddenButton.contentMode = UIViewContentModeCenter;
    }
    return _hiddenButton;
}

-(UIImageView *)chooseAlipayButton{
    if(!_chooseAlipayButton){
        _chooseAlipayButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_zf_wx, NO, 0, _backView) setFrame:DelouchFrameMake(FrameCellView, 332, 136, 38, 38)];
        _chooseAlipayButton.contentMode = UIViewContentModeCenter;
    }
    return _chooseAlipayButton;
}

//-(UIImageView *)chooseWechatButton{
//    if(!_chooseWechatButton){
//        _chooseWechatButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_zf_wx, NO, 0, _backView) setFrame:DelouchFrameMake(FrameCellView, 332, 193, 38, 38)];
//        _chooseWechatButton.contentMode = UIViewContentModeCenter;
//    }
//    return _chooseWechatButton;
//}

-(UIButton *)goPaymentButton{
    if(!_goPaymentButton){
        _goPaymentButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"立即付款", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, _backView) setFrame:DelouchFrameMake(FrameCellView, 15, 203, 345, 44)];
        [DelouchLibrary setbuttonLayer:_goPaymentButton layerMask:3];
    }
    return _goPaymentButton;
}

-(UILabel *)moneyLabel{
    if(!_moneyLabel){
        _moneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 51, 51, 51, 1, 255, 255, 255, 2, 36, YES, _backView) setFrame:DelouchFrameMake(FrameCellView, 0, 70, 375, 35)];
    }
    return _moneyLabel;
}

-(UIView *)backView{
    if(!_backView){
        _backView = [[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self) setFrame:DelouchFrameMake(FrameNotChange, 0, DelouchHeight, DelouchWidth, 0)];
    }
    return _backView;
}

-(void)setMoneyString:(NSString *)moneyString{
    self.moneyLabel.text = moneyString;
}

-(void)setChoosePaymentTypeBOOL:(BOOL)choosePaymentTypeBOOL{
    if(_choosePaymentTypeBOOL != choosePaymentTypeBOOL){
        _choosePaymentTypeBOOL = choosePaymentTypeBOOL;
        if(choosePaymentTypeBOOL){
            self.chooseAlipayButton.image = [UIImage imageNamed:icon_zf_yx];
//            self.chooseWechatButton.image = [UIImage imageNamed:icon_zf_wx];
        }else{
//            self.chooseWechatButton.image = [UIImage imageNamed:icon_zf_yx];
            self.chooseAlipayButton.image = [UIImage imageNamed:icon_zf_wx];
        }
    }
}

@end
