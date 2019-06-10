//
//  MineViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/10.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

/**
 设置按钮
 */
@property(nonatomic, strong)UIImageView *setButton;

/**
 用户头像
 */
@property(nonatomic, strong)UIImageView *userIconImageView;

/**
 用户昵称
 */
@property(nonatomic, strong)UILabel *nickNameLabel;

/**
 用户手机号码
 */
@property(nonatomic, strong)UILabel *userPhoneLabel;

/**
 我的二维码
 */
@property(nonatomic, strong)UIImageView *myQrCodeButton;

/**
 可用余额
 */
@property(nonatomic, strong)UILabel *availableBalanceLabel;

/**
 总收益
 */
@property(nonatomic, strong)UILabel *totalRevenueLabel;

/**
 昨日收益
 */
@property(nonatomic, strong)UILabel *earningsYesterdayLabel;

/**
 是否可见
 */
@property(nonatomic, strong)UIImageView *seeNumberButton;

/**
 vip信息
 */
@property(nonatomic, strong)UIImageView *vipInfoImageView;

/**
 vipt标示
 */
@property(nonatomic, strong)UIImageView *vipiconImageView;

/**
 vip到期时间
 */
@property(nonatomic, strong)UILabel *vipEndTimeLabel;

/**
 实名按钮
 */
@property(nonatomic, strong)UIButton *realNameButton;

/**
 实名状态
 */
@property(nonatomic, strong)UILabel *realNameStateLabel;

/**
 pos订单管理
 */
@property(nonatomic, strong)UIButton *posOrderManageButton;

/**
 客服服务
 */
@property(nonatomic, strong)UIButton *serviceButton;

/**
 余额是否显示
 */
@property(nonatomic, assign)BOOL isShowMoneyBOOL;

/**
 余额信息
 */
@property(nonatomic, strong)MywithdrawsModel *mywithdrawsModel;

@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getMoneyInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    //  有颜色渐变
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(108, 141, 254, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameNotChange, 0, 0, DelouchWidth, 148 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"我的", 1, 255, 255, 255, 1, 255, 255, 255, 2, 22, NO, self.headview) setFrame:DelouchFrameMake(FrameHeadView, 15, 31, 140, 23)];
    self.headview.backgroundColor = [UIColor colorWithRed:108 / 255.0 green:141 / 255.0 blue:254 / 255.0 alpha:1];
    
    self.headview.leftButton.hidden = YES;
    self.headview.lineView.hidden = YES;
    
    //  有阴影
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15 * self.baseicFloat, 98 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 345 * self.baseicFloat, 150 * self.baseicFloat)];
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.07].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,-1);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 9;
    view.layer.cornerRadius = 4 * self.baseicFloat;
    [self.view addSubview:view];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goWithdrawal)]];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 190, 253, 1, 40)];
    
    [self.setButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setVC)]];
    
    [self.userIconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectIconVC)]];
    
    [self.myQrCodeButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myQrCodeVC)]];
    
    self.nickNameLabel.text = self.userInfoModel.user_name;
    self.userPhoneLabel.text = self.userInfoModel.phone;
    [self.vipInfoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(vipInfoVC)]];
    self.vipiconImageView.image = [UIImage imageNamed:icon_vip];
    
    self.vipEndTimeLabel.text = @"2019.4.25体验到期";
    if (self.userInfoModel.user_idno.length > 0 || self.userInfoModel.user_real_name.length > 0 || self.userInfoModel.alipay_account.length > 0 || self.userInfoModel.alipay_name.length > 0) {
        self.realNameStateLabel.text = @"已实名";
    }else{
        self.realNameStateLabel.text = @"未实名";
    }
    [self.realNameButton addTarget:self action:@selector(realNameVC) forControlEvents:UIControlEventTouchUpInside];
    [self.posOrderManageButton addTarget:self action:@selector(posOrderManageVC) forControlEvents:UIControlEventTouchUpInside];
    [self.serviceButton addTarget:self action:@selector(serviceVC) forControlEvents:UIControlEventTouchUpInside];
    [self.seeNumberButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeNumber)]];
    self.isShowMoneyBOOL = NO;
