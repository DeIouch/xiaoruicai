//
//  CardManageInfoViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CardManageInfoViewController.h"
#import "CardManageBillingDetailsViewController.h"
#import "CardManageRepaymentHistoryViewController.h"
#import "CardManageRecordsConsumptionViewController.h"

@interface CardManageInfoViewController ()<MoxieSDKDelegate>

/**
 银行图片
 */
@property(nonatomic, strong)UIImageView *bankImageView;

/**
 银行图片
 */
@property(nonatomic, strong)NSString *bankIconString;

/**
 银行名称
 */
@property(nonatomic, strong)UILabel *bankNameLabel;

/**
 用户信息
 */
@property(nonatomic, strong)UILabel *userInfoLabel;

/**
 本期应还
 */
@property(nonatomic, strong)UILabel *shouldAlsoMoneyLabel;

/**
 到期时间
 */
@property(nonatomic, strong)UILabel *endTimeLabel;

/**
 总额度
 */
@property(nonatomic, strong)UILabel *totalCombinationLabel;

/**
 还款日
 */
@property(nonatomic, strong)UILabel *reimbursementDayLabel;

/**
 账单明细
 */
@property(nonatomic, strong)UIButton *billingDetailsButton;

/**
 还款记录
 */
@property(nonatomic, strong)UIButton *repaymentHistoryButton;

/**
 消费记录
 */
@property(nonatomic, strong)UIButton *recordsConsumptionButton;

/**
 刷新账单
 */
@property(nonatomic, strong)UIButton *freshBillButton;

/**
 规划账单
 */
@property(nonatomic, strong)UIButton *guihuaButton;

/**
 账单明细VC
 */
@property(nonatomic, strong)CardManageBillingDetailsViewController *billingDetailsVC;

/**
 还款记录VC
 */
@property(nonatomic, strong)CardManageRepaymentHistoryViewController *repaymentHistoryVC;

/**
 消费记录VC
 */
@property(nonatomic, strong)CardManageRecordsConsumptionViewController *recordsConsumptionVC;

@property(nonatomic, strong)UIViewController *currentVC;

/**
 已规划消费
 */
@property(nonatomic, strong)UIView *ConsumptionPlanedView;

/**
 已规划还款
 */
@property(nonatomic, strong)UIView *CeimbursementPlanedView;

/**
 卡财务管理
 */
@property(nonatomic, strong)UIView *FinancialManagementView;

@end

@implementation CardManageInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = self.cardListModel.card_bank;
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
}

