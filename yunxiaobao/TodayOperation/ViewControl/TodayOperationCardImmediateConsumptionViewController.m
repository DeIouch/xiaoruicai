//
//  TodayOperationCardImmediateConsumptionViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "TodayOperationCardImmediateConsumptionViewController.h"
#import "ConsumptionPlanedHeaderView.h"
#import "CardManageConsumptionPlanedTableViewCell.h"

@interface TodayOperationCardImmediateConsumptionViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 银行卡图标
 */
@property(nonatomic, strong)UIImageView *bankIconImageView;

/**
 银行卡名称
 */
@property(nonatomic, strong)UILabel *bankNameLabel;

/**
 用户信息
 */
@property(nonatomic, strong)UILabel *userInfoLabel;

/**
 还款总金额
 */
@property(nonatomic, strong)UILabel *repaymentMoneyLabel;

/**
 还款总金额
 */
@property(nonatomic, strong)NSString *repaymentMoneyString;

@end

@implementation TodayOperationCardImmediateConsumptionViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self freshTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"消费操作";
}

-(void)createUI{
//    self.bankIconImageView.image = [UIImage imageNamed:bg_BankCard_jh];
    
//    self.bankIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@690x234.png", self.todayPlanListModel.card_bank]];
    
//    self.bankIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@690x234.png", self.todayPlanListModel.card_bank]];
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake([NSString stringWithFormat:@"bg_%@690x234.png", self.todayPlanListModel.card_bank], NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 74, 375, 117)];
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake([NSString stringWithFormat:@"logo_%@80.png", self.todayPlanListModel.card_bank], NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 94, 32, 32)];
    
//    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake([NSString stringWithFormat:@"logo_%@80.png", self.todayPlanListModel.card_bank], NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 94, 32, 32)];
    
    self.bankNameLabel.text = self.todayPlanListModel.card_bank;
    self.userInfoLabel.text = [NSString stringWithFormat:@"%@ | 尾号 %@", self.todayPlanListModel.credit_real_name, [self.todayPlanListModel.card_no substringWithRange:NSMakeRange(self.todayPlanListModel.card_no.length - 4, 4)]];
    self.repaymentMoneyString = self.todayPlanListModel.plan_amount;
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"消费总金额", 1, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 136, 155, 100, 12)];
    
    self.tableView.frame = CGRectMake(0, DelouchStatusBarAndNavigationBarHeight + 137 * self.baseicFloat, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 137 * self.baseicFloat);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.freshBOOL = YES;
}

-(void)freshTableView{
    [self urlHeadStr:AppOperationTodayURL urlStr:UrlPlanOperational parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", @"2", @"plan_kind", self.todayPlanListModel.plan_id, @"card_id", nil] Success:^(NSDictionary *obj) {
        [self.dataArray removeAllObjects];
        for (NSDictionary *dic in obj[@"result"][@"planData"]) {
            [self.dataArray addObject:[[PlanOperationalModel alloc]initModelWithDic:dic]];
        }
        [self.tableView reloadData];
    }];

}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    ConsumptionPlanedHeaderView *consumptionPlanedHeaderView = [[ConsumptionPlanedHeaderView alloc]initWithFrame:CGRectMake(0, 0, DelouchWidth, 57 * self.baseicFloat)];
//    consumptionPlanedHeaderView.dateString = @"05月21日";
//    consumptionPlanedHeaderView.consumptionString = @"1000.00";
//    consumptionPlanedHeaderView.consumptionTypeString = @"1";
//    return consumptionPlanedHeaderView;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71 * self.baseicFloat;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 57 * self.baseicFloat;
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 10;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CardManageConsumptionPlanedTableViewCell *cardManageConsumptionPlanedTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"CardManageConsumptionPlanedTableViewCell"];
//    if (!cardManageConsumptionPlanedTableViewCell) {
        CardManageConsumptionPlanedTableViewCell *cardManageConsumptionPlanedTableViewCell = [[CardManageConsumptionPlanedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardManageConsumptionPlanedTableViewCell"];
//    }
    PlanOperationalModel *model = self.dataArray[indexPath.row];
//    cardManageConsumptionPlanedTableViewCell.consumerTypeString = model.plan_type_name;
//    cardManageConsumptionPlanedTableViewCell.consumerShopString = model.plan_merchant_name;
//    cardManageConsumptionPlanedTableViewCell.consumerMoneyString = model.plan_amount;
//    cardManageConsumptionPlanedTableViewCell.consumeredString = model.plan_status;
//    cardManageConsumptionPlanedTableViewCell.planIdString = model.plan_id;

    
//    cardManageConsumptionPlanedTableViewCell.consumerShopString = model.plan_time;
    
//    cardManageConsumptionPlanedTableViewCell.consumerMoneyString = model.plan_amount;
//    cardManageConsumptionPlanedTableViewCell.consumeredString = model.plan_status;
//    cardManageConsumptionPlanedTableViewCell.planIdString = model.plan_id;
    
    if (model.plan_type_name.length == 0) {
        cardManageConsumptionPlanedTableViewCell.consumerTypeString = @"手动添加还款规划";
    }else{
        cardManageConsumptionPlanedTableViewCell.consumerTypeString = model.plan_type_name;
    }
    cardManageConsumptionPlanedTableViewCell.consumerShopString = model.plan_time;
    cardManageConsumptionPlanedTableViewCell.consumerMoneyString = model.plan_amount;
    cardManageConsumptionPlanedTableViewCell.consumeredString = model.plan_status;
    cardManageConsumptionPlanedTableViewCell.planIdString = model.plan_id;
    cardManageConsumptionPlanedTableViewCell.cardManageConsumptionPlanedSelectShopBlock = ^(NSString *planId) {
        if (self.userInfoModel.customer_no.length == 0) {
            self.notiString = @"请先激活pos机";
//            [self popVC];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                sleep(1);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self pushViewControl:@"HomePageActivateMachineViewController" propertyDic:nil];
                });
            });
        }else{
            [self pushViewControl:@"TodayOperationSelectShopViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:planId, @"planIdString", nil]];
        }
    };
    
    
//    cardManageConsumptionPlanedTableViewCell.cardManageConsumptionPlanedSelectShopBlock = ^{
//        [self pushViewControl:@"TodayOperationSelectShopViewController" propertyDic:nil];
//    };
    cardManageConsumptionPlanedTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cardManageConsumptionPlanedTableViewCell;
}

-(UIImageView *)bankIconImageView{
    if (!_bankIconImageView) {
        _bankIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 375, 345, 117)];
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
        _userInfoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 0.8, 255, 255, 255, 2, 10, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 72, 115, 200, 10)];
    }
    return _userInfoLabel;
}

-(UILabel *)repaymentMoneyLabel{
    if (!_repaymentMoneyLabel) {
        _repaymentMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 28, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 145, 100, 27)];
    }
    return _repaymentMoneyLabel;
}

-(void)setRepaymentMoneyString:(NSString *)repaymentMoneyString{
    [DelouchLibrary setMoneyLabel:self.repaymentMoneyLabel moneyText:repaymentMoneyString bigFont:18 smallFont:12];
}

@end
