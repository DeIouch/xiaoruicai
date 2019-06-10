//
//  MakeSureIntelligentPlanViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "MakeSureIntelligentPlanViewController.h"
#import "ConsumptionPlanListTableViewCell.h"
#import "ConsumptionPlanListHeaderView.h"
#import "ReimbursementPlanInfoViewController.h"
#import "ConsumptionPlanInfoViewController.h"
#import "HomePageViewController.h"
#import "IntelligentPlanViewController.h"

@interface MakeSureIntelligentPlanViewController ()

/**
 银行卡图片
 */
@property(nonatomic, strong)UIImageView *bankImageView;

/**
 银行卡头像
 */
@property(nonatomic, strong)UIImageView *bankIconImageView;

/**
 银行名称
 */
@property(nonatomic, strong)UILabel *bankNameLabel;

/**
 用户信息
 */
@property(nonatomic, strong)UILabel *userInfoLabel;

/**
 消费总额
 */
@property(nonatomic, strong)UILabel *totalConsumptionLabel;

/**
 还款总额
 */
@property(nonatomic, strong)UILabel *totalReimbursementLabel;

/**
 成本
 */
@property(nonatomic, strong)UILabel *costLabel;

/**
 消费
 */
@property(nonatomic, strong)UIButton *consumptionButton;

/**
 还款
 */
@property(nonatomic, strong)UIButton *reimbursementButton;

@property(nonatomic, strong)NSMutableArray *huankuanArray;

/**
 规划类型
 */
@property(nonatomic, assign)BOOL selectTypeBOOL;

/**
 要展开和收缩的组
 */
@property(nonatomic, assign)NSInteger shrinkageInt;

@property(nonatomic, assign)BOOL shrinkageBOOL;

@property(nonatomic, strong)ConsumptionPlanInfoViewController *consumptionPlanInfoVC;

@property(nonatomic, strong)ReimbursementPlanInfoViewController *reimbursementPlanInfoVC;

@property(nonatomic, strong)UIViewController *currentVC;

/**
 返回的json数据
 */
@property(nonatomic, strong)NSString *jsonString;

/**
  重新规划
 */
@property(nonatomic, strong)UIButton *againPlanningButton;

/**
 提交规划
 */
@property(nonatomic, strong)UIButton *updatePlanningButton;

@end

@implementation MakeSureIntelligentPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"确认智能规划";
    self.bankImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@690x276.png", self.needToPlanModel.card_bank]];
    
    self.bankIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"logo_%@80.png", self.needToPlanModel.card_bank]];
    
    self.bankNameLabel.text = self.needToPlanModel.card_bank;
    self.userInfoLabel.text = [NSString stringWithFormat:@"%@ | 尾号 %@", self.availableCreditString, [self.needToPlanModel.card_no substringWithRange:NSMakeRange(self.needToPlanModel.card_no.length - 4, 4)]];
    
    [self addChildViewController:self.consumptionPlanInfoVC];
    [self.view addSubview:self.consumptionPlanInfoVC.view];
    [self.consumptionPlanInfoVC didMoveToParentViewController:self];
    self.currentVC = self.consumptionPlanInfoVC;
    
    [self.consumptionButton addTarget:self action:@selector(selectConsumption) forControlEvents:UIControlEventTouchUpInside];
    [self.reimbursementButton addTarget:self action:@selector(selectReimbursement) forControlEvents:UIControlEventTouchUpInside];
    self.selectTypeBOOL = YES;
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 271, 375, 2)];
    
    [self.againPlanningButton addTarget:self action:@selector(againPlanning) forControlEvents:UIControlEventTouchUpInside];
    
    [self.updatePlanningButton addTarget:self action:@selector(updatePlanning) forControlEvents:UIControlEventTouchUpInside];
    
    self.huankuanArray = [[NSMutableArray alloc]init];
    
    [self createPlan];
}

