//
//  SetIntelligentPlanViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "SetIntelligentPlanViewController.h"
#import "SelectOperationTypeView.h"
#import "AppQueryMealSettingsListModel.h"

@interface SetIntelligentPlanViewController ()<SelectOperationTypeDelegate, MoxieSDKDelegate>

/**
 选择收费基数
 */
@property(nonatomic, strong)UIImageView *selectChargBaseButton;

/**
 银行卡头像
 */
@property(nonatomic, strong)UIImageView *bankIconImageView;

/**
 银行背景图片
 */
@property(nonatomic, strong)UIImageView *bankBackImageView;

/**
 选择套餐
 */
@property(nonatomic, strong)UIImageView *selectPackageButton;

/**
 下一步
 */
@property(nonatomic, strong)UIButton *nextStepButton;

/**
 银行卡信息
 */
@property(nonatomic, strong)UILabel *bankInfoLabel;

/**
 本期应还
 */
@property(nonatomic, strong)UITextField *shouldAlsoTextField;

/**
 银行卡名字
 */
@property(nonatomic, strong)UILabel *bankNameLabel;

/**
 类型选择view
 */
@property(nonatomic, strong)SelectOperationTypeView *selectOperationTypeView;

/**
 选择的类型
 */
@property(nonatomic, assign)NSInteger chooseType;

/**
 套餐
 */
@property(nonatomic, strong)NSMutableArray *packageArray;

/**
 收费基数
 */
@property(nonatomic, strong)NSMutableArray *baseMoneyArray;

/**
 选择收费基数
 */
@property(nonatomic, strong)UILabel *baseMoneyLabel;

/**
 选择套餐
 */
@property(nonatomic, strong)UILabel *packageLabel;

/**
 选择收费基数
 */
@property(nonatomic, strong)NSString *baseMoneyString;

/**
 选择套餐
 */
@property(nonatomic, strong)NSString *packageString;

/**
 网银账单校对
 */
@property(nonatomic, strong)UIImageView *billProofreadingImageView;

/**
 可用额度
 */
@property(nonatomic, strong)UITextField *availableCreditTextField;

@end

