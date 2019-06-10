//
//  ReimbursementPlanInfoViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ReimbursementPlanInfoViewController.h"
#import "ReimbursementPlanListTableViewCell.h"
#import "ConsumptionPlanListHeaderView.h"

@interface ReimbursementPlanInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 规划类型
 */
@property(nonatomic, assign)BOOL selectTypeBOOL;

/**
 要展开和收缩的组
 */
@property(nonatomic, assign)NSInteger shrinkageInt;

@property(nonatomic, assign)BOOL shrinkageBOOL;

@property(nonatomic, strong)NSMutableArray *dateArray;

@end

@implementation ReimbursementPlanInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 259 * self.baseicFloat);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    self.dateArray = dataArray;
    [self.tableView reloadData];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 105 * self.baseicFloat;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56 * self.baseicFloat;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (_shrinkageBOOL) {
        return self.dateArray.count;
//    }else{
//        return 0;
//    }
//    return 0;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    ConsumptionPlanListHeaderView *consumptionPlanListHeaderView = [[ConsumptionPlanListHeaderView alloc]initWithFrame:CGRectMake(0, 0, DelouchWidth, 105 * self.baseicFloat)];
//    consumptionPlanListHeaderView.mouthDayString = [NSString stringWithFormat:@"%ld月", section];
//    consumptionPlanListHeaderView.dateString = @"2019.04.23-05.22";
//    consumptionPlanListHeaderView.totalNumberString = @"4574.00";
//    consumptionPlanListHeaderView.accountDateString = @"04月22日";
//    consumptionPlanListHeaderView.collectionDateString = @"05月22日";
//    __weak typeof(self) weakSelf = self;
//    consumptionPlanListHeaderView.shrinkageBlock = ^{
//        weakSelf.shrinkageBOOL = !weakSelf.shrinkageBOOL;
//        [weakSelf.tableView reloadData];
//    };
//    return consumptionPlanListHeaderView;
//}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReimbursementPlanListTableViewCell *reimbursementPlanListTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ReimbursementPlanListTableViewCell"];
    if (!reimbursementPlanListTableViewCell) {
        reimbursementPlanListTableViewCell = [[ReimbursementPlanListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReimbursementPlanListTableViewCell"];
    }    
    CreatePlanModel *model = self.dateArray[indexPath.row];
    reimbursementPlanListTableViewCell.dateString = model.plan_time;
    reimbursementPlanListTableViewCell.moneyString = model.plan_amount;
    reimbursementPlanListTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return reimbursementPlanListTableViewCell;
}

@end