-(void)createPlan{
    [self urlHeadStr:AppCardPlanURL urlStr:UrlCreatePlan parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.needToPlanModel.card_id, @"card_id", [NSString stringWithFormat:@"1,%@%@", [self.haveZhouliu isEqualToString:@"1"] ? @"2," : @"", [self.haveZhouRi isEqualToString:@"1"] ? @"2," : @""], @"plan_date", self.modeType, @"plan_mode", self.number, @"consume_num", @"1", @"pos_id", self.shouldAlsoString, @"card_current_bill_return_amount", self.availableCreditString, @"card_usable_amount", self.baseMoneyNumberString, @"card_pay_base_amount", self.packageString, @"card_meal_id", self.baseMoneyString, @"card_pay_type", nil] Success:^(NSDictionary *obj) {
        self.jsonString = [self convertToJsonData:obj[@"result"][@"planListJson"]];
        self.totalConsumptionString = [obj[@"result"][@"countMap"][@"totalConsumeAmount"] stringValue];
        self.totalReimbursementString = [obj[@"result"][@"countMap"][@"totalRepayAmount"] stringValue];
        self.costString = [obj[@"result"][@"countMap"][@"totalFeeAmount"] stringValue];
        [self.dataArray removeAllObjects];
        [self.huankuanArray removeAllObjects];
        for (NSDictionary *dic in obj[@"result"][@"planList"]) {
            CreatePlanModel *model = [[CreatePlanModel alloc]initModelWithDic:dic];
            if ([model.plan_kind isEqualToString:@"2"]) {
                [self.dataArray addObject:model];
            }else{
                [self.huankuanArray addObject:model];
            }
            self.consumptionPlanInfoVC.dataArray = self.dataArray;
            self.reimbursementPlanInfoVC.dataArray = self.huankuanArray;
        }
    }];
}

-(void)againPlanning{
    [self createPlan];
//    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updatePlanning{
    __weak typeof(self) weakSelf = self;
    [self urlHeadStr:AppCardPlanURL urlStr:UrlSubmitPlan parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.jsonString, @"planListJson", self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
        self.notiString = @"创建智能规划成功";
        [weakSelf goHomeVC];
    }];
}

-(void)goHomeVC{
    IntelligentPlanViewController *mainVC = nil;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[IntelligentPlanViewController class]]) {
            mainVC = (IntelligentPlanViewController *)vc;
        }
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popToViewController:mainVC animated:YES];
        });
    });
}

-(NSString *)convertToJsonData:(NSDictionary *)dict{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

-(void)selectConsumption{
    if (!self.selectTypeBOOL) {
        self.selectTypeBOOL = YES;
        [self transitionFromViewController:self.currentVC toViewController:self.consumptionPlanInfoVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
            self.currentVC = self.consumptionPlanInfoVC;
        }];
    }
}

-(void)selectReimbursement{
    if (self.selectTypeBOOL) {
        self.selectTypeBOOL = NO;
        [self transitionFromViewController:self.currentVC toViewController:self.reimbursementPlanInfoVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
            self.currentVC = self.reimbursementPlanInfoVC;
        }];
    }
}

-(UIImageView *)bankImageView{
    if (!_bankImageView) {
        _bankImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(bg_BankCard_defaulte, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 74, 345, 138)];
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
        _userInfoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 0.8, 255, 255, 255, 2, 10, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 72, 115, 300, 10)];
    }
    return _userInfoLabel;
}

-(UILabel *)totalConsumptionLabel{
    if (!_totalConsumptionLabel) {
        _totalConsumptionLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 255, 255, 255, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 180, 120, 13)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"消费总额", 2, 255, 255, 255, 0.6, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 6, 159, 108, 12)];
        
    }
    return _totalConsumptionLabel;
}

-(UILabel *)totalReimbursementLabel{
    if (!_totalReimbursementLabel) {
        _totalReimbursementLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 255, 255, 255, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 124, 180, 128, 13)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"还款总额", 2, 255, 255, 255, 0.6, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 134, 159, 108, 12)];
    }
    return _totalReimbursementLabel;
}

-(UILabel *)costLabel{
    if (!_costLabel) {
        _costLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 255, 255, 255, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 263, 180, 108, 13)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"成本", 2, 255, 255, 255, 0.6, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 263, 159, 108, 12)];
    }
    return _costLabel;
}

