//
//  HomePageMyMemberManageViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageMyMemberManageViewController.h"
#import "HomePageMemberManageDetailTableViewCell.h"
#import "HomePageMemberManageTableViewCell.h"

@interface HomePageMyMemberManageViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 累计客户(人)
 */
@property(nonatomic, strong)UILabel *totalMemberNumberLabel;

/**
 昨天新增
 */
@property(nonatomic, strong)UILabel *yesterdayMemberNumberLabel;

/**
 今日新增
 */
@property(nonatomic, strong)UILabel *todayMemberNumberLabel;

/**
 普通会员
 */
@property(nonatomic, strong)UILabel *normalMemberLabel;

/**
 VIP会员
 */
@property(nonatomic, strong)UILabel *vipMemberLabel;

/**
 月份信息
 */
@property(nonatomic, strong)NSMutableArray *mouthArray;

/**
 用户数量
 */
@property(nonatomic, strong)UserMemberModel *userMemberModel;

@end

@implementation HomePageMyMemberManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"客户管理";
    [self.headview.leftButton setImage:[UIImage imageNamed:icon_return_white] forState:UIControlStateNormal];
    self.headview.titleLabel.textColor = [UIColor whiteColor];
    self.headview.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:86 / 255.0 blue:88 / 255.0 alpha:1];
    self.headview.lineView.hidden = YES;
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(240, 86, 88, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 156)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"累计客户(人)", 2, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 84, 375, 12)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"昨天新增", 2, 255, 255, 255, 0.8, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 46, 184, 112, 12)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"今日新增", 2, 255, 255, 255, 0.8, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 230, 184, 88, 12)];
    
    self.totalMemberNumberLabel.text = self.myMemberModel.zong;
    self.yesterdayMemberNumberLabel.text = self.myMemberModel.lastday;
    self.todayMemberNumberLabel.text = self.myMemberModel.today;
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 187, 236, 1, 20)];
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_pthy, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 36, 236, 15, 19)];
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_VIP_hy, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 224, 237, 20, 17)];
    
    self.normalMemberLabel.text = [NSString stringWithFormat:@"普通会员: %@", self.myMemberModel.regular.length == 0 ? @"0" : self.myMemberModel.regular];
    self.vipMemberLabel.text = [NSString stringWithFormat:@"VIP会员: %@", self.myMemberModel.zongvip.length == 0 ? @"0" : self.myMemberModel.zongvip];
    
    self.tableView.frame = CGRectMake(0, 204 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - 204 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.mouthArray = [[NSMutableArray alloc]initWithArray:[[self getCalendar] componentsSeparatedByString:@"-"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memberManage:) name:@"memberManageString" object:nil];
    
    self.freshBOOL = YES;
}

-(void)memberManage:(NSNotification *)noti{
    self.mouthArray = [[NSMutableArray alloc]initWithArray:[noti.object componentsSeparatedByString:@"-"]];
    self.refreshIndex = 1;
    [self freshTableView];
}

-(void)getMyMemberUrl{
    [self urlHeadStr:AppIndexIPURL urlStr:UrlGetUserAndRecommandAcountSum parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"id", self.userInfoModel.user_id, @"parent_user_id", nil]
             Success:^(NSDictionary *obj) {
         if ([obj[@"result"][@"list"] isKindOfClass:[NSDictionary class]]) {
             self.myMemberModel = [[HomePageMyMemberModel alloc]initModelWithDic:obj[@"result"][@"list"]];
             
             self.normalMemberLabel.text = [NSString stringWithFormat:@"普通会员: %@", self.myMemberModel.regular.length == 0 ? @"0" : self.myMemberModel.regular];
             self.vipMemberLabel.text = [NSString stringWithFormat:@"VIP会员: %@", self.myMemberModel.zongvip.length == 0 ? @"0" : self.myMemberModel.zongvip];
         }
         [self.tableView reloadData];
     }];
}

