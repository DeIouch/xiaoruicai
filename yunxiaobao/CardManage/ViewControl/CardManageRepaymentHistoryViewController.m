//
//  CardManageRepaymentHistoryViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CardManageRepaymentHistoryViewController.h"
#import "CardManageBillingDetailsHeaderView.h"
#import "CardManageRepaymentHistoryListTableViewCell.h"
#import "CardManageBillingDetailsTimeTableViewCell.h"

@interface CardManageRepaymentHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CardManageRepaymentHistoryViewController

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
    [self urlHeadStr:AppCardsURL urlStr:UrlQueryCardsShoppingSheetPAYMENTS parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel.card_id, @"id", nil] Success:^(NSDictionary *obj) {
        [self.dataArray removeAllObjects];
        if ([obj[@"result"][@"page"] isKindOfClass:[NSArray class]]) {
            
            NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
            [format1 setDateFormat:@"MM"];
            NSString *mouthString = [format1 stringFromDate:[NSDate date]];
            
            for (NSDictionary *dic in obj[@"result"][@"page"]) {
                QueryCardsShoppingSheetModel *model = [[QueryCardsShoppingSheetModel alloc]initModelWithDic:dic];
                
                if ([[model.M stringByReplacingOccurrencesOfString:@"" withString:@"月"] intValue] <= [mouthString intValue]) {
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
            return 71 * self.baseicFloat;
        }
            break;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CardManageBillingDetailsHeaderView *headView = [[CardManageBillingDetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, DelouchWidth, 70 * self.baseicFloat)];
    QueryCardsShoppingSheetModel *model = self.dataArray[section];
    NSArray *mouthArray = [model.time componentsSeparatedByString:@"-"];
    headView.mouthString = model.M;
    headView.dateString = [NSString stringWithFormat:@"%@.%@.%@-%@.%@", mouthArray[0], mouthArray[1], mouthArray[2], mouthArray[4], mouthArray[5]];
    headView.moneyNumberString = model.money;
    return headView;
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
                CardManageRepaymentHistoryListTableViewCell *cardManageRepaymentHistoryListTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"CardManageRepaymentHistoryListTableViewCell"];
                if (!cardManageRepaymentHistoryListTableViewCell) {
                    cardManageRepaymentHistoryListTableViewCell = [[CardManageRepaymentHistoryListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardManageRepaymentHistoryListTableViewCell"];
                }
                QueryCardsShoppingSheetModel *model = self.dataArray[indexPath.section];
                QueryCardsShoppingSheetListModel *listModel = [[QueryCardsShoppingSheetListModel alloc]initModelWithDic:model.list[indexPath.row - 1]];
                
                cardManageRepaymentHistoryListTableViewCell.repaymentHistoryIconString = @"1";
                
                cardManageRepaymentHistoryListTableViewCell.repaymentHistoryIconString = @"";
                
                cardManageRepaymentHistoryListTableViewCell.moneyString = listModel.deal_amount;
                if (listModel.deal_merchant_name.length == 0) {
                    cardManageRepaymentHistoryListTableViewCell.typeString = @"手动添加还款记录";
                }else{
                    cardManageRepaymentHistoryListTableViewCell.typeString = listModel.deal_merchant_name;
                }
//                cardManageRepaymentHistoryListTableViewCell.typeString = listModel.deal_merchant_name;
                cardManageRepaymentHistoryListTableViewCell.dateString = listModel.deal_time;
                
                cell = cardManageRepaymentHistoryListTableViewCell;
            }
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
