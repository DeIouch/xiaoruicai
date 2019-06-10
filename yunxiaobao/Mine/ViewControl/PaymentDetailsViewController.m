//
//  PaymentDetailsViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/26.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "PaymentDetailsViewController.h"
#import "PaymentDetailTableViewCell.h"

@interface PaymentDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

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

@implementation PaymentDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"收支明细";
}

-(void)createUI{
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 70)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, YES, 14, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 16, 82, 109, 28)];
    
    [self.chooseMouthButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseMouth)]];
    
    self.tableView.frame = CGRectMake(0, DelouchStatusBarAndNavigationBarHeight + 70 * self.baseicFloat, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 70 * self.baseicFloat);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.mouthArray = [[NSMutableArray alloc]initWithArray:[[self getCalendar] componentsSeparatedByString:@"-"]];
    [self getCountMoney];
    self.freshBOOL = YES;
}

-(void)getCountMoney{
    [self urlHeadStr:AppInfoURL urlStr:UrlCountTypeMoney parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", [NSString stringWithFormat:@"%@-%@-1", self.mouthArray[0],  self.mouthArray[1]], @"time_stamp_star", [NSString stringWithFormat:@"%@-%@-31", self.mouthArray[0],  self.mouthArray[1]], @"time_stamp_end", nil] Success:^(NSDictionary *obj) {
        if ([obj[@"result"] isKindOfClass:[NSDictionary class]]) {
            CountTypeMoneyModel *model = [[CountTypeMoneyModel alloc]initModelWithDic:obj[@"result"]];
            self.shouruString = model.shouru;
            self.zhichuString = model.zhichu;
        }else{
            self.shouruString = @"0";
            self.zhichuString = @"0";
        }
    }];
}

-(void)freshTableView{
    [self urlHeadStr:AppInfoURL urlStr:UrlSchedule parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", [NSString stringWithFormat:@"%@-%@-1", self.mouthArray[0],  self.mouthArray[1]], @"time_stamp_star", [NSString stringWithFormat:@"%@-%@-31", self.mouthArray[0],  self.mouthArray[1]], @"time_stamp_end", [NSString stringWithFormat:@"%ld", self.refreshIndex], @"page", nil] Success:^(NSDictionary *obj) {
        if (self.refreshIndex == 1) {
            [self.dataArray removeAllObjects];
        }
        if ([obj[@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in obj[@"data"]) {
                [self.dataArray addObject:[[ScheduleModel alloc]initModelWithDic:dic]];
            }
            [self.tableView reloadData];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    PaymentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentDetailTableViewCell"];
//    if (!cell) {
        PaymentDetailTableViewCell *cell = [[PaymentDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PaymentDetailTableViewCell"];
//    }
    ScheduleModel *model = self.dataArray[indexPath.row];
    cell.moneyNumberString = model.amount;
    cell.paymentTypeString = model.type;
    cell.iconString = logo_zfb;
    NSArray *descripArray = [model.descriptionStr componentsSeparatedByString:@","];
    if (descripArray.count > 1) {
        cell.paymentNameString = [model.descriptionStr componentsSeparatedByString:@","][1];
    }else{
        cell.paymentNameString = [model.descriptionStr componentsSeparatedByString:@","][0];
    }
    cell.paymentTimeString = model.time;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)chooseMouth{
    [BRDatePickerView showDatePickerWithTitle:nil dateType:BRDatePickerModeYM defaultSelValue:nil minDate:[NSDate br_setYear:1970 month:1 day:1] maxDate:[NSDate date] isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        self.mouthArray = [[NSMutableArray alloc]initWithArray:[selectValue componentsSeparatedByString:@"-"]];
        [self getCountMoney];
        self.refreshIndex = 1;
        [self freshTableView];
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
    }];
}

-(void)setMouthArray:(NSMutableArray *)mouthArray{
    _mouthArray = mouthArray;
    self.mouthLabel.text = [NSString stringWithFormat:@"%@年%@月", mouthArray[0], mouthArray[1]];
}

-(UILabel *)mouthLabel{
    if (!_mouthLabel) {
        _mouthLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 51, 51, 51, 1, 255, 255, 255, 2, 13, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 23, 90, 81, 13)];
    }
    return _mouthLabel;
}

-(UIImageView *)chooseMouthButton{
    if (!_chooseMouthButton) {
        _chooseMouthButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_sj_xl, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 100, 84, 20, 26)];
        _chooseMouthButton.contentMode = UIViewContentModeCenter;
    }
    return _chooseMouthButton;
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

-(void)setShouruString:(NSString *)shouruString{
    self.incomeMoneyLabel.text = [NSString stringWithFormat:@"收入¥%@", shouruString];
}

-(void)setZhichuString:(NSString *)zhichuString{
    self.reflectMoneyLabel.text = [NSString stringWithFormat:@"提现¥%@", zhichuString];
}

@end
