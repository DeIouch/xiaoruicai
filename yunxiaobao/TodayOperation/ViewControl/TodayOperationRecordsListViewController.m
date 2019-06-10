//
//  TodayOperationRecordsListViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "TodayOperationRecordsListViewController.h"
#import "TodayOperationRecordsListHeaderView.h"
#import "TodayOperationRecordsListTableViewCell.h"

@interface TodayOperationRecordsListViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 月份
 */
@property(nonatomic, strong)UILabel *mouthLabel;

/**
 选择月份
 */
@property(nonatomic, strong)UIImageView *chooseMouthButton;

/**
 提现金额
 */
@property(nonatomic, strong)UILabel *reflectMoneyLabel;

/**
 收入金额
 */
@property(nonatomic, strong)UILabel *incomeMoneyLabel;

/**
 月份信息
 */
@property(nonatomic, strong)NSMutableArray *mouthArray;

/**
 收入
 */
@property(nonatomic, strong)NSString *shouruString;

/**
 支出
 */
@property(nonatomic, strong)NSString *zhichuString;

@end

@implementation TodayOperationRecordsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"操作记录";
}

-(void)createUI{
//    self.tableView.frame = [self setTableViewNoBarFrame];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 70)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, YES, 14, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 16, 82, 109, 28)];
    
    [self.chooseMouthButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseMouth)]];
    
    self.tableView.frame = CGRectMake(0, DelouchStatusBarAndNavigationBarHeight + 70 * self.baseicFloat, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 70 * self.baseicFloat);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.mouthArray = [[NSMutableArray alloc]initWithArray:[[self getCalendar] componentsSeparatedByString:@"-"]];
//    [self getCountMoney];
    self.freshBOOL = YES;
    
}

//-(void)getCountMoney{
//    [self urlHeadStr:AppInfoURL urlStr:UrlCountTypeMoney parameters:[NSDictionary dictionaryWithObjectsAndKeys:@"13", @"user_id", [NSString stringWithFormat:@"%@-%@-1", self.mouthArray[0],  self.mouthArray[1]], @"time_stamp_star", [NSString stringWithFormat:@"%@-%@-31", self.mouthArray[0],  self.mouthArray[1]], @"time_stamp_end", @"", @"type", nil] Success:^(NSDictionary *obj) {
//        if ([obj[@"result"] isKindOfClass:[NSDictionary class]]) {
//            CountTypeMoneyModel *model = [[CountTypeMoneyModel alloc]initModelWithDic:obj[@"result"]];
//            self.shouruString = model.shouru;
//            self.zhichuString = model.zhichu;
//        }else{
//            self.shouruString = @"0";
//            self.zhichuString = @"0";
//        }
//    }];
//}