//    [self getMoneyInfo];
    
    [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfoModel.user_head_img_path] placeholderImage:[UIImage imageNamed:icon_heads]];
    self.nickNameLabel.text = self.userInfoModel.user_name;
    
    [[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:@"userInfo" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

-(void)getMoneyInfo{
    [self urlHeadStr:AppInfoURL urlStr:UrlMywithdraws parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"id", nil] Success:^(NSDictionary *obj) {
        if ([obj[@"result"] isKindOfClass:[NSDictionary class]]) {
            self.mywithdrawsModel = [[MywithdrawsModel alloc]initModelWithDic:obj[@"result"]];
        }
    }];
}

-(void)goWithdrawal{
    if (self.userInfoModel.alipay_account.length == 0) {
        [self pushViewControl:@"WithdrawalViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.mywithdrawsModel, @"mywithdrawsModel", nil]];
    }else{
        [self pushViewControl:@"WithdrawalNoRealNameViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.mywithdrawsModel, @"mywithdrawsModel", nil]];
    }
}

#pragma mark 进入设置页面
-(void)setVC{
    [self pushViewControl:@"MineSetViewController" propertyDic:nil];
}

#pragma mark 是否显示余额
-(void)seeNumber{
    self.isShowMoneyBOOL = !self.isShowMoneyBOOL;
}

#pragma mark 进入用户详情
-(void)selectIconVC{
    [self pushViewControl:@"UserInfoViewController" propertyDic:nil];
}

#pragma mark 我的二维码
-(void)myQrCodeVC{
    [self pushViewControl:@"MyShareQrcodeViewController" propertyDic:nil];
}

#pragma mark vip特权
-(void)vipInfoVC{
    [self pushViewControl:@"MemberInfoViewController" propertyDic:nil];
}

#pragma mark 实名验证
-(void)realNameVC{
    [self pushViewControl:@"GoRealNameViewController" propertyDic:nil];
}

#pragma mark pos订单管理
-(void)posOrderManageVC{
    [self pushViewControl:@"MinePosBuyListViewController" propertyDic:nil];
}

#pragma mark 客户服务
-(void)serviceVC{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"111111"] options:@{} completionHandler:nil];
//    UIWebView *webView = [[UIWebView alloc]init];
//    NSURL *url = [NSURL URLWithString:@"111111"];
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
//    [self.view addSubview:webView];
    
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4008097378"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}


















-(UIImageView *)userIconImageView{
    if (!_userIconImageView) {
        _userIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_heads, YES, 29, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 79, 58, 58)];
    }
    return _userIconImageView;
}

-(UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 17, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 88, 90, 200, 17)];
    }
    return _nickNameLabel;
}

-(UILabel *)userPhoneLabel{
    if (!_userPhoneLabel) {
        _userPhoneLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 254, 254, 254, 0.8, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 88, 115, 200, 13)];
    }
    return _userPhoneLabel;
}

-(UIImageView *)myQrCodeButton{
    if (!_myQrCodeButton) {
        _myQrCodeButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_Qr_code, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 308, 87, 22, 22)];
        _myQrCodeButton.contentMode = UIViewContentModeCenter;
    }
    return _myQrCodeButton;
}

-(UIImageView *)setButton{
    if (!_setButton) {
        _setButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_setup, NO, 0, self.view) setFrame:DelouchFrameMake(FrameHeadView, 328, 24, 30, 28)];
        _setButton.contentMode = UIViewContentModeCenter;
    }
    return _setButton;
}

-(UILabel *)availableBalanceLabel{
    if (!_availableBalanceLabel) {
        _availableBalanceLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 21, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 218, 200, 20)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"可用余额(元)", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 187, 100, 14)];
    }
    return _availableBalanceLabel;
}

-(UILabel *)totalRevenueLabel{
    if (!_totalRevenueLabel) {
        _totalRevenueLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 276, 150, 16)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"总收益(元)", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 255, 100, 14)];
    }
    return _totalRevenueLabel;
}

-(UILabel *)earningsYesterdayLabel{
    if (!_earningsYesterdayLabel) {
        _earningsYesterdayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 68, 32, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 206, 276, 100, 16)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"昨日收益", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 206, 255, 100, 14)];
    }
    return _earningsYesterdayLabel;
}