-(void)createUI{
    
    self.bankImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@690x296.png", self.cardListModel.card_bank]];
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake([NSString stringWithFormat:@"logo_%@80.png", self.cardListModel.card_bank], NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 94, 32, 32)];
    
    [self.billingDetailsButton addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.repaymentHistoryButton addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.recordsConsumptionButton addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 271, 375, 2)];
    
    [self addChildViewController:self.billingDetailsVC];
    [self.view addSubview:self.billingDetailsVC.view];
    [self.billingDetailsVC didMoveToParentViewController:self];
    self.currentVC = self.billingDetailsVC;
    [self.billingDetailsButton setTitleColor:[UIColor colorWithRed:255 / 255.0 green:68 / 255.0 blue:32 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.billingDetailsButton.titleLabel.font = [UIFont systemFontOfSize:20 * self.baseicFloat];
    
    self.bankNameLabel.text = self.cardListModel.card_bank;
    self.userInfoLabel.text = [NSString stringWithFormat:@"%@ | 尾号 %@", self.cardListModel.credit_real_name, [self.cardListModel.card_no substringWithRange:NSMakeRange(self.cardListModel.card_no.length - 4, 4)]];
    
    self.totalCombinationLabel.text = [NSString stringWithFormat:@"总额度：%@", self.cardListModel.card_original_amount];
    
    [self.ConsumptionPlanedView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ConsumptionPlaned)]];
    
    [self.CeimbursementPlanedView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CeimbursementPlaned)]];
    
    [self.FinancialManagementView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(FinancialManagement)]];
    
    if ([self.cardListModel.card_is_update_bill isEqualToString:@"1"]) {
        [self.freshBillButton addTarget:self action:@selector(freshBill) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.rightImageString = icon_blackMoreDian;
    
    [self getCardInfo];
    
    [MoxieSDK shared].apiKey = MXApiKey;
    [MoxieSDK shared].fromController = self;
    [MoxieSDK shared].delegate = self;
    
    if (![self.cardListModel.card_is_plan isEqualToString:@"1"]) {
        [self.guihuaButton addTarget:self action:@selector(guihua) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)guihua{
    [self pushViewControl:@"SetIntelligentPlanViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel, @"needToPlanModel", nil]];
}

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
//        self.notiString = @"任务采集成功";
        [self urlHeadStr:AppCardsURL urlStr:UrlSynchronizeBill parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel.card_id, @"card_id", nil] Success:^(NSDictionary *obj) {
            self.notiString = @"任务采集成功";
            self.freshBillButton.hidden = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBill" object:nil];
        }];
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

-(void)freshBill{
    [MoxieSDK shared].userId = [NSString stringWithFormat:@"K%@", self.cardListModel.card_id];
    [MoxieSDK shared].taskType = @"bank";
    [[MoxieSDK shared] start];
}

-(void)getCardInfo{
    [self urlHeadStr:AppCardsURL urlStr:UrlCardInfo parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel.card_id, @"cardId", nil] Success:^(NSDictionary *obj) {
        NeedToPlanModel *model = [[NeedToPlanModel alloc]initModelWithDic:obj[@"result"][@"cardData"]];
        
        NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
        [format1 setDateFormat:@"MM-dd"];
        
        NSArray *timeArray = [[format1 stringFromDate:[NSDate date]] componentsSeparatedByString:@"-"];
        
        NSArray *billDayArray = [[self.cardListModel.card_bill_day_str stringByAppendingString:@"日"] componentsSeparatedByString:@"月-"];
        
        NSArray *retureDayArray = [[self.cardListModel.card_bill_return_day_str stringByAppendingString:@"日"] componentsSeparatedByString:@"月-"];
        
        if ([timeArray[0] intValue] < [billDayArray[0] intValue]) {
            self.shouldAlsoMoneyLabel.text = @"--";
            self.endTimeLabel.text = [NSString stringWithFormat:@"本期应还 / %@出账", [[model.card_bill_day_str stringByReplacingOccurrencesOfString:@"月-" withString:@"."] stringByReplacingOccurrencesOfString:@"日" withString:@""]];
        }else if ([timeArray[0] intValue] == [billDayArray[0] intValue] && [timeArray[1] intValue] < [billDayArray[1] intValue]) {
            self.shouldAlsoMoneyLabel.text = @"--";
            self.endTimeLabel.text = [NSString stringWithFormat:@"本期应还 / %@出账", [[model.card_bill_day_str stringByReplacingOccurrencesOfString:@"月-" withString:@"."] stringByReplacingOccurrencesOfString:@"日" withString:@""]];
        }else if ([timeArray[0] intValue] < [retureDayArray[0] intValue]) {
            [DelouchLibrary setMoneyLabel:self.shouldAlsoMoneyLabel moneyText:self.cardListModel.card_current_bill_return_amount bigFont:28 smallFont:14];
            self.endTimeLabel.text = [NSString stringWithFormat:@"本期应还 / %@到期", [[model.card_bill_return_day_str stringByReplacingOccurrencesOfString:@"月-" withString:@"."] stringByReplacingOccurrencesOfString:@"日" withString:@""]];
        }else if ([timeArray[0] intValue] == [retureDayArray[0] intValue] && [timeArray[1] intValue] <= [retureDayArray[1] intValue]) {
            [DelouchLibrary setMoneyLabel:self.shouldAlsoMoneyLabel moneyText:self.cardListModel.card_current_bill_return_amount bigFont:28 smallFont:14];
            self.endTimeLabel.text = [NSString stringWithFormat:@"本期应还 / %@到期", [[model.card_bill_return_day_str stringByReplacingOccurrencesOfString:@"月-" withString:@"."] stringByReplacingOccurrencesOfString:@"日" withString:@""]];
        }else {
            self.shouldAlsoMoneyLabel.text = @"--";
            self.endTimeLabel.text = [NSString stringWithFormat:@"本期应还 / %@出账", [[model.card_bill_day_str stringByReplacingOccurrencesOfString:@"月-" withString:@"."] stringByReplacingOccurrencesOfString:@"日" withString:@""]];
        }
        
        
        
        self.reimbursementDayLabel.text = [NSString stringWithFormat:@"账单日/还款日：%@/%@", [[model.card_bill_day_str stringByReplacingOccurrencesOfString:@"月-" withString:@"."] stringByReplacingOccurrencesOfString:@"日" withString:@""], [[model.card_bill_return_day_str stringByReplacingOccurrencesOfString:@"月-" withString:@"."] stringByReplacingOccurrencesOfString:@"日" withString:@""]];
    }];
}

-(void)rightSelect{
    [self pushViewControl:@"CardManageInformationViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel, @"cardListModel", nil]];
}

-(void)ConsumptionPlaned{
    [self pushViewControl:@"CardManageConsumptionPlanedViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel, @"cardListModel", nil]];
}

-(void)CeimbursementPlaned{
    [self pushViewControl:@"CardManageCeimbursementPlanedViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel, @"cardListModel", nil]];
}

-(void)FinancialManagement{
    [self pushViewControl:@"CardManageFinancialManagementViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel, @"cardListModel", nil]];
}

-(void)changeVC:(UIButton *)button{
    switch (button.tag) {
        case 1:
            {
                if (self.currentVC != self.billingDetailsVC) {
                    if (self.currentVC == self.repaymentHistoryVC) {
                        [self.repaymentHistoryButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                        self.repaymentHistoryButton.titleLabel.font = [UIFont systemFontOfSize:14 * self.baseicFloat];
                    }else{
                        [self.recordsConsumptionButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                        self.recordsConsumptionButton.titleLabel.font = [UIFont systemFontOfSize:14 * self.baseicFloat];
                    }
                    [self transitionFromViewController:self.currentVC toViewController:self.billingDetailsVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.billingDetailsVC;
                    }];
                    [self.billingDetailsButton setTitleColor:[UIColor colorWithRed:255 / 255.0 green:68 / 255.0 blue:32 / 255.0 alpha:1] forState:UIControlStateNormal];
                    self.billingDetailsButton.titleLabel.font = [UIFont systemFontOfSize:20 * self.baseicFloat];
                }
            }
            break;
            
        case 2:
            {
                if (self.currentVC != self.repaymentHistoryVC) {
                    if (self.currentVC == self.billingDetailsVC) {
                        [self.billingDetailsButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                        self.billingDetailsButton.titleLabel.font = [UIFont systemFontOfSize:14 * self.baseicFloat];
                    }else{
                        [self.recordsConsumptionButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                        self.recordsConsumptionButton.titleLabel.font = [UIFont systemFontOfSize:14 * self.baseicFloat];
                    }
                    [self transitionFromViewController:self.currentVC toViewController:self.repaymentHistoryVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.repaymentHistoryVC;
                    }];
                    [self.repaymentHistoryButton setTitleColor:[UIColor colorWithRed:255 / 255.0 green:68 / 255.0 blue:32 / 255.0 alpha:1] forState:UIControlStateNormal];
                    self.repaymentHistoryButton.titleLabel.font = [UIFont systemFontOfSize:20 * self.baseicFloat];
                }
            }
            break;
            
        case 3:
            {
                if (self.currentVC != self.recordsConsumptionVC) {
                    if (self.currentVC == self.billingDetailsVC) {
                        [self.billingDetailsButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                        self.billingDetailsButton.titleLabel.font = [UIFont systemFontOfSize:14 * self.baseicFloat];
                    }else{
                        [self.repaymentHistoryButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                        self.repaymentHistoryButton.titleLabel.font = [UIFont systemFontOfSize:14 * self.baseicFloat];
                    }
                    [self transitionFromViewController:self.currentVC toViewController:self.recordsConsumptionVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.recordsConsumptionVC;
                    }];
                    [self.recordsConsumptionButton setTitleColor:[UIColor colorWithRed:255 / 255.0 green:68 / 255.0 blue:32 / 255.0 alpha:1] forState:UIControlStateNormal];
                    self.recordsConsumptionButton.titleLabel.font = [UIFont systemFontOfSize:20 * self.baseicFloat];
                }
            }
            break;
            
        default:
            break;
    }
}

-(UIButton *)billingDetailsButton{
    if (!_billingDetailsButton) {
        _billingDetailsButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"账单明细", 2, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 5, 236, 98, 19)];
        _billingDetailsButton.tag = 1;
    }
    return _billingDetailsButton;
}

-(UIButton *)repaymentHistoryButton{
    if (!_repaymentHistoryButton) {
        _repaymentHistoryButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"还款记录", 2, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 99, 236, 98, 19)];
        _repaymentHistoryButton.tag = 2;
    }
    return _repaymentHistoryButton;
}

-(UIButton *)recordsConsumptionButton{
    if (!_recordsConsumptionButton) {
        _recordsConsumptionButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"消费记录", 2, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 193, 236, 98, 19)];
        _recordsConsumptionButton.tag = 3;
    }
    return _recordsConsumptionButton;
}

-(UIImageView *)bankImageView{
    if (!_bankImageView) {
        _bankImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 74, 345, 148)];
    }
    return _bankImageView;
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

-(UILabel *)shouldAlsoMoneyLabel{
    if (!_shouldAlsoMoneyLabel) {
        _shouldAlsoMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 28, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 145, 100, 27)];
    }
    return _shouldAlsoMoneyLabel;
}