-(UIButton *)consumptionButton{
    if (!_consumptionButton) {
        _consumptionButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"消费", 2, 255, 68, 32, 1, 255, 255, 255, 2, 20, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 5, 236, 58, 19)];
    }
    return _consumptionButton;
}

-(UIButton *)reimbursementButton{
    if (!_reimbursementButton) {
        _reimbursementButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"还款", 2, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 79, 236, 58, 19)];
    }
    return _reimbursementButton;
}

-(void)setSelectTypeBOOL:(BOOL)selectTypeBOOL{
    _selectTypeBOOL = selectTypeBOOL;
    if (selectTypeBOOL) {
        [self.consumptionButton setTitleColor:[UIColor colorWithRed:255 / 255.0 green:68 / 255.0 blue:32 / 255.0 alpha:1] forState:UIControlStateNormal];
        self.consumptionButton.titleLabel.font = [UIFont systemFontOfSize:20 * self.baseicFloat];
        [self.reimbursementButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
        self.reimbursementButton.titleLabel.font = [UIFont systemFontOfSize:14 * self.baseicFloat];
    }else{
        [self.reimbursementButton setTitleColor:[UIColor colorWithRed:255 / 255.0 green:68 / 255.0 blue:32 / 255.0 alpha:1] forState:UIControlStateNormal];
        self.reimbursementButton.titleLabel.font = [UIFont systemFontOfSize:20 * self.baseicFloat];
        [self.consumptionButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
        self.consumptionButton.titleLabel.font = [UIFont systemFontOfSize:14 * self.baseicFloat];
    }
}

-(ConsumptionPlanInfoViewController *)consumptionPlanInfoVC{
    if (!_consumptionPlanInfoVC) {
        _consumptionPlanInfoVC = [[ConsumptionPlanInfoViewController alloc]init];
        _consumptionPlanInfoVC.view.frame = CGRectMake(0, 210 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 259 * self.baseicFloat);
        [self addChildViewController:_consumptionPlanInfoVC];
    }
    return _consumptionPlanInfoVC;
}

-(ReimbursementPlanInfoViewController *)reimbursementPlanInfoVC{
    if (!_reimbursementPlanInfoVC) {
        _reimbursementPlanInfoVC = [[ReimbursementPlanInfoViewController alloc]init];
        _reimbursementPlanInfoVC.view.frame = CGRectMake(0, 210 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 259 * self.baseicFloat);
        [self addChildViewController:_reimbursementPlanInfoVC];
    }
    return _reimbursementPlanInfoVC;
}

-(UIButton *)againPlanningButton{
    if (!_againPlanningButton) {
        _againPlanningButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"重新规划", 2, 51, 51, 51, 1, 250, 250, 250, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 0, DelouchHeight - self.baseicFloat * 49, DelouchWidth / 2.0, self.baseicFloat * 49)];
    }
    return _againPlanningButton;
}

-(UIButton *)updatePlanningButton{
    if (!_updatePlanningButton) {
        _updatePlanningButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"提交规划", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange,  DelouchWidth / 2.0, DelouchHeight - self.baseicFloat * 49, DelouchWidth / 2.0, self.baseicFloat * 49)];
    }
    return _updatePlanningButton;
}

-(void)setTotalConsumptionString:(NSString *)totalConsumptionString{
    [DelouchLibrary setMoneyLabel:self.totalConsumptionLabel moneyText:[NSString stringWithFormat:@"%0.2f", [totalConsumptionString floatValue]] bigFont:14 smallFont:10];
}

-(void)setTotalReimbursementString:(NSString *)totalReimbursementString{
    [DelouchLibrary setMoneyLabel:self.totalReimbursementLabel moneyText:[NSString stringWithFormat:@"%0.2f", [totalReimbursementString floatValue]] bigFont:14 smallFont:10];
}

-(void)setCostString:(NSString *)costString{
    [DelouchLibrary setMoneyLabel:self.costLabel moneyText:[NSString stringWithFormat:@"%0.2f", [costString floatValue]] bigFont:14 smallFont:10];
}

-(UIImageView *)bankIconImageView{
    if (!_bankIconImageView) {
        _bankIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 94, 32, 32)];
    }
    return _bankIconImageView;
}

@end