-(UIImageView *)seeNumberButton{
    if (!_seeNumberButton) {
        _seeNumberButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_eyes_Shut_down, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 309, 206, 32, 25)];
        _seeNumberButton.contentMode = UIViewContentModeCenter;
    }
    return _seeNumberButton;
}

-(UIImageView *)vipInfoImageView{
    if (!_vipInfoImageView) {
        _vipInfoImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(bg_vip_my, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 332, 375, 63)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"会员特权", 1, 232, 226, 195, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 73, 347, 80, 14)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"查看详情", 3, 255, 255, 255, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 267, 357, 65, 14)];
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 338, 358, 6, 11)];
    }
    return _vipInfoImageView;
}

-(UIImageView *)vipiconImageView{
    if (!_vipiconImageView) {
        _vipiconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_vip, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 35, 348, 33, 14)];
    }
    return _vipiconImageView;
}

-(UIButton *)realNameButton{
    if (!_realNameButton) {
        _realNameButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"", 1, 255, 255, 255, 0, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 419, 375, 40)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_Real_name, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 17, 429, 17, 20)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 353, 435, 6, 9)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"实名认证", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 53, 431, 120, 16)];
    }
    return _realNameButton;
}

-(UILabel *)realNameStateLabel{
    if (!_realNameStateLabel) {
        _realNameStateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"未实名", 3, 153, 153, 153, 1, 255, 255, 255, 2, 13, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 270, 422, 67, 33)];
    }
    return _realNameStateLabel;
}

-(UIButton *)posOrderManageButton{
    if (!_posOrderManageButton) {
        _posOrderManageButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"", 1, 255, 255, 255, 0, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 469, 375, 40)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_POS_orders, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 17, 479, 16, 19)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 353, 485, 6, 9)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"POS订单管理", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 53, 481, 120, 16)];
    }
    return _posOrderManageButton;
}

-(UIButton *)serviceButton{
    if (!_serviceButton) {
        _serviceButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"", 1, 255, 255, 255, 0, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 519, 425, 40)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_service, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 16, 529, 19, 19)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 353, 540, 6, 9)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"客服服务", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 53, 531, 120, 16)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"400-809-7378", 3, 153, 153, 153, 1, 255, 255, 255, 2, 13, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 210, 527, 127, 33)];
    }
    return _serviceButton;
}

-(UILabel *)vipEndTimeLabel{
    if (!_vipEndTimeLabel) {
        _vipEndTimeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 10, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 36, 371, 150, 10)];
    }
    return _vipEndTimeLabel;
}

-(void)setIsShowMoneyBOOL:(BOOL)isShowMoneyBOOL{
    _isShowMoneyBOOL = isShowMoneyBOOL;
    if (isShowMoneyBOOL) {
        self.availableBalanceLabel.text = self.mywithdrawsModel.keyong.length == 0 ? @"0" : self.mywithdrawsModel.keyong;
        self.totalRevenueLabel.text = self.mywithdrawsModel.zongshouyi.length == 0 ? @"0" : self.mywithdrawsModel.zongshouyi;
        self.earningsYesterdayLabel.text = self.mywithdrawsModel.balance == 0 ? @"+0" : [NSString stringWithFormat:@"+%@", self.mywithdrawsModel.balance];
        self.seeNumberButton.image = [UIImage imageNamed:icon_eyes_unwrap];
    }else{
        self.totalRevenueLabel.text = @"****";
        self.availableBalanceLabel.text = @"****";
        self.earningsYesterdayLabel.text = @"****";
        self.seeNumberButton.image = [UIImage imageNamed:icon_eyes_Shut_down];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"userInfo"]) {
        NSUserDefaults *userInfoDefault = [NSUserDefaults standardUserDefaults];
        self.userInfoModel = [[UserInfoModel alloc]initModelWithDic:[userInfoDefault objectForKey:@"userInfo"]];
        [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfoModel.user_head_img_path] placeholderImage:[UIImage imageNamed:icon_heads]];
        self.nickNameLabel.text = self.userInfoModel.user_name;
        
        if (self.userInfoModel.alipay_account.length > 0 || self.userInfoModel.user_idno.length > 0) {
            self.realNameStateLabel.text = @"已实名";
        }
    }
}

-(void)dealloc{
    [[NSUserDefaults standardUserDefaults] removeObserver:self forKeyPath:@"userInfo"];
}

@end