-(void)freshTableView{
    [self urlHeadStr:AppIndexIPURL urlStr:UrlUserAmountDetailsList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"parent_user_id", self.userInfoModel.user_id, @"id", [NSString stringWithFormat:@"%@-%@-1", self.mouthArray[0],  self.mouthArray[1]], @"time_stamp_star", [NSString stringWithFormat:@"%@-%@-31", self.mouthArray[0],  self.mouthArray[1]], @"time_stamp_end", [NSString stringWithFormat:@"%ld", self.refreshIndex], @"page", nil] Success:^(NSDictionary *obj) {
        if (self.refreshIndex == 1) {
            [self.dataArray removeAllObjects];
            [self getMyMemberUrl];
        }
        if ([obj[@"result"][@"list"][@"page"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in obj[@"result"][@"list"][@"page"]) {
                [self.dataArray addObject:[[UserAmountDetailsListModel alloc]initModelWithDic:dic]];
            }
        }
        if ([obj[@"result"][@"listmap"] isKindOfClass:[NSDictionary class]]) {
            self.userMemberModel = [[UserMemberModel alloc]initModelWithDic:obj[@"result"][@"listmap"]];
        }else{
            self.userMemberModel.vipMember = @"0";
            self.userMemberModel.normalMember = @"0";
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
            return 116 * self.baseicFloat;
        }
            break;
            
        default:
        {
            return 72 * self.baseicFloat;
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
                HomePageMemberManageTableViewCell *homePageMemberManageTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageMemberManageTableViewCell"];
                if (!homePageMemberManageTableViewCell) {
                    homePageMemberManageTableViewCell = [[HomePageMemberManageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageMemberManageTableViewCell"];
                }
                homePageMemberManageTableViewCell.memberMouthString = [NSString stringWithFormat:@"%@年%@月", self.mouthArray[0],  self.mouthArray[1]];
                homePageMemberManageTableViewCell.normalMemberString = [NSString stringWithFormat:@"普通会员 %@", self.userMemberModel.normalMember.length == 0 ? @"0" : self.userMemberModel.normalMember];
                homePageMemberManageTableViewCell.vipMemberString = [NSString stringWithFormat:@" VIP会员 %@", self.userMemberModel.vipMember.length == 0 ? @"0" : self.userMemberModel.vipMember];
                cell = homePageMemberManageTableViewCell;
            }
            break;
            
        default:
            {
                HomePageMemberManageDetailTableViewCell *homePageMemberManageDetailTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageMemberManageDetailTableViewCell"];
                if (!homePageMemberManageDetailTableViewCell) {
                    homePageMemberManageDetailTableViewCell = [[HomePageMemberManageDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageMemberManageDetailTableViewCell"];
                }
                UserAmountDetailsListModel *model = self.dataArray[indexPath.row - 1];
                homePageMemberManageDetailTableViewCell.memberIconString = model.user_head_img_path;
                homePageMemberManageDetailTableViewCell.membernameString = model.user_name;
                homePageMemberManageDetailTableViewCell.memberTypeString = model.package_id;
                homePageMemberManageDetailTableViewCell.timeString = model.register_time;
                homePageMemberManageDetailTableViewCell.phoneString = model.phone;
                homePageMemberManageDetailTableViewCell.userAmountDetailsListModel = model;
                cell = homePageMemberManageDetailTableViewCell;
            }
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UILabel *)normalMemberLabel{
    if (!_normalMemberLabel) {
        _normalMemberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 58, 238, 120, 13)];
    }
    return _normalMemberLabel;
}

-(UILabel *)vipMemberLabel{
    if (!_vipMemberLabel) {
        _vipMemberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 251, 238, 120, 13)];
    }
    return _vipMemberLabel;
}

-(UILabel *)totalMemberNumberLabel{
    if (!_totalMemberNumberLabel) {
        _totalMemberNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 255, 255, 255, 1, 255, 255, 255, 2, 23, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 107, 375, 23)];
    }
    return _totalMemberNumberLabel;
}

-(UILabel *)yesterdayMemberNumberLabel{
    if (!_yesterdayMemberNumberLabel) {
        _yesterdayMemberNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 255, 255, 255, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 46, 160, 112, 12)];
    }
    return _yesterdayMemberNumberLabel;
}

-(UILabel *)todayMemberNumberLabel{
    if (!_todayMemberNumberLabel) {
        _todayMemberNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 255, 255, 255, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 210, 160, 128, 12)];
    }
    return _todayMemberNumberLabel;
}

@end