-(UILabel *)endTimeLabel{
    if (!_endTimeLabel) {
        _endTimeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 0.8, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 131, 155, 200, 12)];
    }
    return _endTimeLabel;
}

-(UILabel *)totalCombinationLabel{
    if (!_totalCombinationLabel) {
        _totalCombinationLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 31, 190, 200, 12)];
    }
    return _totalCombinationLabel;
}

-(UILabel *)reimbursementDayLabel{
    if (!_reimbursementDayLabel) {
        _reimbursementDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 183, 190, 168, 12)];
    }
    return _reimbursementDayLabel;
}

-(CardManageBillingDetailsViewController *)billingDetailsVC{
    if (!_billingDetailsVC) {
        _billingDetailsVC = [[CardManageBillingDetailsViewController alloc]init];
        _billingDetailsVC.cardListModel = self.cardListModel;
        _billingDetailsVC.view.frame = CGRectMake(0, 219 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 268 * self.baseicFloat - DelouchTabbarSafeBottomMargin);
        [self addChildViewController:_billingDetailsVC];
    }
    return _billingDetailsVC;
}

-(CardManageRepaymentHistoryViewController *)repaymentHistoryVC{
    if (!_repaymentHistoryVC) {
        _repaymentHistoryVC = [[CardManageRepaymentHistoryViewController alloc]init];
        _repaymentHistoryVC.cardListModel = self.cardListModel;
        _repaymentHistoryVC.view.frame = CGRectMake(0, 219 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 268 * self.baseicFloat - DelouchTabbarSafeBottomMargin);
        [self addChildViewController:_repaymentHistoryVC];
    }
    return _repaymentHistoryVC;
}

