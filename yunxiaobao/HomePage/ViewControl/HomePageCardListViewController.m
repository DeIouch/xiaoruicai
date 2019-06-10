//
//  HomePageCardListViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageCardListViewController.h"
#import "CardListTableViewCell.h"

@interface HomePageCardListViewController ()<UITableViewDelegate, UITableViewDataSource, MoxieSDKDelegate>

@end

@implementation HomePageCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"信用卡信息";
    self.infoDic = DelouchRightButtonInfomake(@"导入账单", 51, 51, 51, 1, 255, 255, 255, 2, 13);
    self.tableView.frame = [self setTableViewNoBarFrame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self urlHeadStr:AppCustomersURL urlStr:UrlAppQueryCard parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.appCustomersListModel.card_id, @"customer_id", nil] Success:^(NSDictionary *obj) {
        if (self.refreshIndex == 1) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary *dic in obj[@"result"][@"data"]) {
            [self.dataArray addObject:[[AppQueryCardModel alloc]initModelWithDic:dic]];
        }
        [self.tableView reloadData];
    }];
    
    [MoxieSDK shared].apiKey = MXApiKey;
    [MoxieSDK shared].fromController = self;
    [MoxieSDK shared].delegate = self;
}

-(void)rightSelect{
    [MoxieSDK shared].taskType = @"bank";
    [MoxieSDK shared].userId = [NSString stringWithFormat:@"C%@", self.appCustomersListModel.card_id];
    [[MoxieSDK shared] start];
}

-(void)receiveMoxieSDKResult:(NSDictionary *)resultDictionary{
    //任务结果code，详细参考文档
    int code = [resultDictionary[@"code"] intValue];
    //是否登录成功
    BOOL loginDone = [resultDictionary[@"loginDone"] boolValue];
    //任务类型
    NSString *taskType = resultDictionary[@"taskType"];
    //任务Id
    NSString *taskId = resultDictionary[@"taskId"];
    //描述
    NSString *message = resultDictionary[@"message"];
    //当前账号
    NSString *account = resultDictionary[@"account"];
    //用户在该业务平台上的userId，例如支付宝上的userId（目前支付宝，淘宝，京东支持）
    NSString *businessUserId = resultDictionary[@"businessUserId"]?resultDictionary[@"businessUserId"]:@"";
    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,message:%@,account:%@,loginDone:%d，businessUserId:%@",code,taskType,taskId,message,account,loginDone,businessUserId);
    //【登录中】假如code是2且loginDone为false，表示正在登录中
    if(code == 2 && loginDone == false){
        NSLog(@"任务正在登录中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集中】假如code是2且loginDone为true，已经登录成功，正在采集中
    else if(code == 2 && loginDone == true){
        NSLog(@"任务已经登录成功，正在采集中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集成功】假如code是1则采集成功（不代表回调成功）
    else if(code == 1){
        NSLog(@"任务采集成功，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
        self.notiString = @"任务采集成功";
    }
    //【未登录】假如code是-1则用户未登录
    else if(code == -1){
        NSLog(@"用户未登录");
//        self.notiString = @"用户未登录";
    }
    //【任务失败】该任务按失败处理，可能的code为0，-2，-3，-4
    else{
        NSLog(@"任务失败");
        self.notiString = @"任务失败";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 148 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardListTableViewCell *cardListTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"CardListTableViewCell"];
    if (!cardListTableViewCell) {
        cardListTableViewCell = [[CardListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardListTableViewCell"];
    }
    AppQueryCardModel *model = self.dataArray[indexPath.row];
    cardListTableViewCell.backString = [NSString stringWithFormat:@"bg_%@690x276.png", model.card_bank];
    cardListTableViewCell.bankIconString = [NSString stringWithFormat:@"logo_%@80.png", model.card_bank];
    cardListTableViewCell.bankNameString = model.card_bank;
    cardListTableViewCell.bankNumberString = model.card_no;
    cardListTableViewCell.shouldAlsoString = model.card_current_bill_return_amount;
    cardListTableViewCell.totalAmountString = model.card_original_amount;
    cardListTableViewCell.billDayString = model.card_bill_day;
    cardListTableViewCell.reimbursementDayString = model.card_bill_return_day;
    cardListTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cardListTableViewCell;
}

@end
