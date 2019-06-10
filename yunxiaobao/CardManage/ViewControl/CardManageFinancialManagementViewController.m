//
//  CardManageFinancialManagementViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageFinancialManagementViewController.h"
#import "CardManageFinancialManagementTableViewCell.h"

@interface CardManageFinancialManagementViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CardManageFinancialManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"卡财务管理";
    self.freshBOOL = YES;
}

-(void)freshTableView{
    [self urlHeadStr:AppCardFinanceURL urlStr:UrlFinancesList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel.card_id, @"card_id", nil] Success:^(NSDictionary *obj) {
        [self.dataArray removeAllObjects];
        if ([obj[@"result"][@"data"][@"page"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in obj[@"result"][@"data"][@"page"]) {
                [self.dataArray addObject:[[FinancesListModel alloc]initModelWithDic:dic]];
            }
//            [self.tableView reloadData];
        }
    }];
}

-(void)createUI{
    self.tableView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    self.tableView.frame = [self setTableViewNoBarFrame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.infoDic = DelouchRightButtonInfomake(@"结算卡片", 51, 51, 51, 1, 255, 255, 255, 2, 15);
}

-(void)rightSelect{
    if (self.dataArray.count > 0) {
        FinancesListModel *financesModel = self.dataArray[0];
        [self pushViewControl:@"CardManageSettlementCardViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys: financesModel, @"financesListModel", nil]];
    }else{
        self.notiString = @"卡片无需结算";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardManageFinancialManagementTableViewCell *cardManageFinancialManagementTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"CardManageFinancialManagementTableViewCell"];
    if (!cardManageFinancialManagementTableViewCell) {
        cardManageFinancialManagementTableViewCell = [[CardManageFinancialManagementTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardManageFinancialManagementTableViewCell"];
    }
    FinancesListModel *model = self.dataArray[indexPath.row];
    cardManageFinancialManagementTableViewCell.financesListModel = model;
    NSArray *startArray = [[model.begin_time componentsSeparatedByString:@" "][0] componentsSeparatedByString:@"-"];
    NSArray *endArray = [[model.end_time componentsSeparatedByString:@" "][0] componentsSeparatedByString:@"-"];
    cardManageFinancialManagementTableViewCell.financiaDateString = [NSString stringWithFormat:@"%@至%@-%@", [model.begin_time componentsSeparatedByString:@" "][0], [[model.end_time componentsSeparatedByString:@" "][0] componentsSeparatedByString:@"-"][1], [[model.end_time componentsSeparatedByString:@" "][0] componentsSeparatedByString:@"-"][2]];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"MM-dd"];
    NSString *dateStr=[format1 stringFromDate:[NSDate date]];
    NSArray *dateArray = [dateStr componentsSeparatedByString:@"-"];
    if ([dateArray[0] intValue] < [startArray[1] intValue] || ([dateArray[0] intValue] == [startArray[1] intValue] && [dateArray[1] intValue] < [startArray[2] intValue])) {
        cardManageFinancialManagementTableViewCell.financiaTypeString = @"0";
    }else if (([dateArray[0] intValue] == [startArray[1] intValue] && [dateArray[1] intValue] >= [startArray[2] intValue]) || ([dateArray[0] intValue] == [endArray[1] intValue] && [dateArray[1] intValue] < [endArray[2] intValue])) {
        cardManageFinancialManagementTableViewCell.financiaTypeString = @"1";
    }else if ([dateArray[0] intValue] > [endArray[1] intValue] || ([dateArray[0] intValue] == [endArray[1] intValue] && [dateArray[1] intValue] >= [endArray[2] intValue])) {
        cardManageFinancialManagementTableViewCell.financiaTypeString = @"2";
    }
    cardManageFinancialManagementTableViewCell.goCollectionBlock = ^(FinancesListModel *financesModel) {
        [self pushViewControl:@"CardManageFinanciaTypeViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:@"1", @"financiaTypeString", financesModel, @"financesListModel", nil]];
    };

    cardManageFinancialManagementTableViewCell.seeFinanciaBlock = ^(FinancesListModel *financesModel) {
        [self pushViewControl:@"CardManageFinanciaTypeViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:@"2", @"financiaTypeString", financesModel, @"financesListModel", nil]];
    };
    
    cardManageFinancialManagementTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cardManageFinancialManagementTableViewCell;
}

@end
