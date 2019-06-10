//
//  CardManageInformationViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageInformationViewController.h"
#import "MainViewController.h"

@interface CardManageInformationViewController ()

/**
 银行卡背景
 */
@property(nonatomic, strong)UIImageView *bankIconImageView;

/**
 银行卡icon
 */
@property(nonatomic, strong)UIImageView *iconImageView;

/**
 银行卡icon
 */
@property(nonatomic, strong)NSString *iconString;

/**
 银行卡名称
 */
@property(nonatomic, strong)UILabel *bankNameLabel;

/**
 用户信息
 */
@property(nonatomic, strong)UILabel *userInfoLabel;

/**
 用户姓名
 */
@property(nonatomic, strong)UILabel *nameLabel;

/**
 用户卡号
 */
@property(nonatomic, strong)UILabel *cardNumberLabel;

/**
 账单日
 */
@property(nonatomic, strong)UILabel *billDayLabel;

/**
 还款日
 */
@property(nonatomic, strong)UILabel *reimbursementDayLabel;

/**
 保存按钮
 */
@property(nonatomic, strong)UIButton *saveButton;

/**
 额度信息
 */
@property(nonatomic, strong)UIImageView *seeNumberButton;

/**
 收费设置
 */
@property(nonatomic, strong)UIImageView *setChargeButton;

@end

@implementation CardManageInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"卡信息管理";
}

-(void)createUI{
    self.infoDic = DelouchRightButtonInfomake(@"删除", 51, 51, 51, 1, 255, 255, 255, 2, 13);
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 146, 375, 120)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 276, 375, 110)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 396, 375, 55)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 461, 375, 55)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(229, 229, 229, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 211, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(229, 229, 229, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 331, 360, 1)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"真实姓名", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 176, 82, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"用户卡号", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 231, 82, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"账单日", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 296, 82, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"还款日", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 351, 82, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"额度信息", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 416, 82, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"收费设置", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 481, 82, 15)];
    
    
//    UIView *colorView = [[UIView alloc]initWithFrame:CGRectMake(0, DelouchStatusBarAndNavigationBarHeight, DelouchWidth, 82 * self.baseicFloat)];
//    [self.view addSubview:colorView];
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = colorView.bounds;
//    gradient.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor colorWithRed:227 / 255.0 green:227 / 255.0 blue:227 / 255.0 alpha:1].CGColor];
//    gradient.startPoint = CGPointMake(0.5, 0);
//    gradient.endPoint = CGPointMake(0.5, 1);
//    [colorView.layer addSublayer:gradient];
    
//    self.bankIconImageView.image = [UIImage imageNamed:bg_BankCard_jh];
    
    self.bankIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@750x144.png", self.cardListModel.card_bank]];
    
    self.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"logo_%@80.png", self.cardListModel.card_bank]];
    
    self.userInfoLabel.text = [NSString stringWithFormat:@"%@ | 尾号 %@", self.cardListModel.credit_real_name, [self.cardListModel.card_no substringWithRange:NSMakeRange(self.cardListModel.card_no.length - 4, 4)]];
    self.bankNameLabel.text = self.cardListModel.card_bank;
    
    [self.saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameLabel.text = self.cardListModel.credit_real_name;
    self.cardNumberLabel.text = self.cardListModel.card_no;
    self.billDayLabel.text = self.cardListModel.card_bill_day_str;
    self.reimbursementDayLabel.text = self.cardListModel.card_bill_return_day_str;
    
    [self.seeNumberButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeNumber)]];
    [self.setChargeButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setCharge)]];
    
//    self.iconString = @"";
}

-(void)rightSelect{
    UIAlertController *deleteAlert=[UIAlertController
                                    alertControllerWithTitle: nil
                                    message:@"是否删除此卡片"
                                    preferredStyle:UIAlertControllerStyleAlert
                                    ];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [cancelAction setValue:[UIColor colorWithRed:9 / 255.0 green:1 / 255.0 blue:3 / 255.0 alpha:1] forKey:@"titleTextColor"];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf deleteCard];
    }];
    [deleteAction setValue:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forKey:@"titleTextColor"];
    
    [deleteAlert addAction:deleteAction];
    [deleteAlert addAction:cancelAction];
    
    [self presentViewController:deleteAlert animated:true completion:nil];
}

-(void)deleteCard{
    [self urlHeadStr:AppCardsURL urlStr:UrlDeleatCardsApp parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel.card_id, @"id", nil] Success:^(NSDictionary *obj) {
        self.notiString = @"删除成功";
//        [self popVC];
        MainViewController *mainVC = nil;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[MainViewController class]]) {
                mainVC = (MainViewController *)vc;
            }
        }
        [self.navigationController popToViewController:mainVC animated:YES];
    }];
}

-(void)seeNumber{
    [self pushViewControl:@"CardManageSeeBankCardLineViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel, @"cardListModel", nil]];
}

-(void)setCharge{
    [self pushViewControl:@"CardManageSetChargeViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel, @"cardListModel", nil]];
}

-(void)save{
    self.notiString = @"保存成功";
    [self popVC];
}

-(UIImageView *)bankIconImageView{
    if (!_bankIconImageView) {
        _bankIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 74, 375, 72)];
    }
    return _bankIconImageView;
}

-(UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 72, 97, 200, 14)];
    }
    return _bankNameLabel;
}

-(UILabel *)userInfoLabel{
    if (!_userInfoLabel) {
        _userInfoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 10, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 72, 115, 200, 10)];
    }
    return _userInfoLabel;
}

-(UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"保存", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 536, 345, 44)];
        [self setbuttonLayer:_saveButton layerMask:3];
    }
    return _saveButton;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"真实姓名", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 107, 176, 253, 15)];
    }
    return _nameLabel;
}

-(UILabel *)cardNumberLabel{
    if (!_cardNumberLabel) {
        _cardNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"真实姓名", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 107, 233, 253, 15)];
    }
    return _cardNumberLabel;
}

-(UILabel *)billDayLabel{
    if (!_billDayLabel) {
        _billDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"真实姓名", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 107, 297, 253, 15)];
    }
    return _billDayLabel;
}

-(UILabel *)reimbursementDayLabel{
    if (!_reimbursementDayLabel) {
        _reimbursementDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"真实姓名", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 107, 352, 253, 15)];
    }
    return _reimbursementDayLabel;
}

-(UIImageView *)seeNumberButton{
    if (!_seeNumberButton) {
        _seeNumberButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 343, 408, 27, 32)];
        _seeNumberButton.contentMode = UIViewContentModeCenter;
    }
    return _seeNumberButton;
}

-(UIImageView *)setChargeButton{
    if (!_setChargeButton) {
        _setChargeButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 343, 473, 27, 32)];
        _setChargeButton.contentMode = UIViewContentModeCenter;
    }
    return _setChargeButton;
}

-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 94, 32, 32)];
    }
    return _iconImageView;
}

-(void)setIconString:(NSString *)iconString{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconString] placeholderImage:[UIImage imageNamed:zwt_yuan_128]];
}

@end
