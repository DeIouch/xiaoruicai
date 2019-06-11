//
//  CardManageViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/10.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CardManageViewController.h"
#import "HomePageRepaymentTableViewCell.h"

@interface CardManageViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CardManageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.refreshIndex = 1;
    [self freshTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"卡片管理", 1, 51, 51, 51, 1, 255, 255, 255, 2, 22, NO, self.headview) setFrame:DelouchFrameMake(FrameHeadView, 15, 31, 140, 23)];
    self.headview.leftButton.hidden = YES;
    
    DelouchImageView *searchCardButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_search, NO, 0, self.headview) setFrame:DelouchFrameMake(FrameHeadView, 285, 29, 27, 27)];
    searchCardButton.contentMode = UIViewContentModeCenter;
    [searchCardButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchCard)]];
    
    DelouchImageView *importCardButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_Withdrawal_record, NO, 0, self.headview) setFrame:DelouchFrameMake(FrameHeadView, 333, 29, 27, 27)];
    importCardButton.contentMode = UIViewContentModeCenter;
    [importCardButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(importCard)]];
    
    self.tableView.frame = [self setTableViewNoBarTabbarFrame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.headview.lineView.hidden = YES;
}

-(void)createUI{
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"卡片管理", 1, 51, 51, 51, 1, 255, 255, 255, 2, 22, NO, self.headview) setFrame:DelouchFrameMake(FrameHeadView, 15, 31, 140, 23)];
    self.headview.leftButton.hidden = YES;
    DelouchImageView *searchCardButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_search, NO, 0, self.headview) setFrame:DelouchFrameMake(FrameHeadView, 285, 29, 27, 27)];
    searchCardButton.contentMode = UIViewContentModeCenter;
    [searchCardButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchCard)]];
    
    DelouchImageView *importCardButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_Withdrawal_record, NO, 0, self.headview) setFrame:DelouchFrameMake(FrameHeadView, 333, 29, 27, 27)];
    importCardButton.contentMode = UIViewContentModeCenter;
    [importCardButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(importCard)]];
    
    self.tableView.frame = [self setTableViewNoBarTabbarFrame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.freshBOOL = YES;
}

-(void)freshTableView{
    [self urlHeadStr:AppCardsURL urlStr:UrlCardList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", [NSString stringWithFormat:@"%ld", self.refreshIndex], @"page", nil] Success:^(NSDictionary *obj) {
        if (self.refreshIndex == 1) {
            [self.dataArray removeAllObjects];
        }
        if ([obj[@"result"][@"cardData"][@"page"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in obj[@"result"][@"cardData"][@"page"]) {
//                if ([dic[@"dayString"] intValue] >= 0) {
                    [self.dataArray addObject:[[NeedToPlanModel alloc]initModelWithDic:dic]];
//                }
            }
        }
        [self.tableView reloadData];
    }];
}

-(void)searchCard{
    [self pushViewControl:@"CardManageSearchCardViewController" propertyDic:nil];
}