-(CardManageRecordsConsumptionViewController *)recordsConsumptionVC{
    if (!_recordsConsumptionVC) {
        _recordsConsumptionVC = [[CardManageRecordsConsumptionViewController alloc]init];
        _recordsConsumptionVC.cardListModel = self.cardListModel;
        _recordsConsumptionVC.view.frame = CGRectMake(0, 219 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 268 * self.baseicFloat - DelouchTabbarSafeBottomMargin);
        [self addChildViewController:_recordsConsumptionVC];
    }
    return _recordsConsumptionVC;
}

-(UIView *)ConsumptionPlanedView{
    if (!_ConsumptionPlanedView) {
        _ConsumptionPlanedView = [[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameNotChange, 0, DelouchHeight - DelouchTabbarSafeBottomMargin - 49 * self.baseicFloat, 125 * self.baseicFloat, 49 * self.baseicFloat)];
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_xiaofei, NO, 0, _ConsumptionPlanedView) setFrame:DelouchFrameMake(FrameCellView, 54, 7, 18, 18)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"已规划消费", 2, 102, 102, 102, 1, 255, 255, 255, 2, 10, YES, _ConsumptionPlanedView) setFrame:DelouchFrameMake(FrameCellView, 0, 33, 125, 10)];
    }
    return _ConsumptionPlanedView;
}

