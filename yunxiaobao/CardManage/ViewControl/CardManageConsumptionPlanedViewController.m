//
//  CardManageConsumptionPlanedViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageConsumptionPlanedViewController.h"
#import "ConsumptionPlanedHeaderView.h"
#import "CardManageConsumptionPlanedTableViewCell.h"

@interface CardManageConsumptionPlanedViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 消费总额(元)
 */
@property(nonatomic, strong)UILabel *totalConsumptionLabel;

/**
 成本(元)
 */
@property(nonatomic, strong)UILabel *costLabel;

/**
 消费总额(元)
 */
@property(nonatomic, strong)NSString *totalConsumptionString;

/**
 成本(元)
 */
@property(nonatomic, strong)NSString *costString;

@property(nonatomic, strong)GetOperatingAmountModel *getOperatingAmountModel;

@end

@implementation CardManageConsumptionPlanedViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.refreshIndex = 1;
    [self freshTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"已规划消费";
}

-(void)freshTableView{
    [self urlHeadStr:AppCardsURL urlStr:UrlGetOperatingList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel.card_id, @"card_id", @"2", @"plan_kind", self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
        [self.dataArray removeAllObjects];
        self.getOperatingAmountModel = [[GetOperatingAmountModel alloc]initModelWithDic:obj[@"result"][@"count"]];
        self.totalConsumptionString = self.getOperatingAmountModel.amount.length == 0 ? @"0" : self.getOperatingAmountModel.amount;
        self.costString = self.getOperatingAmountModel.fee.length == 0 ? @"0" : self.getOperatingAmountModel.fee;
        for (NSDictionary *dic in obj[@"result"][@"data"]) {
            [self.dataArray addObject:[[GetOperatingTitleModel alloc]initModelWithDic:dic]];
        }
        [self.tableView reloadData];
    }];
}

-(void)rightSelect{
    [self pushViewControl:@"CardManageAddConsumptionPlanedViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel, @"cardListModel", nil]];
}

-(void)createUI{
    self.rightImageString = icon_add_cardholder;
    self.headview.lineView.hidden = YES;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15 * self.baseicFloat,10 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 345 * self.baseicFloat, 100 * self.baseicFloat)];
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,3);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 9;
    view.layer.cornerRadius = 3 * self.baseicFloat;
    [self.view addSubview:view];
        
    self.totalConsumptionString = @"0";
    self.costString = @"0";
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"消费总额(元)", 1, 51, 51, 51, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 94, 170, 12)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"成本(元)", 1, 51, 51, 51, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 203, 94, 160, 12)];
    
    self.tableView.frame = CGRectMake(0, 130 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight -  130 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.freshBOOL = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBill:) name:@"updateBill" object:nil];
}

-(void)updateBill:(NSNotification *)noti{
    [self freshTableView];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ConsumptionPlanedHeaderView *consumptionPlanedHeaderView = [[ConsumptionPlanedHeaderView alloc]initWithFrame:CGRectMake(0, 0, DelouchWidth, 57 * self.baseicFloat)];
    GetOperatingTitleModel *model = self.dataArray[section];
    consumptionPlanedHeaderView.dateString = [model.date substringWithRange:NSMakeRange(0, 5)];
    consumptionPlanedHeaderView.consumptionString = model.amount;
    consumptionPlanedHeaderView.consumptionTypeString = @"1";
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
//    CardManageConsumptionPlanedTableViewCell *cardManageConsumptionPlanedTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"CardManageConsumptionPlanedTableViewCell"];
//    if (!cardManageConsumptionPlanedTableViewCell) {
        CardManageConsumptionPlanedTableViewCell *cardManageConsumptionPlanedTableViewCell = [[CardManageConsumptionPlanedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardManageConsumptionPlanedTableViewCell"];
//    }
    GetOperatingTitleModel *getOperatingTitleModel = self.dataArray[indexPath.section];
    GetOperatingInfoModel *model = [[GetOperatingInfoModel alloc]initModelWithDic:getOperatingTitleModel.operatingList[indexPath.row]];
    
    if (model.plan_type_name.length == 0) {
        cardManageConsumptionPlanedTableViewCell.consumerTypeString = @"手动添加还款规划";
    }else{
        cardManageConsumptionPlanedTableViewCell.consumerTypeString = model.plan_type_name;
    }
    
    if ([model.plan_time componentsSeparatedByString:@" "].count < 2) {
        cardManageConsumptionPlanedTableViewCell.consumerShopString = [model.plan_time substringWithRange:NSMakeRange(5, model.plan_time.length - 5)];
    }else{
        cardManageConsumptionPlanedTableViewCell.consumerShopString = [model.plan_time componentsSeparatedByString:@" "][1];
    }
    
    
//    cardManageConsumptionPlanedTableViewCell.consumerShopString = model.plan_time;
    cardManageConsumptionPlanedTableViewCell.consumerMoneyString = model.plan_amount;
    cardManageConsumptionPlanedTableViewCell.consumeredString = model.plan_status;
    cardManageConsumptionPlanedTableViewCell.planIdString = model.plan_id;
    cardManageConsumptionPlanedTableViewCell.cardManageConsumptionPlanedSelectShopBlock = ^(NSString *planId) {
//        [self pushViewControl:@"TodayOperationSelectShopViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:planId, @"planIdString", nil]];
        
        
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
    cardManageConsumptionPlanedTableViewCell.cardManageConsumptionPlanedDeleteShopBlock = ^(NSString *planId) {
        self.notiString = @"取消消费成功";
        [self freshTableView];
    };
    cardManageConsumptionPlanedTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cardManageConsumptionPlanedTableViewCell;
}

-(UILabel *)totalConsumptionLabel{
    if (!_totalConsumptionLabel) {
        _totalConsumptionLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 124, 170, 28)];
    }
    return _totalConsumptionLabel;
}

-(UILabel *)costLabel{
    if (!_costLabel) {
        _costLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 203, 124, 160, 28)];
    }
    return _costLabel;
}

-(void)setTotalConsumptionString:(NSString *)totalConsumptionString{
    [DelouchLibrary setMoneyLabel:self.totalConsumptionLabel moneyText:totalConsumptionString bigFont:28 smallFont:14];
}

-(void)setCostString:(NSString *)costString{
    [DelouchLibrary setMoneyLabel:self.costLabel moneyText:costString bigFont:28 smallFont:14];
}

@end
