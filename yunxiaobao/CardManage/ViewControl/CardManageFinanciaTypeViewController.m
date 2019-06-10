//
//  CardManageFinanciaTypeViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageFinanciaTypeViewController.h"

@interface CardManageFinanciaTypeViewController ()

/**
 开始时间
 */
@property(nonatomic, strong)UILabel *kaishiTimeLabel;

/**
 结束时间
 */
@property(nonatomic, strong)UILabel *jiesuTimeLabel;

/**
 服务费用
 */
@property(nonatomic, strong)UILabel *fuwuMoneyLabel;

/**
 提额服务费
 */
@property(nonatomic, strong)UILabel *tieMoneyLabel;

/**
 成本
 */
@property(nonatomic, strong)UILabel *chengbenMoneyLabel;

/**
 利润
 */
@property(nonatomic, strong)UILabel *lirunMoneyLabel;

/**
 确认收款
 */
@property(nonatomic, strong)UIButton *makeSureCollectionButton;

@end

@implementation CardManageFinanciaTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.financiaTypeString isEqualToString:@"1"]) {
        [self.makeSureCollectionButton addTarget:self action:@selector(makeSureCollection) forControlEvents:UIControlEventTouchUpInside];
        self.titleString = @"卡收款";
    }else{
        self.titleString = @"查看";
    }
}

-(void)makeSureCollection{
    [self urlHeadStr:AppCardFinanceURL urlStr:UrlUpdateFinances parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.financesListModel.card_id, @"fId", self.financesListModel.is_payed, @"is_payed", nil] Success:^(NSDictionary *obj) {
        self.notiString = @"收款成功";
        [self popVC];
    }];
}

-(void)createUI{
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 331)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 119, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 174, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 229, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 284, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 339, 360, 1)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"开始时间", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 85, 150, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"结束时间", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 140, 150, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"服务费用", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 195, 150, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"提额服务费", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 250, 150, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"成本", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 305, 150, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"利润", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 360, 150, 15)];
    
    self.kaishiTimeLabel.text = [self.financesListModel.begin_time componentsSeparatedByString:@" "][0];
    self.jiesuTimeLabel.text = [self.financesListModel.end_time componentsSeparatedByString:@" "][0];
    self.fuwuMoneyLabel.text = self.financesListModel.fee;
    self.tieMoneyLabel.text = self.financesListModel.card_pay_base_amount;
    self.chengbenMoneyLabel.text = self.financesListModel.lifting_amount;
    self.lirunMoneyLabel.text = self.financesListModel.amount;
    
}

-(UILabel *)kaishiTimeLabel{
    if (!_kaishiTimeLabel) {
        _kaishiTimeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 85, 160, 16)];
    }
    return _kaishiTimeLabel;
}

-(UILabel *)jiesuTimeLabel{
    if (!_jiesuTimeLabel) {
        _jiesuTimeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 140, 160, 16)];
    }
    return _jiesuTimeLabel;
}

-(UILabel *)fuwuMoneyLabel{
    if (!_fuwuMoneyLabel) {
        _fuwuMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 195, 160, 16)];
    }
    return _fuwuMoneyLabel;
}

-(UILabel *)tieMoneyLabel{
    if (!_tieMoneyLabel) {
        _tieMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 250, 160, 16)];
    }
    return _tieMoneyLabel;
}

-(UILabel *)chengbenMoneyLabel{
    if (!_chengbenMoneyLabel) {
        _chengbenMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 305, 160, 16)];
    }
    return _chengbenMoneyLabel;
}

-(UILabel *)lirunMoneyLabel{
    if (!_lirunMoneyLabel) {
        _lirunMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 360, 160, 16)];
    }
    return _lirunMoneyLabel;
}

-(UIButton *)makeSureCollectionButton{
    if (!_makeSureCollectionButton) {
        _makeSureCollectionButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"确认收款", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 0, DelouchHeight - 49 * self.baseicFloat, DelouchWidth, 49 * self.baseicFloat)];
    }
    return _makeSureCollectionButton;
}

@end