-(UIView *)CeimbursementPlanedView{
    if (!_CeimbursementPlanedView) {
        _CeimbursementPlanedView = [[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameNotChange, 125 * self.baseicFloat, DelouchHeight - DelouchTabbarSafeBottomMargin - 49 * self.baseicFloat, 125 * self.baseicFloat, 49 * self.baseicFloat)];
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_huankuan, NO, 0, _CeimbursementPlanedView) setFrame:DelouchFrameMake(FrameCellView, 54, 7, 18, 18)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"已规划还款", 2, 102, 102, 102, 1, 255, 255, 255, 2, 10, YES, _CeimbursementPlanedView) setFrame:DelouchFrameMake(FrameCellView, 0, 33, 125, 10)];
    }
    return _CeimbursementPlanedView;
}

-(UIView *)FinancialManagementView{
    if (!_FinancialManagementView) {
        _FinancialManagementView = [[DelouchView alloc]initView:DelouchViewInfoMake(86, 112, 254, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameNotChange,  250 * self.baseicFloat, DelouchHeight - DelouchTabbarSafeBottomMargin - 49 * self.baseicFloat, 125 * self.baseicFloat, 49 * self.baseicFloat)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"卡财务管理", 2, 255, 255, 255, 1, 255, 255, 255, 2, 16, YES, _FinancialManagementView) setFrame:DelouchFrameMake(FrameCellView, 0, 17, 125, 15)];
    }
    return _FinancialManagementView;
}

-(UIButton *)freshBillButton{
    if (!_freshBillButton) {
        _freshBillButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"更新账单", 2, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 287, 236, 98, 19)];
    }
    return _freshBillButton;
}

-(void)setBankIconString:(NSString *)bankIconString{
    [self.bankImageView sd_setImageWithURL:[NSURL URLWithString:bankIconString] placeholderImage:[UIImage imageNamed:zwt_yuan_128]];
}

-(UIButton *)guihuaButton{
    if (!_guihuaButton) {
        _guihuaButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"规划账单", 2, 255, 255, 255, 1, 255, 255, 255, 2, 13, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 265, 96, 80, 29)];
        _guihuaButton.layer.cornerRadius = 15 * (DelouchWidth / 375.0);
        _guihuaButton.layer.borderColor = [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1].CGColor;
        _guihuaButton.layer.borderWidth = DelouchWidth / 375.0;
    }
    return _guihuaButton;
}

@end
