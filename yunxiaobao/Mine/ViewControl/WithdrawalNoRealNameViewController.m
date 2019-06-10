//
//  WithdrawalNoRealNameViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/18.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "WithdrawalNoRealNameViewController.h"

@interface WithdrawalNoRealNameViewController ()

/**
 确定提现
 */
@property(nonatomic, strong)UIButton *makeSureWithdrawalButton;

/**
 账户姓名
 */
@property(nonatomic, strong)UILabel *nameLabel;

/**
 支付宝账户
 */
@property(nonatomic, strong)UILabel *aliPayAccountLabel;

/**
 提现金额
 */
@property(nonatomic, strong)UITextField *withdrawalMoneyTextField;

/**
 全部提现
 */
@property(nonatomic, strong)UIButton *withdrawalAllMoneyButton;

/**
 可用余额(元)
 */
@property(nonatomic, strong)UILabel *keyonMoneyLabel;

/**
 可提现余额(元)
 */
@property(nonatomic, strong)UILabel *withdrawalMoneyLabel;

/**
 总收益(元)
 */
@property(nonatomic, strong)UILabel *allEarningsLabel;

/**
 昨日收益
 */
@property(nonatomic, strong)UILabel *yesterdayEarningsLabel;

/**
 余额是否显示
 */
@property(nonatomic, strong)UIImageView *seeNumberButton;

/**
 是否显示余额
 */
@property(nonatomic, assign)BOOL seeNumberBOOL;

@end

@implementation WithdrawalNoRealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"我要提现";
}

-(void)makeSureWithdrawal{
    if (self.withdrawalMoneyTextField.text.length == 0) {
        self.notiString = @"请输入提现金额";
    }else if ([self.withdrawalMoneyTextField.text isEqualToString:@"0"]) {
        self.notiString = @"提现金额不能为0";
    }else if ([self.withdrawalMoneyTextField.text intValue] <= 100) {
        self.notiString = @"提现金额不能少于100";
    }else{
        [self urlHeadStr:AppInfoURL urlStr:UrlWithdraw parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", self.withdrawalMoneyTextField.text, @"withdraw_amount", nil] Success:^(NSDictionary *obj) {
            self.notiString = @"提现成功";
            [self getMoneyInfo];
        }];
    }
}

-(void)createUI{
    [self.headview.leftButton setImage:[UIImage imageNamed:icon_return_white] forState:UIControlStateNormal];
    self.headview.titleLabel.textColor = [UIColor whiteColor];
    
    self.headview.backgroundColor = [UIColor colorWithRed:97 / 255.0 green:127 / 255.0 blue:254 / 255.0 alpha:1];
    self.headview.lineView.hidden = YES;
    self.infoDic = DelouchRightButtonInfomake(@"收支明细", 255, 255, 255, 0.8, 255, 255, 255, 2, 15);
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(97, 127, 254, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 151)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 0.2, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 188, 150, 1, 40)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"可提现余额", 1, 255, 255, 255, 0.8, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 203, 84, 100, 14)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"可用余额(元)", 1, 255, 255, 255, 0.8, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 84, 100, 14)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"总收益(元)", 1, 255, 255, 255, 0.8, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 152, 100, 14)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"昨日收益", 1, 255, 255, 255, 0.8, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 203, 152, 100, 14)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 215, 375, 38)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"账号信息", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 227, 200, 13)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"账户姓名", 1, 153, 153, 153, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 16, 277, 90, 13)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"支付宝账户", 1, 153, 153, 153, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 16, 337, 90, 13)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 313, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 373, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 473, 345, 1)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"提现金额", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 393, 200, 16)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"￥", 2, 0, 0, 0, 1, 255, 255, 255, 2, 28, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 10, 427, 30, 27)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"提现说明：合规收入 、长久稳定 ，纳税金额为提现收益的7%！", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 484, 345, 12)];
    
    [self.makeSureWithdrawalButton addTarget:self action:@selector(makeSureWithdrawal) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameLabel.text = self.userInfoModel.alipay_name;
    self.aliPayAccountLabel.text = self.userInfoModel.alipay_account;
    self.withdrawalMoneyTextField.placeholder = @"最低100元起";
    [self.withdrawalAllMoneyButton addTarget:self action:@selector(withdrawalAllMoney) forControlEvents:UIControlEventTouchUpInside];
    
    self.seeNumberBOOL = YES;
    [self.seeNumberButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeNumber)]];
}

