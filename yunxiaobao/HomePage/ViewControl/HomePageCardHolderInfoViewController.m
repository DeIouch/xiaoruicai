//
//  HomePageCardHolderInfoViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageCardHolderInfoViewController.h"

@interface HomePageCardHolderInfoViewController ()

/**
 持卡人
 */
@property(nonatomic, strong)UITextField *nameTextField;

/**
 手机号
 */
@property(nonatomic, strong)UITextField *phoneTextField;

/**
 身份证号
 */
@property(nonatomic, strong)UITextField *idNumberTextField;

/**
 保存银行卡信息
 */
@property(nonatomic, strong)UIButton *saveCardInfoButton;

/**
 信用卡数量
 */
@property(nonatomic, strong)UILabel *cardnumberLabel;

/**
 查看所有信用卡信息
 */
@property(nonatomic, strong)UIImageView *seeCardInfoImageView;

@end

@implementation HomePageCardHolderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"持卡人信息";
    
    self.rightImageString = icon_blackMoreDian;
    
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 74, 375, 192)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 136, 360, 2)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 200, 360, 2)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"持卡人", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 99, 90, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"手机号", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 163, 90, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"身份证号", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 227, 90, 15)];
    
    self.nameTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"输入持卡人姓名", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 99, 252, 15)];
    self.nameTextField.userInteractionEnabled = NO;
    
    self.phoneTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"输入持卡人手机号码", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 163, 252, 15)];
    
    self.idNumberTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"输入持卡人姓名", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 227, 252, 15)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 276, 375, 64)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"信用卡信息", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 301, 190, 15)];
    
    self.saveCardInfoButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"保存", 2, 255, 255, 255, 1, 86, 112, 254, 1, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 380, 345, 48)];
    [self setbuttonLayer:self.saveCardInfoButton layerMask:5];
    
    [self.saveCardInfoButton addTarget:self action:@selector(saveCardInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.seeCardInfoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeCardInfo)]];
    self.cardnumberLabel.text = [NSString stringWithFormat:@"%@张卡",self.appCustomersListModel.cards_num];
    self.nameTextField.text = self.appCustomersListModel.credit_real_name;
    self.phoneTextField.text = self.appCustomersListModel.contact_phone;
    self.idNumberTextField.text = self.appCustomersListModel.id_no;
}

-(void)rightSelect{
    __weak typeof(self) weakSelf = self;
    [[HEMenu shareManager] showPopMenuSelecteWithFrameWidth:165 height:160 point:CGPointMake(DelouchWidth - 25, 5) item:@[@"删除此持卡人"] imgSource:@[icon_delete_card] action:^(NSInteger index) {
        [weakSelf deleteNoti];
    }];
}

-(void)deleteNoti{
    UIAlertController *deleteAlert=[UIAlertController
                                  alertControllerWithTitle: nil
                                  message:@"是否删除此持卡人，删除后相关信息无法恢复"
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
    [self urlHeadStr:AppCustomersURL urlStr:UrlAppDeleatCustomers parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.appCustomersListModel.card_id, @"id", self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
        self.notiString = @"删除成功";
        [self popVC];
    }];
}

-(void)saveCardInfo{
    if (self.phoneTextField.text.length != 11 || self.idNumberTextField.text.length != 18) {
        self.notiString = @"请输入正确的信息";
    }else{
        [self urlHeadStr:AppCustomersURL urlStr:UrlUpdateCustomer parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.appCustomersListModel.card_id, @"id", self.idNumberTextField.text, @"id_no", self.phoneTextField.text, @"contact_phone", nil] Success:^(NSDictionary *obj) {
            self.notiString = @"修改成功";
            [self popVC];
        }];
    }
}

-(void)seeCardInfo{
    [self pushViewControl:@"HomePageCardListViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.appCustomersListModel, @"appCustomersListModel", nil]];
}

-(UILabel *)cardnumberLabel{
    if (!_cardnumberLabel) {
        _cardnumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 153, 153, 153, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 285, 301, 61, 15)];
    }
    return _cardnumberLabel;
}

-(UIImageView *)seeCardInfoImageView{
    if (!_seeCardInfoImageView) {
        _seeCardInfoImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 342, 292, 27, 32)];
        _seeCardInfoImageView.contentMode = UIViewContentModeCenter;
    }
    return _seeCardInfoImageView;
}

@end
