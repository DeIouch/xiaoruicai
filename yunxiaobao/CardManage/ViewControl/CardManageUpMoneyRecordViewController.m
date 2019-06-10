//
//  CardManageUpMoneyRecordViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageUpMoneyRecordViewController.h"
#import "CardManageUpMoneyRecordTableViewCell.h"

@interface CardManageUpMoneyRecordViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CardManageUpMoneyRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"提额记录";
    
    self.tableView.frame = [self setTableViewNoBarFrame];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.freshBOOL = YES;
}

-(void)freshTableView{
    [self urlHeadStr:AppCardsURL urlStr:UrlGetCardRaiseCountList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
        [self.dataArray removeAllObjects];
        for (NSDictionary *dic in obj[@"result"][@"data"]) {
            [self.dataArray addObject:[[CardRaiseCountListModel alloc]initModelWithDic:dic]];
        }
        [self.tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 127 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardManageUpMoneyRecordTableViewCell *cardManageUpMoneyRecordTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"CardManageUpMoneyRecordTableViewCell"];
    if (!cardManageUpMoneyRecordTableViewCell) {
        cardManageUpMoneyRecordTableViewCell = [[CardManageUpMoneyRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardManageUpMoneyRecordTableViewCell"];
    }
    CardRaiseCountListModel *model = self.dataArray[indexPath.row];
    
//    cardManageUpMoneyRecordTableViewCell.bankIconString = @"";
    
    cardManageUpMoneyRecordTableViewCell.bankNameString = model.card_bank;
    cardManageUpMoneyRecordTableViewCell.bankInfoString = [NSString stringWithFormat:@"%@  %@", model.credit_real_name, [model.card_no substringWithRange:NSMakeRange(model.card_no.length - 4, 4)]];
    cardManageUpMoneyRecordTableViewCell.fixedQuotaString = model.fixDownAmount;
    cardManageUpMoneyRecordTableViewCell.temporaryLinesString = model.fixUpAmount;
    cardManageUpMoneyRecordTableViewCell.cardCreditLimitString = model.tempUpAmount;
    cardManageUpMoneyRecordTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cardManageUpMoneyRecordTableViewCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CardRaiseCountListModel *model = self.dataArray[indexPath.row];
    [self pushViewControl:@"CardManageUpMoneyRecordInfoViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:model.card_id, @"cardIdString", model, @"cardRaiseCountListModel", nil]];
}

@end
