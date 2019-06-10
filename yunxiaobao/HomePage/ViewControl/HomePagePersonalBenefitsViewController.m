//
//  HomePagePersonalBenefitsViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePagePersonalBenefitsViewController.h"
#import "HomePagePersonalBenefitsTableViewCell.h"
#import "HomePagePersonalBenefitsDetailTableViewCell.h"

@interface HomePagePersonalBenefitsViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 收益总额
 */
@property(nonatomic, strong)UILabel *totalBenefitsNumberLabel;

/**
 POS分润总额
 */
@property(nonatomic, strong)UILabel *posTotalbenefitsNumberLabel;

/**
 推荐总额
 */
@property(nonatomic, strong)UILabel *totalRecommendNumberLabel;

/**
 收益model
 */
@property(nonatomic, strong)HomePageMyAmountModel *homePageMyAmountModel;

/**
 月份信息
 */
@property(nonatomic, strong)NSMutableArray *mouthArray;

@end

@implementation HomePagePersonalBenefitsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"个人收益";
    [self.headview.leftButton setImage:[UIImage imageNamed:icon_return_white] forState:UIControlStateNormal];
    self.headview.titleLabel.textColor = [UIColor whiteColor];
    self.headview.backgroundColor = [UIColor colorWithRed:97 / 255.0 green:127 / 255.0 blue:254 / 255.0 alpha:1];
    self.headview.lineView.hidden = YES;
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(97, 127, 254, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 156)];
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"收益总额(元)", 2, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 84, 375, 12)];
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"POS分润总额", 2, 255, 255, 255, 0.8, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 46, 184, 112, 12)];
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"推荐总额", 2, 255, 255, 255, 0.8, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 230, 184, 88, 12)];
    
    [DelouchLibrary setMoneyLabel:self.totalBenefitsNumberLabel moneyText:[NSString stringWithFormat:@"%0.2f", [self.totalRecommendNumberString floatValue] + [self.posTotalbenefitsNumberString floatValue]] bigFont:23 smallFont:14];
    
    [DelouchLibrary setMoneyLabel:self.posTotalbenefitsNumberLabel moneyText:self.posTotalbenefitsNumberString bigFont:16 smallFont:12];
        
    [DelouchLibrary setMoneyLabel:self.totalRecommendNumberLabel moneyText:self.totalRecommendNumberString bigFont:16 smallFont:12];
    
    self.tableView.frame = CGRectMake(0, 156 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - 156 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mouthChange:) name:@"benefitsMouthString" object:nil];
    self.mouthArray = [[NSMutableArray alloc]initWithArray:[[self getCalendar] componentsSeparatedByString:@"-"]];
    [self getMouthprofit];
    self.freshBOOL = YES;
}

-(void)mouthChange:(NSNotification *)noti{
    self.mouthArray = [[NSMutableArray alloc]initWithArray:[noti.object componentsSeparatedByString:@"-"]];
    [self getMouthprofit];
    self.refreshIndex = 1;
    [self freshTableView];
}

-(void)freshTableView{
//    @“13”
    [self urlHeadStr:AppIndexIPURL urlStr:UrlQueryAmontDetailsAndUsers parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", [NSString stringWithFormat:@"%@-%@-1", self.mouthArray[0],  self.mouthArray[1]], @"time_stamp_star", [NSString stringWithFormat:@"%@-%@-31", self.mouthArray[0],  self.mouthArray[1]], @"time_stamp_end", [NSString stringWithFormat:@"%ld", self.refreshIndex], @"page", nil] Success:^(NSDictionary *obj) {
        if (self.refreshIndex == 1) {
            [self.dataArray removeAllObjects];
        }
        if ([obj[@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in obj[@"data"]) {
                [self.dataArray addObject:[[QueryAmontDetailsAndUsersModel alloc]initModelWithDic:dic]];
            }
        }
        [self.tableView reloadData];
    }];
}

