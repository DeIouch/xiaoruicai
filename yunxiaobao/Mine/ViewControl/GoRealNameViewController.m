//
//  GoRealNameViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/19.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "GoRealNameViewController.h"

@interface GoRealNameViewController ()

/**
 身份证认证状态
 */
@property(nonatomic, strong)UILabel *idCardCertificationStateLabel;

/**
 支付宝认证状态
 */
@property(nonatomic, strong)UILabel *aliPayCertificationStatelabel;

/**
 去认证身份证
 */
@property(nonatomic, strong)UIImageView *goCertificationIdCardButton;

/**
 去认证支付宝
 */
@property(nonatomic, strong)UIImageView *goCertificationALiPayButton;

/**
 认证头像
 */
@property(nonatomic, strong)UIImageView *iconImageView;

/**
 认证姓名
 */
@property(nonatomic, strong)UILabel *nameLabel;

/**
 身份证信息
 */
@property(nonatomic, strong)UILabel *idCardCertificationInfoLabel;

/**
 支付宝信息
 */
@property(nonatomic, strong)UILabel *aliPayCertificationInfoLabel;

/**
 认证状态图片
 */
@property(nonatomic, strong)UIImageView *certificationStateImageView;

@end

@implementation GoRealNameViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    NSUserDefaults *userInfoDefault = [NSUserDefaults standardUserDefaults];
    self.userInfoModel = [[UserInfoModel alloc]initModelWithDic:[userInfoDefault objectForKey:@"userInfo"]];
    
    self.nameString = self.userInfoModel.user_real_name;
    self.idCardCertificationInfoString = self.userInfoModel.user_idno;
    self.aliPayCertificationInfoString = self.userInfoModel.alipay_account;
    
    if (self.nameString.length > 0 || self.idCardCertificationInfoString.length > 0) {
        self.idCardCertificationStateBOOL = YES;
    }else{
        self.idCardCertificationStateBOOL = NO;
    }
    
    if (self.aliPayCertificationInfoString.length > 0) {
        self.aliPayCertificationStateBOOL = YES;
    }else{
        self.aliPayCertificationStateBOOL = NO;
    }
    
    if (self.aliPayCertificationStateBOOL || self.idCardCertificationStateBOOL) {
        self.certificationStateImageView.image = [UIImage imageNamed:icon_yrz];
    }else{
        self.certificationStateImageView.image = [UIImage imageNamed:icon_wrz];
        self.iconImageView.image = [UIImage imageNamed:icon_renzheng_touxiang];
        self.nameString = @"小睿财";
    }
    
    if (self.userInfoModel.user_head_img_path.length > 0) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfoModel.user_head_img_path] placeholderImage:[UIImage imageNamed:icon_renzheng_touxiang]];
    }else{
        self.iconImageView.image = [UIImage imageNamed:icon_renzheng_touxiang];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"实名认证";
}

-(void)createUI{
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(bg_renzhen, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 95, 345, 200)];
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_anquan, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 40, 260, 11, 13)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"个人隐私信息安全保障中", 1, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 56, 261, 200, 12)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 408, 375, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 503, 375, 1)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"身份证认证", 1, 51, 51, 51, 1, 255, 255, 255, 2, 17, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 70, 342, 150, 17)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"支付宝认证", 1, 51, 51, 51, 1, 255, 255, 255, 2, 17, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 70, 436, 150, 17)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"完善身份信息，体验更多服务", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 69, 369, 200, 12)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"完善支付信息，享受便捷服务", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 69, 465, 200, 12)];
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_renzhen_shenfen, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 340, 44, 44)];
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_renzhen_zfb, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 434, 44, 44)];
    
//    self.iconImageView.image = [UIImage imageNamed:icon_renzheng_touxiang];
}

-(void)goCertificationIdCard{
    if (self.idCardCertificationStateBOOL) {
        [self pushViewControl:@"IdCardCertificationResultViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_real_name, @"userNameString", self.userInfoModel.user_idno, @"idCardString", nil]];
    }else{
        [self pushViewControl:@"IdCardCertificationViewController" propertyDic:nil];
    }
}

-(void)goCertificationALiPay{
    if (self.aliPayCertificationStateBOOL) {
        [self pushViewControl:@"ALiPayCertificationResultViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.alipay_name, @"alipayNameString", self.userInfoModel.alipay_account, @"alipayAccountString", nil]];
    }else{
        [self pushViewControl:@"ALiPayCertificationViewController" propertyDic:nil];
    }
}

-(UILabel *)idCardCertificationStateLabel{
    if (!_idCardCertificationStateLabel) {
        _idCardCertificationStateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 153, 153, 153, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 355, 145, 15)];
    }
    return _idCardCertificationStateLabel;
}