-(void)importCard{
    [self pushViewControl:@"CardManageUpMoneyRecordViewController" propertyDic:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 127 * self.baseicFloat;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageRepaymentTableViewCell *homePageRepaymentTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageRepaymentTableViewCell"];
    if (!homePageRepaymentTableViewCell) {
        homePageRepaymentTableViewCell = [[HomePageRepaymentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageRepaymentTableViewCell"];
    }
    NeedToPlanModel *model = self.dataArray[indexPath.row];
        
    homePageRepaymentTableViewCell.bankNameString = model.card_bank;
    
    homePageRepaymentTableViewCell.bankInfoString = [NSString stringWithFormat:@"%@ %@", model.credit_real_name, [model.card_no substringWithRange:NSMakeRange(model.card_no.length - 4, 4)]];
    homePageRepaymentTableViewCell.remainingString = model.card_usable_amount;
    homePageRepaymentTableViewCell.endDayString = model.dayString;
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"MM-dd"];
    
    NSArray *timeArray = [[format1 stringFromDate:[NSDate date]] componentsSeparatedByString:@"-"];
    
    NSArray *billDayArray = [[model.card_bill_day_str stringByAppendingString:@"日"] componentsSeparatedByString:@"月-"];

    NSArray *retureDayArray = [[model.card_bill_return_day_str stringByAppendingString:@"日"] componentsSeparatedByString:@"月-"];

    if ([timeArray[0] intValue] < [billDayArray[0] intValue]) {
        homePageRepaymentTableViewCell.shouldAsloString = @"--";
        homePageRepaymentTableViewCell.asloStateString = @"1";
        homePageRepaymentTableViewCell.planStateString = model.card_is_plan;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
        NSUInteger numberOfDaysInMonth = range.length;
        NSUInteger dayNumber = [billDayArray[1] integerValue] + numberOfDaysInMonth;
        NSUInteger dd = dayNumber - [timeArray[1] integerValue];
        homePageRepaymentTableViewCell.endDayString = [NSString stringWithFormat:@"%ld", dd];
        homePageRepaymentTableViewCell.endTimeString = model.card_bill_day_str;
    }else if ([timeArray[0] intValue] == [billDayArray[0] intValue] && [timeArray[1] intValue] < [billDayArray[1] intValue]) {
        homePageRepaymentTableViewCell.shouldAsloString = @"--";
        homePageRepaymentTableViewCell.asloStateString = @"1";
        homePageRepaymentTableViewCell.planStateString = model.card_is_plan;
        homePageRepaymentTableViewCell.endDayString = [NSString stringWithFormat:@"%ld", [billDayArray[1] integerValue] - [timeArray[1] integerValue]];
        homePageRepaymentTableViewCell.endTimeString = model.card_bill_day_str;
    }else if ([timeArray[0] intValue] < [retureDayArray[0] intValue]) {
        homePageRepaymentTableViewCell.shouldAsloString = model.card_current_bill_return_amount;
        homePageRepaymentTableViewCell.asloStateString = @"0";
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
        NSUInteger numberOfDaysInMonth = range.length;
        NSUInteger dayNumber = [retureDayArray[1] integerValue] + numberOfDaysInMonth;
        NSUInteger dd = dayNumber - [timeArray[1] integerValue];
        homePageRepaymentTableViewCell.endDayString = [NSString stringWithFormat:@"%ld", dd];
        homePageRepaymentTableViewCell.endTimeString = model.card_bill_return_day_str;
        homePageRepaymentTableViewCell.planStateString = model.card_is_plan;
    }else if ([timeArray[0] intValue] == [retureDayArray[0] intValue] && [timeArray[1] intValue] <= [retureDayArray[1] intValue]) {
        homePageRepaymentTableViewCell.shouldAsloString = model.card_current_bill_return_amount;
        homePageRepaymentTableViewCell.asloStateString = @"0";
        homePageRepaymentTableViewCell.endDayString = [NSString stringWithFormat:@"%ld", [retureDayArray[1] integerValue] - [timeArray[1] integerValue]];
        homePageRepaymentTableViewCell.endTimeString = model.card_bill_return_day_str;
        homePageRepaymentTableViewCell.planStateString = model.card_is_plan;
    }else {
//        homePageRepaymentTableViewCell.shouldAsloString = model.card_current_bill_return_amount;
//        homePageRepaymentTableViewCell.asloStateString = @"2";
//        NSInteger mouthDay = [timeArray[1] integerValue];
//        for (int i = 0; i < [timeArray[0] intValue] - [retureDayArray[0] intValue]; i++) {
//            mouthDay += [self DaysfromMonth:[timeArray[0] intValue] - i - 1];
//        }
//        homePageRepaymentTableViewCell.endDayString = [NSString stringWithFormat:@"%ld", mouthDay - [retureDayArray[1] integerValue]];
//        homePageRepaymentTableViewCell.endTimeString = model.card_bill_return_day_str;
//        homePageRepaymentTableViewCell.planStateString = model.card_is_plan;

        homePageRepaymentTableViewCell.asloStateString = @"2";
        homePageRepaymentTableViewCell.planStateString = model.card_is_plan;
        homePageRepaymentTableViewCell.endTimeString = model.card_bill_day_str;
    }
    
    
    homePageRepaymentTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return homePageRepaymentTableViewCell;
}

- (NSInteger)DaysfromMonth:(NSInteger)month
{
    switch (month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:
            {
                return 31;
            }
        case 4:case 6:case 9:case 11:
            {
                return 30;
            }
        case 2:
            {
                return 28;
            }
        default:
            break;
        }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushViewControl:@"CardManageInfoViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.dataArray[indexPath.row], @"cardListModel", nil]];
}

@end