-(void)getMoneyInfo{
    [self urlHeadStr:AppInfoURL urlStr:UrlMywithdraws parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"id", nil] Success:^(NSDictionary *obj) {
        if ([obj[@"result"] isKindOfClass:[NSDictionary class]]) {
            self.mywithdrawsModel = [[MywithdrawsModel alloc]initModelWithDic:obj[@"result"]];
            self.seeNumberBOOL = self.seeNumberBOOL;
        }
    }];
}

-(void)rightSelect{
    [self pushViewControl:@"PaymentDetailsViewController" propertyDic:nil];
}

-(void)seeNumber{
    self.seeNumberBOOL = !self.seeNumberBOOL;
}

-(void)withdrawalAllMoney{
    self.withdrawalMoneyTextField.text = self.mywithdrawsModel.keyong;
}

-(UIButton *)makeSureWithdrawalButton{
    if (!_makeSureWithdrawalButton) {
        _makeSureWithdrawalButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"确定提现", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 536, 345, 44)];
        [self setbuttonLayer:_makeSureWithdrawalButton layerMask:3];
    }
    return _makeSureWithdrawalButton;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 113, 277, 247, 13)];
    }
    return _nameLabel;
}

-(UILabel *)aliPayAccountLabel{
    if (!_aliPayAccountLabel) {
        _aliPayAccountLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 113, 336, 247, 13)];
    }
    return _aliPayAccountLabel;
}

-(UITextField *)withdrawalMoneyTextField{
    if (!_withdrawalMoneyTextField) {
        _withdrawalMoneyTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 40, 425, 236, 36)];
    }
    return _withdrawalMoneyTextField;
}

-(UIButton *)withdrawalAllMoneyButton{
    if (!_withdrawalAllMoneyButton) {
        _withdrawalAllMoneyButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"全部提现", 2, 86, 112, 254, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 286, 425, 83, 36)];
    }
    return _withdrawalAllMoneyButton;
}

-(UILabel *)keyonMoneyLabel{
    if (!_keyonMoneyLabel) {
        _keyonMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 21, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 106, 150, 21)];
    }
    return _keyonMoneyLabel;
}

-(UILabel *)withdrawalMoneyLabel{
    if (!_withdrawalMoneyLabel) {
        _withdrawalMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 21, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 203, 106, 150, 21)];
    }
    return _withdrawalMoneyLabel;
}

-(UILabel *)allEarningsLabel{
    if (!_allEarningsLabel) {
        _allEarningsLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 175, 150, 15)];
    }
    return _allEarningsLabel;
}

-(UILabel *)yesterdayEarningsLabel{
    if (!_yesterdayEarningsLabel) {
        _yesterdayEarningsLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 21, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 203, 175, 150, 21)];
    }
    return _yesterdayEarningsLabel;
}

-(UIImageView *)seeNumberButton{
    if (!_seeNumberButton) {
        _seeNumberButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_blue_eyes_unwrap, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 323, 98, 42, 35)];
        _seeNumberButton.contentMode = UIViewContentModeCenter;
    }
    return _seeNumberButton;
}

-(void)setSeeNumberBOOL:(BOOL)seeNumberBOOL{
    _seeNumberBOOL = seeNumberBOOL;
    if (seeNumberBOOL) {
        self.seeNumberButton.image = [UIImage imageNamed:icon_blue_eyes_unwrap];
        self.keyonMoneyLabel.text = self.mywithdrawsModel.keyong.length == 0 ? @"0" : self.mywithdrawsModel.keyong;
        self.allEarningsLabel.text = self.mywithdrawsModel.zongshouyi.length == 0 ? @"0" : self.mywithdrawsModel.zongshouyi;
        self.yesterdayEarningsLabel.text = self.mywithdrawsModel.balance == 0 ? @"+0" : [NSString stringWithFormat:@"+%@", self.mywithdrawsModel.balance];
        self.withdrawalMoneyLabel.text = self.mywithdrawsModel.withdrawalAmount.length == 0 ? @"0" : self.mywithdrawsModel.withdrawalAmount;
    }else{
        self.seeNumberButton.image = [UIImage imageNamed:icon_blue_eyes_Shutdown];
        self.keyonMoneyLabel.text = @"****";
        self.allEarningsLabel.text = @"****";
        self.yesterdayEarningsLabel.text = @"****";
        self.withdrawalMoneyLabel.text = @"****";
    }
}

@end
