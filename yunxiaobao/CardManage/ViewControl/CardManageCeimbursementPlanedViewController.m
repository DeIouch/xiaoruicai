//
//  CardManageCeimbursementPlanedViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageCeimbursementPlanedViewController.h"
#import "CardManageCeimbursementTableViewCell.h"
#import "ConsumptionPlanedHeaderView.h"

@interface CardManageCeimbursementPlanedViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 消费总额(元)
 */
@property(nonatomic, strong)UILabel *totalReimbursementLabel;

/**
 消费总额(元)
 */
@property(nonatomic, strong)NSString *totalReimbursementString;

@property(nonatomic, strong)GetOperatingAmountModel *getOperatingAmountModel;

@end

@implementation CardManageCeimbursementPlanedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"已规划还款";
}

-(void)createUI{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15 * self.baseicFloat,10 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 345 * self.baseicFloat, 100 * self.baseicFloat)];
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,3);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 9;
    view.layer.cornerRadius = 3 * self.baseicFloat;
    [self.view addSubview:view];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"还款总额(元)", 1, 51, 51, 51, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 94, 160, 12)];
    
    self.totalReimbursementString = @"0";
    
    self.tableView.frame = CGRectMake(0, 130 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight -  130 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.freshBOOL = YES;
}

-(void)freshTableView{
    [self urlHeadStr:AppCardsURL urlStr:UrlGetOperatingList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel.card_id, @"card_id", @"1", @"plan_kind", @"1", @"status", self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
        [self.dataArray removeAllObjects];
        self.getOperatingAmountModel = [[GetOperatingAmountModel alloc]initModelWithDic:obj[@"result"][@"count"]];
        self.totalReimbursementString = self.getOperatingAmountModel.amount;
        for (NSDictionary *dic in obj[@"result"][@"data"]) {
            [self.dataArray addObject:[[GetOperatingTitleModel alloc]initModelWithDic:dic]];
        }
        [self.tableView reloadData];
    }];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ConsumptionPlanedHeaderView *consumptionPlanedHeaderView = [[ConsumptionPlanedHeaderView alloc]initWithFrame:CGRectMake(0, 0, DelouchWidth, 57 * self.baseicFloat)];
    GetOperatingTitleModel *model = self.dataArray[section];
    consumptionPlanedHeaderView.dateString = [model.date substringWithRange:NSMakeRange(0, 5)];
    consumptionPlanedHeaderView.consumptionString = model.amount;
    consumptionPlanedHeaderView.consumptionTypeString = @"2";
    return consumptionPlanedHeaderView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    GetOperatingTitleModel *model = self.dataArray[section];
    return model.operatingList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71 * self.baseicFloat;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 57 * self.baseicFloat;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CardManageCeimbursementTableViewCell *cardManageCeimbursementTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"CardManageCeimbursementTableViewCell"];
//    if (!cardManageCeimbursementTableViewCell) {
        CardManageCeimbursementTableViewCell *cardManageCeimbursementTableViewCell = [[CardManageCeimbursementTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardManageCeimbursementTableViewCell"];
//    }
    GetOperatingTitleModel *getOperatingTitleModel = self.dataArray[indexPath.section];
    GetOperatingInfoModel *model = [[GetOperatingInfoModel alloc]initModelWithDic:getOperatingTitleModel.operatingList[indexPath.row]];
    
    cardManageCeimbursementTableViewCell.ceimbursementMoneyString = model.plan_amount;
    cardManageCeimbursementTableViewCell.ceimbursementTypeString = model.plan_status;
    cardManageCeimbursementTableViewCell.getOperatingInfoModel = model;
    cardManageCeimbursementTableViewCell.cardManageCeimbursementBlock = ^(GetOperatingInfoModel *operatingListModel) {
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
            [weakSelf deleteCard:operatingListModel];
        }];
        [deleteAction setValue:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forKey:@"titleTextColor"];
        [deleteAlert addAction:deleteAction];
        [deleteAlert addAction:cancelAction];
        [self presentViewController:deleteAlert animated:true completion:nil];
    };
    cardManageCeimbursementTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cardManageCeimbursementTableViewCell;
}

-(void)deleteCard:(GetOperatingInfoModel *)operatingListModel{
    [self urlHeadStr:AppOperationTodayURL urlStr:UrlUpdateCardPlansStatus parameters:[NSDictionary dictionaryWithObjectsAndKeys:operatingListModel.plan_id, @"id", @"2", @"plan_kind", nil] Success:^(NSDictionary *obj) {
        self.notiString = @"还款成功";
        [self freshTableView];
    }];
}

-(UILabel *)totalReimbursementLabel{
    if (!_totalReimbursementLabel) {
        _totalReimbursementLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 124, 300, 28)];
    }
    return _totalReimbursementLabel;
}

-(void)setTotalReimbursementString:(NSString *)totalReimbursementString{
    [DelouchLibrary setMoneyLabel:self.totalReimbursementLabel moneyText:totalReimbursementString bigFont:28 smallFont:14];
}

@end
