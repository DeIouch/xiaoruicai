//
//  HomePageViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/10.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageToolTableViewCell.h"
#import "HomePageMyProfitTableViewCell.h"
#import "HomePageBannerTableViewCell.h"
#import "HomePageRepaymentTableViewCell.h"

@interface HomePageViewController ()<UITableViewDataSource, UITableViewDelegate>

/**
 首页图片数组
 */
@property(nonatomic, strong)NSMutableArray *bannerArray;

/**
 我的总收益
 */
@property(nonatomic, strong)HomePageMyAmountModel *myAmountModel;

/**
 我的会员
 */
@property(nonatomic, strong)HomePageMyMemberModel *myMemberModel;

@end

@implementation HomePageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.refreshIndex = 1;
    [self freshTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, -DelouchStatusBarHeight, DelouchWidth, DelouchHeight + DelouchStatusBarHeight - DelouchTabbarHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.freshBOOL = YES;
}

-(void)getBannerUrl{
    [self urlHeadStr:AppIndexIPURL urlStr:UrlQueryBannerImg parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.oem_id, @"oem_id", nil] Success:^(NSDictionary *obj) {
        [self.bannerArray removeAllObjects];
        for (NSDictionary *dic in obj[@"result"][@"bannerList"]) {
            [self.bannerArray addObject:[[HomepageBannerModel alloc]initModelWithDic:dic]];
        }
        [self.tableView reloadData];
    }];
}

-(void)getMyAmountUrl{
    [self urlHeadStr:AppIndexIPURL urlStr:UrlQueryUserAmountProfit parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", nil]
      Success:^(NSDictionary *obj) {
          self.myAmountModel = [[HomePageMyAmountModel alloc]initModelWithDic:obj[@"result"][@"list"]];
          [self.tableView reloadData];
      }];
}

-(void)getMyMemberUrl{
    [self urlHeadStr:AppIndexIPURL urlStr:UrlGetUserAndRecommandAcountSum parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"id", self.userInfoModel.user_id, @"parent_user_id", nil]
      Success:^(NSDictionary *obj) {
          if ([obj[@"result"][@"list"] isKindOfClass:[NSDictionary class]]) {
              self.myMemberModel = [[HomePageMyMemberModel alloc]initModelWithDic:obj[@"result"][@"list"]];
          }
          [self.tableView reloadData];
      }];
}

-(void)freshTableView{
    [self getBannerUrl];
    
    [self getMyAmountUrl];
    
    [self getMyMemberUrl];
    
    [self getRepaymentUrl];
}