-(void)freshTableView{
    [self urlHeadStr:AppOperationTodayURL urlStr:UrlOperationalRecord parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", [NSString stringWithFormat:@"%@-%@-%@", self.mouthArray[0], self.mouthArray[1], self.mouthArray[2]], @"date", nil] Success:^(NSDictionary *obj) {
        [self.dataArray removeAllObjects];
        if ([obj[@"result"][@"recordData"][@"page"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in obj[@"result"][@"recordData"][@"page"]) {
                [self.dataArray addObject:[[OperationalRecordModel alloc]initModelWithDic:dic]];
            }
            NSArray *array = obj[@"result"][@"countData"];
            self.shouruString = @"0";
            self.zhichuString = @"0";
            
            for (NSDictionary *dic in array) {
                switch ([dic[@"deal_type"] intValue]) {
                    case 2:
                    {
                        self.shouruString = dic[@"deal_amount"];
                    }
                        break;
                        
                    case 1:
                    {
                        self.zhichuString = dic[@"deal_amount"];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
            
            
            
//            if (array.count == 2) {
//                self.shouruString = array[0][@"deal_amount"];
//                self.zhichuString = array[1][@"deal_amount"];
//            }else{
//                self.shouruString = @"0";
//                self.zhichuString = @"0";
//            }
            
            [self.tableView reloadData];
        }
    }];
    
//    [self urlHeadStr:AppOperationTodayURL urlStr:UrlOperationalRecord parameters:[NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%@-%@-%@", self.mouthArray[0], self.mouthArray[1], self.mouthArray[2]], @"date", nil] Success:^(NSDictionary *obj) {
//        NSLog(@"UrlOperationalRecord  ==  %@", obj);
//    }];
    
}

-(void)chooseMouth{
    [BRDatePickerView showDatePickerWithTitle:nil dateType:BRDatePickerModeYMD defaultSelValue:nil minDate:[NSDate br_setYear:1970 month:1 day:1] maxDate:[NSDate date] isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        self.mouthArray = [[NSMutableArray alloc]initWithArray:[selectValue componentsSeparatedByString:@"-"]];
//        [self getCountMoney];
//        self.refreshIndex = 1;
        [self freshTableView];
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
    }];
}

-(void)setMouthArray:(NSMutableArray *)mouthArray{
    _mouthArray = mouthArray;
    self.mouthLabel.text = [NSString stringWithFormat:@"%@-%@-%@", mouthArray[0], mouthArray[1], mouthArray[2]];
}

-(void)setShouruString:(NSString *)shouruString{
    self.incomeMoneyLabel.text = [NSString stringWithFormat:@"消费¥%@", shouruString];
}

-(void)setZhichuString:(NSString *)zhichuString{
    self.reflectMoneyLabel.text = [NSString stringWithFormat:@"还款¥%@", zhichuString];
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    TodayOperationRecordsListHeaderView *consumptionPlanedHeaderView = [[TodayOperationRecordsListHeaderView alloc]initWithFrame:CGRectMake(0, 0, DelouchWidth, 70 * self.baseicFloat)];
//    consumptionPlanedHeaderView.dateString = @"05月21日";
//    consumptionPlanedHeaderView.consumptionMoneyString = @"1000.00";
//    consumptionPlanedHeaderView.repaymentMoneyString = @"1000.00";
//    return consumptionPlanedHeaderView;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71 * self.baseicFloat;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 70 * self.baseicFloat;
//}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 10;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TodayOperationRecordsListTableViewCell *todayOperationRecordsListTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"TodayOperationRecordsListTableViewCell"];
    if (!todayOperationRecordsListTableViewCell) {
        todayOperationRecordsListTableViewCell = [[TodayOperationRecordsListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TodayOperationRecordsListTableViewCell"];
    }
    OperationalRecordModel *model = self.dataArray[indexPath.row];
    todayOperationRecordsListTableViewCell.userIconString = [NSString stringWithFormat:@"logo_%@80.png", model.card_bank];
    todayOperationRecordsListTableViewCell.userNameString = [NSString stringWithFormat:@"%@(%@)", model.card_bank, [model.card_no substringWithRange:NSMakeRange(model.card_no.length - 4, 4)]];;
    todayOperationRecordsListTableViewCell.dateString = model.deal_time;
    todayOperationRecordsListTableViewCell.typeString = model.deal_type;
    todayOperationRecordsListTableViewCell.moneyString = model.deal_amount;
    todayOperationRecordsListTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return todayOperationRecordsListTableViewCell;
}

-(UILabel *)mouthLabel{
    if (!_mouthLabel) {
        _mouthLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 51, 51, 51, 1, 255, 255, 255, 2, 13, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 23, 90, 81, 13)];
    }
    return _mouthLabel;
}

-(UILabel *)reflectMoneyLabel{
    if (!_reflectMoneyLabel) {
        _reflectMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 78, 160, 14)];
    }
    return _reflectMoneyLabel;
}

-(UILabel *)incomeMoneyLabel{
    if (!_incomeMoneyLabel) {
        _incomeMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 101, 160, 14)];
    }
    return _incomeMoneyLabel;
}

-(UIImageView *)chooseMouthButton{
    if (!_chooseMouthButton) {
        _chooseMouthButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_sj_xl, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 100, 84, 20, 26)];
        _chooseMouthButton.contentMode = UIViewContentModeCenter;
    }
    return _chooseMouthButton;
}

@end
