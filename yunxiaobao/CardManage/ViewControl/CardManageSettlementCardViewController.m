//
//  CardManageSettlementCardViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageSettlementCardViewController.h"

@interface CardManageSettlementCardViewController ()

/**
 托管总天数
 */
@property(nonatomic, strong)UILabel *tuokuanDayLabel;

/**
 未出财务托管天数
 */
@property(nonatomic, strong)UILabel *weichucaiDayLabel;

/**
 未支付总金额
 */
@property(nonatomic, strong)UILabel *weizhifuMoneyLabel;

/**
 服务费用
 */
@property(nonatomic, strong)UILabel *fuwuMoneyLabel;

/**
 提额服务费
 */
@property(nonatomic, strong)UILabel *tieMoneyLabel;

/**
 卡片初始额度
 */
@property(nonatomic, strong)UILabel *chusiMoneyLabel;

/**
 当前额度
 */
@property(nonatomic, strong)UILabel *dangqianeduMoneyLabel;

/**
 卡片应还款额度
 */
@property(nonatomic, strong)UILabel *yinghuanMoneyLabel;

/**
 确认结算
 */
@property(nonatomic, strong)UIButton *makeSureSettlementButton;

@end

@implementation CardManageSettlementCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"卡结算";
}

-(void)createUI{
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 441)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 119, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 174, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 229, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 284, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 339, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 394, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 449, 360, 1)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"托管总天数", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 85, 150, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"未出财务托管天数", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 140, 150, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"未支付总金额", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 195, 150, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"服务费用", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 250, 150, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"提额服务费", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 305, 150, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"卡片初始额度", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 360, 150, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"当前额度", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 415, 150, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"卡片应还款额度", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 470, 150, 15)];
    
    
    [self.makeSureSettlementButton addTarget:self action:@selector(makeSureSettlement) forControlEvents:UIControlEventTouchUpInside];
    
    self.tuokuanDayLabel.text = @"45天";
    self.weichucaiDayLabel.text = @"23天";
    self.weizhifuMoneyLabel.text = @"3000.00";
    self.chusiMoneyLabel.text = @"3000.00";
    self.dangqianeduMoneyLabel.text = self.financesListModel.card_usable_amount;
    self.yinghuanMoneyLabel.text = @"3000.00";
    self.fuwuMoneyLabel.text = self.financesListModel.fee;
    self.tieMoneyLabel.text = self.financesListModel.card_pay_base_amount;
}

-(void)makeSureSettlement{
    [self urlHeadStr:AppCardFinanceURL urlStr:UrCardFinish parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", self.financesListModel.card_id, @"card_id", nil] Success:^(NSDictionary *obj) {
        self.notiString = @"结算成功";
        [self popVC];
    }];
}

-(UILabel *)tuokuanDayLabel{
    if (!_tuokuanDayLabel) {
        _tuokuanDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 85, 160, 16)];
    }
    return _tuokuanDayLabel;
}

-(UILabel *)weichucaiDayLabel{
    if (!_weichucaiDayLabel) {
        _weichucaiDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 140, 160, 16)];
    }
    return _weichucaiDayLabel;
}

-(UILabel *)weizhifuMoneyLabel{
    if (!_weizhifuMoneyLabel) {
        _weizhifuMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 195, 160, 16)];
    }
    return _weizhifuMoneyLabel;
}

-(UILabel *)fuwuMoneyLabel{
    if (!_fuwuMoneyLabel) {
        _fuwuMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 250, 160, 16)];
    }
    return _fuwuMoneyLabel;
}

-(UILabel *)tieMoneyLabel{
    if (!_tieMoneyLabel) {
        _tieMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 305, 160, 16)];
    }
    return _tieMoneyLabel;
}

-(UILabel *)chusiMoneyLabel{
    if (!_chusiMoneyLabel) {
        _chusiMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 360, 160, 16)];
    }
    return _chusiMoneyLabel;
}

-(UILabel *)dangqianeduMoneyLabel{
    if (!_dangqianeduMoneyLabel) {
        _dangqianeduMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 414, 160, 16)];
    }
    return _dangqianeduMoneyLabel;
}

-(UILabel *)yinghuanMoneyLabel{
    if (!_yinghuanMoneyLabel) {
        _yinghuanMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 469, 160, 16)];
    }
    return _yinghuanMoneyLabel;
}

-(UIButton *)makeSureSettlementButton{
    if (!_makeSureSettlementButton) {
        _makeSureSettlementButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"确认结算", 2, 255, 255, 255, 1, 255, 68, 32, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 0, DelouchHeight - 49 * self.baseicFloat, DelouchWidth, 49 * self.baseicFloat)];
    }
    return _makeSureSettlementButton;
}

@end