-(void)getRepaymentUrl{
    [self urlHeadStr:AppIndexIPURL urlStr:UrlCardsList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", nil]
      Success:^(NSDictionary *obj) {
//          if (self.refreshIndex == 1) {
              [self.dataArray removeAllObjects];
//          }
          for (NSDictionary *dic in obj[@"result"][@"list"][@"page"]) {
              if ([dic[@"remaining_days"] intValue] < 6) {
                  [self.dataArray addObject:[[CardListModel alloc]initModelWithDic:dic]];
              }
          }
          [self.tableView reloadData];
      }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count + 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 170 * self.baseicFloat;
            break;
            
        case 1:
            return 111 * self.baseicFloat;
            break;
            
        case 2:
            return 214 * self.baseicFloat;
            break;
            
        default:
            return 127 * self.baseicFloat;
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            {
                HomePageBannerTableViewCell *homePageBannerTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageBannerTableViewCell"];
                if (!homePageBannerTableViewCell) {
                    homePageBannerTableViewCell = [[HomePageBannerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageBannerTableViewCell"];
                }
                homePageBannerTableViewCell.imageUrlGroup = self.bannerArray;
                cell = homePageBannerTableViewCell;
            }
            break;
            
        case 1:
            {
                HomePageToolTableViewCell *homePageToolTableViewCell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"HomePageToolTableViewCell %ld", indexPath.row]];
                if (!homePageToolTableViewCell) {
                    homePageToolTableViewCell = [[HomePageToolTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"HomePageToolTableViewCell %ld", indexPath.row]];
                }
                homePageToolTableViewCell.homepageToolBlock = ^(NSInteger tager) {
                    switch (tager) {
                        case 1:
                            {
                                [self pushViewControl:@"HomePageCardHolderViewController" propertyDic:nil];
                            }
                            break;
                            
                        case 2:
                            {
                                [self pushViewControl:@"IntelligentPlanViewController" propertyDic:nil];
                            }
                            break;
                            
                        case 3:
                            {
                                [self pushViewControl:@"HomePageApplyPosViewController" propertyDic:nil];
                            }
                            break;
                            
                        case 4:
                            {
                                [self pushViewControl:@"HomePageActivateMachineViewController" propertyDic:nil];
                            }
                            break;
                            
                        default:
                            break;
                    }
                };
                cell = homePageToolTableViewCell;
            }
            break;
            
        case 2:
            {
                HomePageMyProfitTableViewCell *homePageMyProfitTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageMyProfitTableViewCell"];
                if (!homePageMyProfitTableViewCell) {
                    homePageMyProfitTableViewCell = [[HomePageMyProfitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageMyProfitTableViewCell"];
                }
                homePageMyProfitTableViewCell.homePageSeeMyBenefitsBlock = ^(NSString * _Nonnull allProfitMoneyString, NSString * _Nonnull recommendProfitMoneyString, NSString * _Nonnull posProfitString) {
                    [self pushViewControl:@"HomePagePersonalBenefitsViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:allProfitMoneyString, @"totalBenefitsNumberString", posProfitString, @"posTotalbenefitsNumberString", recommendProfitMoneyString, @"totalRecommendNumberString", nil]];
                };
                homePageMyProfitTableViewCell.homePageMyMemberBlock = ^{
                    [self pushViewControl:@"HomePageMyMemberManageViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.myMemberModel, @"myMemberModel", nil]];
                };
                homePageMyProfitTableViewCell.recommendProfitString = self.myAmountModel.sum_amount1;
                homePageMyProfitTableViewCell.posProfitString = self.myAmountModel.sum_amount2;
                homePageMyProfitTableViewCell.allProfitString = [NSString stringWithFormat:@"%d", [self.myAmountModel.sum_amount1 intValue] + [self.myAmountModel.sum_amount2 intValue]];
                homePageMyProfitTableViewCell.normalMemberString = self.myMemberModel.regular;
                homePageMyProfitTableViewCell.vipMenberString = self.myMemberModel.zongvip;
                cell = homePageMyProfitTableViewCell;
            }
            break;
            
        default:
            {
                HomePageRepaymentTableViewCell *homePageRepaymentTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageRepaymentTableViewCell"];
                if (!homePageRepaymentTableViewCell) {
                    homePageRepaymentTableViewCell = [[HomePageRepaymentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageRepaymentTableViewCell"];
                }
                CardListModel *model = self.dataArray[indexPath.row - 3];
                
//                homePageRepaymentTableViewCell.bankIconString = @"";
                
                homePageRepaymentTableViewCell.bankNameString = model.card_bank;
                homePageRepaymentTableViewCell.bankInfoString = [NSString stringWithFormat:@"%@ %@", model.credit_real_name, [model.card_no substringWithRange:NSMakeRange(model.card_no.length - 4, 4)]];
                homePageRepaymentTableViewCell.remainingString = model.card_usable_amount;
                homePageRepaymentTableViewCell.shouldAsloString = model.card_current_bill_return_amount;
                
                homePageRepaymentTableViewCell.endTimeString = model.card_bill_return_day_str;
                
                NSDateFormatter *format1=[[NSDateFormatter alloc] init];
                [format1 setDateFormat:@"MM-dd"];
                
                NSArray *timeArray = [[format1 stringFromDate:[NSDate date]] componentsSeparatedByString:@"-"];
                
                NSArray *retureDayArray = [[model.card_bill_return_day_str stringByAppendingString:@"日"] componentsSeparatedByString:@"月-"];
                
                if ([retureDayArray[0] intValue] > [timeArray[0] intValue]) {
                    NSCalendar *calendar = [NSCalendar currentCalendar];
                    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
                    NSUInteger numberOfDaysInMonth = range.length;
                    NSUInteger dayNumber = [retureDayArray[1] integerValue] + numberOfDaysInMonth;
                    NSUInteger dd = dayNumber - [timeArray[2] integerValue];
                    homePageRepaymentTableViewCell.endDayString = [NSString stringWithFormat:@"%ld", dd];
                }else{
                    homePageRepaymentTableViewCell.endDayString = [NSString stringWithFormat:@"%ld", [retureDayArray[1] integerValue] - [timeArray[1] integerValue]];
                }
                homePageRepaymentTableViewCell.asloStateString = model.card_is_deal;
                
                
                
                cell = homePageRepaymentTableViewCell;
            }
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 2) {
        [self pushViewControl:@"CardManageInfoViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.dataArray[indexPath.row - 3], @"cardListModel", nil]];
    }
}

-(NSMutableArray *)bannerArray{
    if (!_bannerArray) {
        _bannerArray = [[NSMutableArray alloc]init];
    }
    return _bannerArray;
}

@end
