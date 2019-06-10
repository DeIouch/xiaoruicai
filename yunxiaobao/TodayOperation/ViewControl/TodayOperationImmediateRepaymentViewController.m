//
//  TodayOperationImmediateRepaymentViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "TodayOperationImmediateRepaymentViewController.h"
#import "TodayOperationImmediateRepaymentTableViewCell.h"

@interface TodayOperationImmediateRepaymentViewController ()<UITableViewDelegate, UITableViewDataSource>

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

@implementation TodayOperationImmediateRepaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"还款操作";
}

-(void)createUI{
//    self.bankIconImageView.image = [UIImage imageNamed:bg_BankCard_jh];
    
    self.bankIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@690x234.png", self.todayPlanListModel.card_bank]];
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake([NSString stringWithFormat:@"logo_%@80.png", self.todayPlanListModel.card_bank], NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 94, 32, 32)];
    
    self.bankNameLabel.text = self.todayPlanListModel.card_bank;
    self.userInfoLabel.text = [NSString stringWithFormat:@"%@ | 尾号 %@", self.todayPlanListModel.credit_real_name,  self.todayPlanListModel.card_no];
    self.repaymentMoneyString = self.todayPlanListModel.plan_amount;
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"还款总金额", 1, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 136, 155, 100, 12)];
    
    self.tableView.frame = CGRectMake(0, DelouchStatusBarAndNavigationBarHeight + 137 * self.baseicFloat, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 137 * self.baseicFloat);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.freshBOOL = YES;
}

-(void)freshTableView{
    [self urlHeadStr:AppOperationTodayURL urlStr:UrlPlanOperational parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", @"1", @"plan_kind", self.todayPlanListModel.plan_id, @"card_id", nil] Success:^(NSDictionary *obj) {
        [self.dataArray removeAllObjects];
        for (NSDictionary *dic in obj[@"result"][@"planData"]) {
            [self.dataArray addObject:[[PlanOperationalModel alloc]initModelWithDic:dic]];
        }
        [self.tableView reloadData];
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TodayOperationImmediateRepaymentTableViewCell *todayOperationImmediateRepaymentTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"TodayOperationImmediateRepaymentTableViewCell"];
    if (!todayOperationImmediateRepaymentTableViewCell) {
        todayOperationImmediateRepaymentTableViewCell = [[TodayOperationImmediateRepaymentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TodayOperationImmediateRepaymentTableViewCell"];
    }
    PlanOperationalModel *model = self.dataArray[indexPath.row];
    todayOperationImmediateRepaymentTableViewCell.repaymentDateString = model.plan_time;
    todayOperationImmediateRepaymentTableViewCell.repaymentMoneyString = model.plan_amount;
    todayOperationImmediateRepaymentTableViewCell.repaymentTypeString = model.plan_status;
    todayOperationImmediateRepaymentTableViewCell.planOperationalModel = model;
    todayOperationImmediateRepaymentTableViewCell.todayOperationImmediateRepaymentBlock = ^(PlanOperationalModel *planOperationalModel) {
        UIAlertController *deleteAlert=[UIAlertController
                                        alertControllerWithTitle: nil
                                        message:@"是否已确认还款？"
                                        preferredStyle:UIAlertControllerStyleAlert
                                        ];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [cancelAction setValue:[UIColor colorWithRed:9 / 255.0 green:1 / 255.0 blue:3 / 255.0 alpha:1] forKey:@"titleTextColor"];
        __weak typeof(self) weakSelf = self;
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf deleteCard:planOperationalModel];
        }];
        [deleteAction setValue:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forKey:@"titleTextColor"];
        [deleteAlert addAction:deleteAction];
        [deleteAlert addAction:cancelAction];
        [self presentViewController:deleteAlert animated:true completion:nil];
    };
    
    todayOperationImmediateRepaymentTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return todayOperationImmediateRepaymentTableViewCell;
}

-(void)deleteCard:(PlanOperationalModel *)planOperationalModel{
    [self urlHeadStr:AppOperationTodayURL urlStr:UrlUpdateCardPlansStatus parameters:[NSDictionary dictionaryWithObjectsAndKeys:planOperationalModel.plan_id, @"id", @"2", @"plan_kind", nil] Success:^(NSDictionary *obj) {
        self.notiString = @"还款成功";
        self.refreshIndex = 1;
        [self freshTableView];
        //            [self.dataArray removeObject:planOperationalModel];
        //            [self.tableView reloadData];
    }];
}

-(UIImageView *)bankIconImageView{
    if (!_bankIconImageView) {
        _bankIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 74, 375, 117)];
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