@implementation SetIntelligentPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"设置智能规划";
        
    self.bankBackImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@750x144.png", self.needToPlanModel.card_bank]];
    
    self.bankIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@80.png", self.needToPlanModel.card_bank]];
    
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 209, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 263, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 318, 360, 1)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"本期应还", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 171, 90, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"可用额度", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 225, 90, 15)];
    
    self.availableCreditTextField.text = self.needToPlanModel.card_usable_amount;
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"收费基数", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 279, 90, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"套餐", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 333, 90, 15)];
    
    self.shouldAlsoTextField.text = [NSString stringWithFormat:@"%0.2f", [self.needToPlanModel.card_current_bill_return_amount floatValue]];
    
    switch ([self.needToPlanModel.card_pay_base_amount_type intValue]) {
        case 1:
            self.baseMoneyLabel.text = @"总信用额度";
            self.baseMoneyString = @"1";
            break;
            
        case 2:
            self.baseMoneyLabel.text = @"总应还款金额";
            self.baseMoneyString = @"2";
            break;
            
        case 3:
            self.baseMoneyLabel.text = self.needToPlanModel.card_pay_base_amount;
            self.baseMoneyString = @"3";
            break;
            
        default:
            break;
    }
    self.packageLabel.text = self.needToPlanModel.meal_name;
    self.packageString = self.needToPlanModel.card_meal_id;
    
    self.packageLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
    UIView *notiView = [[UIView alloc] initWithFrame:CGRectMake(15 * self.baseicFloat,318 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight,345 * self.baseicFloat,200 * self.baseicFloat)];
    notiView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    notiView.layer.shadowColor = [UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:0.1].CGColor;
    notiView.layer.shadowOffset = CGSizeMake(0,2);
    notiView.layer.shadowOpacity = 1;
    notiView.layer.shadowRadius = 15;
    notiView.layer.cornerRadius = 5;
    [self.view addSubview:notiView];
    
    self.packageArray = [[NSMutableArray alloc]init];
    self.baseMoneyArray = [[NSMutableArray alloc]init];
    
    UILabel *notiLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"为了避免个人漏操作，导致卡片应还金额与可用余额与系统记录数据不符，建议进行金额校对，可采用网银或者邮箱账单方式。", 1, 6, 14, 41, 0.6, 255, 255, 255, 1, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 32, 406, 311, 48)];
    notiLabel.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:notiLabel.text];
    NSTextAttachment *attchment = [[NSTextAttachment alloc]init];
    attchment.bounds = CGRectMake(0, 0, 10 * self.baseicFloat, 12 * self.baseicFloat);//设置frame
    attchment.image = [UIImage imageNamed:icon_message];//设置图片
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(attchment)];
    [attributedString insertAttributedString:string atIndex:0];//插入到第几个下标
    notiLabel.attributedText = attributedString;
    
    [self.billProofreadingImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(billProofreading)]];
    
    [self.selectChargBaseButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectChargBase)]];
    [self.selectPackageButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectPackage)]];
    [self.nextStepButton addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    
    self.bankNameLabel.text = self.needToPlanModel.card_bank;
    self.bankInfoLabel.text = [NSString stringWithFormat:@"%@ %@", self.needToPlanModel.card_web_user_name, [self.needToPlanModel.card_no substringWithRange:NSMakeRange(self.needToPlanModel.card_no.length - 4, 4)]];
    
    [self urlHeadStr:AppCardPlanURL urlStr:UrlCreatePlanFirst parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.needToPlanModel.card_id, @"card_id", nil] Success:^(NSDictionary *obj) {
        for (NSDictionary *dic in obj[@"result"][@"mealSettings"]) {
            [self.packageArray addObject:[[AppQueryMealSettingsListModel alloc]initModelWithDic:dic]];
        }
        for (NSDictionary *dic in obj[@"result"][@"chargeTypeList"]) {
            [self.baseMoneyArray addObject:dic];
        }
    }];
    [MoxieSDK shared].apiKey = MXApiKey;
    [MoxieSDK shared].fromController = self;
    [MoxieSDK shared].delegate = self;
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if (![self.baseMoneyString isEqualToString:@"3"]) {
//        textField.text = [textField.text stringByReplacingOccurrencesOfString:string withString:@""];
//    }
//    return YES;
//}

-(void)receiveMoxieSDKResult:(NSDictionary *)resultDictionary{
    //任务结果code，详细参考文档
    int code = [resultDictionary[@"code"] intValue];
    //是否登录成功
    BOOL loginDone = [resultDictionary[@"loginDone"] boolValue];
    //任务类型
    NSString *taskType = resultDictionary[@"taskType"];
    //任务Id
    NSString *taskId = resultDictionary[@"taskId"];
    //描述
    NSString *message = resultDictionary[@"message"];
    //当前账号
    NSString *account = resultDictionary[@"account"];
    //用户在该业务平台上的userId，例如支付宝上的userId（目前支付宝，淘宝，京东支持）
    NSString *businessUserId = resultDictionary[@"businessUserId"]?resultDictionary[@"businessUserId"]:@"";
    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,message:%@,account:%@,loginDone:%d，businessUserId:%@",code,taskType,taskId,message,account,loginDone,businessUserId);
    //【登录中】假如code是2且loginDone为false，表示正在登录中
    if(code == 2 && loginDone == false){
        NSLog(@"任务正在登录中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集中】假如code是2且loginDone为true，已经登录成功，正在采集中
    else if(code == 2 && loginDone == true){
        NSLog(@"任务已经登录成功，正在采集中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集成功】假如code是1则采集成功（不代表回调成功）
    else if(code == 1){
        NSLog(@"任务采集成功，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
        self.notiString = @"任务采集成功";
    }
    //【未登录】假如code是-1则用户未登录
    else if(code == -1){
        NSLog(@"用户未登录");
//        self.notiString = @"用户未登录";
    }
    //【任务失败】该任务按失败处理，可能的code为0，-2，-3，-4
    else{
        NSLog(@"任务失败");
        self.notiString = @"任务失败";
    }
}

-(void)billProofreading{
    [MoxieSDK shared].userId = [NSString stringWithFormat:@"K%@", self.needToPlanModel.card_id];
    [MoxieSDK shared].taskType = @"bank";
    [[MoxieSDK shared] start];
}

-(UILabel *)baseMoneyLabel{
    if (!_baseMoneyLabel) {
        _baseMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"选择收费基数", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 279, 145, 15)];
    }
    return _baseMoneyLabel;
}

-(UILabel *)packageLabel{
    if (!_packageLabel) {
        _packageLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"选择套餐", 3, 153, 153, 153, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 333, 145, 15)];
    }
    return _packageLabel;
}

- (void)didSelectTypeAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.chooseType) {
        case 1:
            {
                self.baseMoneyLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
                switch ([self.baseMoneyArray[indexPath.row][@"value"] intValue]) {
                    case 3:
                        {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入自定义金额" message:nil preferredStyle:UIAlertControllerStyleAlert];
                            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                                textField.placeholder = @"请输入自定义金额";
                            }];
                            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                UITextField *textfield = alertController.textFields[0];
                                if (textfield.text.length == 0) {
                                    self.notiString = @"金额不能为空";
                                }else{
                                    self.baseMoneyString = self.baseMoneyArray[indexPath.row][@"value"];
                                    self.baseMoneyLabel.text = textfield.text;
                                }
                            }];
                            [alertController addAction:action];
                            UIAlertAction *actiona = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            }];
                            [alertController addAction:actiona];
                            [self presentViewController:alertController animated:YES completion:nil];
                        }
                        break;
                        
                    default:
                        {
                            self.baseMoneyLabel.text = self.baseMoneyArray[indexPath.row][@"desc"];
                            self.baseMoneyString = self.baseMoneyArray[indexPath.row][@"value"];
                        }
                        break;
                }
            }
            break;
            
        case 2:
            {
                AppQueryMealSettingsListModel *model = self.packageArray[indexPath.row];
                self.packageLabel.text = model.meal_name;
                self.packageString = model.package_id;
                self.packageLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
            }
            break;
            
        default:
            break;
    }
}

