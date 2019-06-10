//
//  HomePageCardHolderViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageCardHolderViewController.h"
#import "CardHolderTableViewCell.h"

@interface HomePageCardHolderViewController ()<UITableViewDelegate, UITableViewDataSource, MoxieSDKDelegate>

@end

@implementation HomePageCardHolderViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.refreshIndex = 1;
    [self freshTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"持卡人";
    self.rightImageString = icon_add_cardholder;
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    self.tableView.frame = [self setTableViewNoBarFrame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.freshBOOL = YES;
    
    [MoxieSDK shared].apiKey = MXApiKey;
    [MoxieSDK shared].fromController = self;
    [MoxieSDK shared].delegate = self;
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

-(void)freshTableView{
    [self urlHeadStr:AppCustomersURL urlStr:UrlAppCustomersList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
        if (self.refreshIndex == 1) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary *dic in obj[@"result"][@"data"][@"page"]) {
            [self.dataArray addObject:[[AppCustomersListModel alloc]initModelWithDic:dic]];
        }
        [self.tableView reloadData];
    }];
}

-(void)rightSelect{
    [super rightSelect];
    [self pushViewControl:@"HomePageAddCareHolderViewController" propertyDic:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 106 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CardHolderTableViewCell *cardHolderTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"CardHolderTableViewCell"];
//    if (!cardHolderTableViewCell) {
        CardHolderTableViewCell *cardHolderTableViewCell = [[CardHolderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardHolderTableViewCell"];
//    }
    AppCustomersListModel *model = self.dataArray[indexPath.row];
    cardHolderTableViewCell.userNameString = model.credit_real_name;
    cardHolderTableViewCell.userPhoneString = model.contact_phone;
    cardHolderTableViewCell.cardNumberString = model.cards_num;
        
//    cardHolderTableViewCell.cardNumberString = [NSString stringWithFormat:@"%ld", indexPath.row];
    cardHolderTableViewCell.appCustomersListModel = model;
    cardHolderTableViewCell.importBillBlock = ^(AppCustomersListModel * _Nonnull appCustomersListModel) {
        [MoxieSDK shared].userId = [NSString stringWithFormat:@"C%@", appCustomersListModel.card_id];
        [MoxieSDK shared].taskType = @"bank";
        [[MoxieSDK shared] start];
    };
    cardHolderTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cardHolderTableViewCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{    
    [self pushViewControl:@"HomePageCardHolderInfoViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.dataArray[indexPath.row], @"AppCustomersListModel", nil]];
}

@end