-(void)getMouthprofit{
//  @“13”
    [self urlHeadStr:AppIndexIPURL urlStr:UrlQueryUserAmountProfitMonth parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", [NSString stringWithFormat:@"%@-%@-1", self.mouthArray[0],  self.mouthArray[1]], @"time_stamp_star", [NSString stringWithFormat:@"%@-%@-31", self.mouthArray[0],  self.mouthArray[1]], @"time_stamp_end", nil] Success:^(NSDictionary *obj) {
        if ([obj[@"result"][@"list"] isKindOfClass:[NSDictionary class]]) {
            self.homePageMyAmountModel = [[HomePageMyAmountModel alloc]initModelWithDic:obj[@"result"][@"list"]];
        }else {
            self.homePageMyAmountModel.sum_amount1 = @"0";
            self.homePageMyAmountModel.sum_amount2 = @"0";
            self.homePageMyAmountModel.sum_usable_amount = @"0";
        }
        [self.tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            {
                return 225 * self.baseicFloat;
            }
            break;
            
        default:
            {
                return 78 * self.baseicFloat;
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
                HomePagePersonalBenefitsTableViewCell *homePagePersonalBenefitsTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePagePersonalBenefitsTableViewCell"];
                if (!homePagePersonalBenefitsTableViewCell) {
                    homePagePersonalBenefitsTableViewCell = [[HomePagePersonalBenefitsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePagePersonalBenefitsTableViewCell"];
                }
//                homePagePersonalBenefitsTableViewCell.totalBenefitsString = [self.homePageMyAmountModel.sum_usable_amount isEqual:[NSNull null]] ? @"0" : self.homePageMyAmountModel.sum_usable_amount;
                homePagePersonalBenefitsTableViewCell.posBenefitsString = [self.homePageMyAmountModel.sum_amount1 isEqual:[NSNull null]] ? @"0" : self.homePageMyAmountModel.sum_amount1;
                homePagePersonalBenefitsTableViewCell.recommendString = [self.homePageMyAmountModel.sum_amount2 isEqual:[NSNull null]] ? @"0" : self.homePageMyAmountModel.sum_amount2;
                
                homePagePersonalBenefitsTableViewCell.totalBenefitsString = [NSString stringWithFormat:@"%d", [homePagePersonalBenefitsTableViewCell.posBenefitsString intValue] + [homePagePersonalBenefitsTableViewCell.recommendString intValue]];
                
                homePagePersonalBenefitsTableViewCell.benefitsMouthString = [NSString stringWithFormat:@"%@年%@月", self.mouthArray[0],  self.mouthArray[1]];
                cell = homePagePersonalBenefitsTableViewCell;
            }
            break;
            
        default:
            {
                HomePagePersonalBenefitsDetailTableViewCell *homePagePersonalBenefitsDetailTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePagePersonalBenefitsDetailTableViewCell"];
                if (!homePagePersonalBenefitsDetailTableViewCell) {
                    homePagePersonalBenefitsDetailTableViewCell = [[HomePagePersonalBenefitsDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePagePersonalBenefitsDetailTableViewCell"];
                }
                QueryAmontDetailsAndUsersModel *model = self.dataArray[indexPath.row - 1];
                homePagePersonalBenefitsDetailTableViewCell.benefitsTypeString = model.descriptionString;
                homePagePersonalBenefitsDetailTableViewCell.benefitsTimeString = model.time;
                homePagePersonalBenefitsDetailTableViewCell.benefitsNumberString = model.amount;
                cell = homePagePersonalBenefitsDetailTableViewCell;
            }
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UILabel *)totalBenefitsNumberLabel{
    if (!_totalBenefitsNumberLabel) {
        _totalBenefitsNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 255, 255, 255, 1, 255, 255, 255, 2, 23, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 107, 375, 23)];
    }
    return _totalBenefitsNumberLabel;
}

-(UILabel *)posTotalbenefitsNumberLabel{
    if (!_posTotalbenefitsNumberLabel) {
        _posTotalbenefitsNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 255, 255, 255, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 46, 160, 112, 12)];
    }
    return _posTotalbenefitsNumberLabel;
}

-(UILabel *)totalRecommendNumberLabel{
    if (!_totalRecommendNumberLabel) {
        _totalRecommendNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 255, 255, 255, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 210, 160, 128, 12)];
    }
    return _totalRecommendNumberLabel;
}

@end