-(void)selectChargBase{
    self.chooseType = 1;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.baseMoneyArray) {
        [array addObject:dic[@"desc"]];
    }
    self.selectOperationTypeView.titleString = @"收费基数选择";
    self.selectOperationTypeView.typeArray = array;
    self.selectOperationTypeView.hidden = NO;
}

-(void)selectPackage{
    self.chooseType = 2;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (AppQueryMealSettingsListModel *model in self.packageArray) {
        [array addObject:model.meal_name];
    }
    self.selectOperationTypeView.titleString = @"套餐选择";
    self.selectOperationTypeView.typeArray = array;
    self.selectOperationTypeView.hidden = NO;
}

-(void)nextStep{
    if ([self.baseMoneyLabel.text isEqualToString:@"选择收费基数"] || [self.packageLabel.text isEqualToString:@"选择套餐"] || self.availableCreditTextField.text.length == 0) {
        self.notiString = @"请先填写好资料";
    }else{
        [self pushViewControl:@"SetintelligentPlanInfoViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.baseMoneyString, @"baseMoneyString", self.packageString, @"packageString", self.needToPlanModel, @"needToPlanModel", self.availableCreditTextField.text, @"availableCreditString", self.shouldAlsoTextField.text, @"shouldAlsoString", self.baseMoneyLabel.text, @"baseMoneyNumberString", nil]];
    }
}

-(UIImageView *)selectChargBaseButton{
    if (!_selectChargBaseButton) {
        _selectChargBaseButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 342, 270, 27, 32)];
        _selectChargBaseButton.contentMode = UIViewContentModeCenter;
    }
    return _selectChargBaseButton;
}

-(UIImageView *)selectPackageButton{
    if (!_selectPackageButton) {
        _selectPackageButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 342, 324, 27, 32)];
        _selectPackageButton.contentMode = UIViewContentModeCenter;
    }
    return _selectPackageButton;
}

-(UIButton *)nextStepButton{
    if (!_nextStepButton) {
        _nextStepButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"下一步", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameCellView, 15, 612, 345, 44)];
        [self setbuttonLayer:_nextStepButton layerMask:3];
    }
    return _nextStepButton;
}

-(UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 25, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 72, 97, 200, 14)];
    }
    return _bankNameLabel;
}

-(UILabel *)bankInfoLabel{
    if (!_bankInfoLabel) {
        _bankInfoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 10, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 72, 115, 200, 10)];
    }
    return _bankInfoLabel;
}

-(SelectOperationTypeView *)selectOperationTypeView{
    if (!_selectOperationTypeView) {
        _selectOperationTypeView = [[SelectOperationTypeView alloc]init];
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (AppQueryMealSettingsListModel *model in self.dataArray) {
            [array addObject:model.meal_name];
        }
        _selectOperationTypeView.titleString = @"套餐选择";
        _selectOperationTypeView.typeArray = array;
        _selectOperationTypeView.delegate = self;
        [self.view addSubview:_selectOperationTypeView];
    }
    return _selectOperationTypeView;
}

-(UITextField *)shouldAlsoTextField{
    if (!_shouldAlsoTextField) {
        _shouldAlsoTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 160, 200, 36)];
    }
    return _shouldAlsoTextField;
}

-(UIImageView *)billProofreadingImageView{
    if (!_billProofreadingImageView) {
        _billProofreadingImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_wyzdjd, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 118, 472, 140, 100)];
    }
    return _billProofreadingImageView;
}


-(UITextField *)availableCreditTextField{
    if (!_availableCreditTextField) {
        _availableCreditTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 215, 190, 35)];
    }
    return _availableCreditTextField;
}

-(UIImageView *)bankIconImageView{
    if (!_bankIconImageView) {
        _bankIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 94, 32, 32)];
    }
    return _bankIconImageView;
}

-(UIImageView *)bankBackImageView{
    if (!_bankBackImageView) {
        _bankBackImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(bg_vip_my, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 74, 375, 72)];
    }
    return _bankBackImageView;
}

@end
