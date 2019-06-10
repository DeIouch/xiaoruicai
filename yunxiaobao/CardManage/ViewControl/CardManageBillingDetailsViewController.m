//
//  CardManageBillingDetailsViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CardManageBillingDetailsViewController.h"
#import "CardManageBillingDetailsHeaderView.h"
#import "CardManageBillingDetailsTimeTableViewCell.h"
#import "CardManageBillingDateilsInfoTableViewCell.h"

@interface CardManageBillingDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CardManageBillingDetailsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.refreshIndex = 1;
    [self freshTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 268 * self.baseicFloat - DelouchTabbarSafeBottomMargin);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.freshBOOL = YES;
}

-(void)freshTableView{
    [self urlHeadStr:AppCardsURL urlStr:UrlQueryCardsShoppingSheet parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel.card_id, @"id", nil] Success:^(NSDictionary *obj) {
        [self.dataArray removeAllObjects];
        if ([obj[@"result"][@"page"] isKindOfClass:[NSArray class]]) {
            
            NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
            [format1 setDateFormat:@"MM"];
            NSString *mouthString = [format1 stringFromDate:[NSDate date]];
            
            for (NSDictionary *dic in obj[@"result"][@"page"]) {
                QueryCardsShoppingSheetModel *model = [[QueryCardsShoppingSheetModel alloc]initModelWithDic:dic];
                
                if ([[model.M stringByReplacingOccurrencesOfString:@"月" withString:@""] intValue] <= [mouthString intValue]) {
                    [self.dataArray addObject:model];
                }
                
                
//                [self.dataArray addObject:[[QueryCardsShoppingSheetModel alloc]initModelWithDic:dic]];
            }
            [self.tableView reloadData];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    QueryCardsShoppingSheetModel *model = self.dataArray[section];
    return model.list.count + 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CardManageBillingDetailsHeaderView *headView = [[CardManageBillingDetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, DelouchWidth, 70 * self.baseicFloat)];
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"MM-dd"];
//    NSArray *nowDateArray = [[formatter stringFromDate:[NSDate date]] componentsSeparatedByString:@"-"];
    
    QueryCardsShoppingSheetModel *model = self.dataArray[section];
    NSArray *mouthArray = [model.time componentsSeparatedByString:@"-"];
    headView.mouthString = model.M;
    headView.dateString = [NSString stringWithFormat:@"%@.%@.%@-%@.%@", mouthArray[0], mouthArray[1], mouthArray[2], mouthArray[4], mouthArray[5]];
    headView.moneyNumberString = model.money;
    
//    if ([nowDateArray[0] intValue] > [mouthArray[1] intValue] || ([nowDateArray[1] intValue] <= [mouthArray[2] intValue] && [nowDateArray[0] intValue] == [mouthArray[1] intValue])) {
//        headView.billTypeString = @"0";
//    }else if (([nowDateArray[1] intValue] > [mouthArray[2] intValue] && [nowDateArray[0] intValue] == [mouthArray[1] intValue]) || ([nowDateArray[1] intValue] < [mouthArray[5] intValue] && [nowDateArray[0] intValue] == [mouthArray[4] intValue])) {
//        headView.billTypeString = @"1";
//        headView.endDayString = @"1";
//    }else{
//        headView.billTypeString = @"1";
//        headView.billTypeString = @"1";
//    }
//    headView.billTypeString = @"1";
    
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70 * self.baseicFloat;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            {
                return 35 * self.baseicFloat;
            }
            break;
            
        default:
            {
                return 80 * self.baseicFloat;
            }
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            {
                CardManageBillingDetailsTimeTableViewCell *cardManageBillingDetailsTimeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"CardManageBillingDetailsTimeTableViewCell"];
                if (!cardManageBillingDetailsTimeTableViewCell) {
                    cardManageBillingDetailsTimeTableViewCell = [[CardManageBillingDetailsTimeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardManageBillingDetailsTimeTableViewCell"];
                }
                QueryCardsShoppingSheetModel *model = self.dataArray[indexPath.section];
                NSArray *timeArray = [model.time componentsSeparatedByString:@"-"];
                cardManageBillingDetailsTimeTableViewCell.outAccountDayString = [NSString stringWithFormat:@"出账日期   %@月%@日", timeArray[1], timeArray[2]];
                cardManageBillingDetailsTimeTableViewCell.payMentDayString = [NSString stringWithFormat:@"还款日期   %@月%@日", timeArray[4], timeArray[5]];
                cell = cardManageBillingDetailsTimeTableViewCell;
            }
            break;
            
        default:
            {
                CardManageBillingDateilsInfoTableViewCell *cardManageBillingDateilsInfoTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"CardManageBillingDateilsInfoTableViewCell"];
                if (!cardManageBillingDateilsInfoTableViewCell) {
                    cardManageBillingDateilsInfoTableViewCell = [[CardManageBillingDateilsInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardManageBillingDateilsInfoTableViewCell"];
                }
                QueryCardsShoppingSheetModel *model = self.dataArray[indexPath.section];
                QueryCardsShoppingSheetListModel *listModel = [[QueryCardsShoppingSheetListModel alloc]initModelWithDic:model.list[indexPath.row - 1]];
                if (listModel.deal_merchant_name.length == 0) {
                    cardManageBillingDateilsInfoTableViewCell.billNameString = @"手动添加";
                }else{
                    cardManageBillingDateilsInfoTableViewCell.billNameString = listModel.deal_merchant_name;
                }
                cardManageBillingDateilsInfoTableViewCell.billPriceString = listModel.deal_amount;
                cardManageBillingDateilsInfoTableViewCell.billTypeString = listModel.deal_type;
                cardManageBillingDateilsInfoTableViewCell.billDateString = listModel.deal_time;
                cardManageBillingDateilsInfoTableViewCell.billIconString = @"";
//                cardManageBillingDateilsInfoTableViewCell.billPriceString = listModel.deal_amount;
//                cardManageBillingDateilsInfoTableViewCell.billTypeString = listModel.deal_type;
                cell = cardManageBillingDateilsInfoTableViewCell;
            }
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
