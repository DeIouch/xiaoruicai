//
//  CardManageSeeBankCardLineViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageSeeBankCardLineViewController.h"

@interface CardManageSeeBankCardLineViewController ()

/**
 初始金额
 */
@property(nonatomic, strong)UILabel *chusiMoneyLabel;

/**
 可用余额
 */
@property(nonatomic, strong)UILabel *keyonMoneyLabel;

/**
 保留金
 */
@property(nonatomic, strong)UILabel *baoliuMoneyLabel;

/**
 固定额度
 */
@property(nonatomic, strong)UILabel *gudingLabel;

/**
 提额额度
 */
@property(nonatomic, strong)UILabel *tieMoneyLabel;

/**
 临时额度
 */
@property(nonatomic, strong)UILabel *linsiMoneyLabel;

/**
 临时额度有效期
 */
@property(nonatomic, strong)UILabel *linsiMoneyTimeLabel;

/**
 本期应还
 */
@property(nonatomic, strong)UILabel *yinghuanMoneyLabel;

@end

@implementation CardManageSeeBankCardLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"额度信息";
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    self.chusiMoneyLabel.text = self.cardListModel.card_original_amount;
    self.keyonMoneyLabel.text = self.cardListModel.card_usable_amount;
    self.baoliuMoneyLabel.text = self.cardListModel.card_keeping_amount;
    self.gudingLabel.text = self.cardListModel.card_fixed_amount;
//    self.tieMoneyLabel.text = [NSString stringWithFormat:@"提额%@", self.cardListModel.card_recent_amount];
    self.linsiMoneyLabel.text = self.cardListModel.card_recent_amount;
    self.linsiMoneyTimeLabel.text = self.cardListModel.card_recent_amount_end_time;
    self.yinghuanMoneyLabel.text = self.cardListModel.card_current_bill_return_amount;
}

-(void)createUI{
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 165)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 240, 375, 165)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 415, 375, 55)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"初始金额", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 85, 82, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"可用余额", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 140, 82, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"保留金", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 195, 82, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"固定额度", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 260, 82, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"临时额度", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 315, 82, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"临时额度有效期", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 370, 130, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"本期应还", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 435, 82, 15)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 119, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 174, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 294, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 349, 360, 1)];
}

-(UILabel *)chusiMoneyLabel{
    if (!_chusiMoneyLabel) {
        _chusiMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 204, 204, 204, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 85, 250, 15)];
    }
    return _chusiMoneyLabel;
}

-(UILabel *)keyonMoneyLabel{
    if (!_keyonMoneyLabel) {
        _keyonMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 140, 250, 15)];
    }
    return _keyonMoneyLabel;
}

-(UILabel *)baoliuMoneyLabel{
    if (!_baoliuMoneyLabel) {
        _baoliuMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 204, 204, 204, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 195, 250, 15)];
    }
    return _baoliuMoneyLabel;
}

-(UILabel *)gudingLabel{
    if (!_gudingLabel) {
        _gudingLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 204, 204, 204, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 260, 110, 15)];
    }
    return _gudingLabel;
}


-(UILabel *)tieMoneyLabel{
    if (!_tieMoneyLabel) {
        _tieMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 230, 260, 130, 15)];
    }
    return _tieMoneyLabel;
}


-(UILabel *)linsiMoneyLabel{
    if (!_linsiMoneyLabel) {
        _linsiMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 315, 250, 15)];
    }
    return _linsiMoneyLabel;
}


-(UILabel *)linsiMoneyTimeLabel{
    if (!_linsiMoneyTimeLabel) {
        _linsiMoneyTimeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 154, 371, 206, 15)];
    }
    return _linsiMoneyTimeLabel;
}

-(UILabel *)yinghuanMoneyLabel{
    if (!_yinghuanMoneyLabel) {
        _yinghuanMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 204, 204, 204, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 435, 110, 15)];
    }
    return _yinghuanMoneyLabel;
}

@end