-(UILabel *)aliPayCertificationStatelabel{
    if (!_aliPayCertificationStatelabel) {
        _aliPayCertificationStatelabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 153, 153, 153, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 449, 145, 15)];
    }
    return _aliPayCertificationStatelabel;
}

-(UIImageView *)goCertificationIdCardButton{
    if (!_goCertificationIdCardButton) {
        _goCertificationIdCardButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 342, 345, 27, 33)];
        _goCertificationIdCardButton.contentMode = UIViewContentModeCenter;
    }
    return _goCertificationIdCardButton;
}

-(UIImageView *)goCertificationALiPayButton{
    if (!_goCertificationALiPayButton) {
        _goCertificationALiPayButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 342, 440, 27, 33)];
        _goCertificationALiPayButton.contentMode = UIViewContentModeCenter;
    }
    return _goCertificationALiPayButton;
}

-(void)setIdCardCertificationStateBOOL:(BOOL)idCardCertificationStateBOOL{
    _idCardCertificationStateBOOL = idCardCertificationStateBOOL;
    if (idCardCertificationStateBOOL) {
        self.idCardCertificationStateLabel.text = @"已认证";
        [self.goCertificationIdCardButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goCertificationIdCard)]];
        self.idCardCertificationInfoLabel.text = self.idCardCertificationInfoString;
    }else{
        self.idCardCertificationStateLabel.text = @"未认证";
        [self.goCertificationIdCardButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goCertificationIdCard)]];
        self.idCardCertificationInfoLabel.text = @"认证身份证信息";
    }
}

-(void)setAliPayCertificationStateBOOL:(BOOL)aliPayCertificationStateBOOL{
    _aliPayCertificationStateBOOL = aliPayCertificationStateBOOL;
    if (aliPayCertificationStateBOOL) {
        self.aliPayCertificationStatelabel.text = @"已认证";
//        self.goCertificationALiPayButton.userInteractionEnabled = YES;
        [self.goCertificationALiPayButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goCertificationALiPay)]];
        self.aliPayCertificationInfoLabel.text = self.aliPayCertificationInfoString;
    }else{
        self.aliPayCertificationStatelabel.text = @"未认证";
        [self.goCertificationALiPayButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goCertificationALiPay)]];
        self.aliPayCertificationInfoLabel.text = @"绑定支付宝账号";
    }
}

-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 150, 72, 77, 84)];
    }
    return _iconImageView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 21, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 40, 163, 60, 20)];
    }
    return _nameLabel;
}

-(UILabel *)idCardCertificationInfoLabel{
    if (!_idCardCertificationInfoLabel) {
        _idCardCertificationInfoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 40, 199, 385, 16)];
    }
    return _idCardCertificationInfoLabel;
}

-(UILabel *)aliPayCertificationInfoLabel{
    if (!_aliPayCertificationInfoLabel) {
        _aliPayCertificationInfoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 40, 227, 385, 16)];
    }
    return _aliPayCertificationInfoLabel;
}

-(UIImageView *)certificationStateImageView{
    if (!_certificationStateImageView) {
        _certificationStateImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 112, 165, 49, 16)];
    }
    return _certificationStateImageView;
}

-(void)setIconString:(NSString *)iconString{
    _iconString = iconString;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconString]];
}

-(void)setNameString:(NSString *)nameString{
    _nameString = nameString;
    if (nameString.length > 0) {
        self.nameLabel.text = nameString;
        self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, [DelouchLibrary sizeWithText:nameString withFont:21].width, self.nameLabel.frame.size.height);
        self.certificationStateImageView.frame = CGRectMake(self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width + 5 * self.baseicFloat, self.certificationStateImageView.frame.origin.y, 49 * self.baseicFloat, 16 * self.baseicFloat);
    }else{
        self.nameLabel.text = @"小睿财";
        self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, [DelouchLibrary sizeWithText:@"小睿财" withFont:21].width, self.nameLabel.frame.size.height);
        self.certificationStateImageView.frame = CGRectMake(self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width + 5 * self.baseicFloat, self.certificationStateImageView.frame.origin.y, 49 * self.baseicFloat, 16 * self.baseicFloat);
    }
}

-(void)setIdCardCertificationInfoString:(NSString *)idCardCertificationInfoString{
    _idCardCertificationInfoString = idCardCertificationInfoString;
//    self.idCardCertificationInfoLabel.text = idCardCertificationInfoString;
}

-(void)setAliPayCertificationInfoString:(NSString *)aliPayCertificationInfoString{
    _aliPayCertificationInfoString = aliPayCertificationInfoString;
//    self.aliPayCertificationInfoLabel.text = aliPayCertificationInfoString;
}

@end
