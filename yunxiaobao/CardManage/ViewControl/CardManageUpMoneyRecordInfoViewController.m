//
//  CardManageUpMoneyRecordInfoViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageUpMoneyRecordInfoViewController.h"

@interface CardManageUpMoneyRecordInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 银行icon
 */
@property(nonatomic, strong)UIImageView *bankIconImageView;

/**
 银行卡名称
 */
@property(nonatomic, strong)UILabel *bankNameLabel;

/**
 用户信息
 */
@property(nonatomic, strong)UILabel *userInfoLabel;

@property(nonatomic, strong)UIView *backvView;

@end

@implementation CardManageUpMoneyRecordInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"提额详情";
    
//    UIView *colorView = [[UIView alloc]initWithFrame:CGRectMake(0, DelouchStatusBarAndNavigationBarHeight, DelouchWidth, 82 * self.baseicFloat)];
//    [self.view addSubview:colorView];
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = colorView.bounds;
//    gradient.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor colorWithRed:227 / 255.0 green:227 / 255.0 blue:227 / 255.0 alpha:1].CGColor];
//    gradient.startPoint = CGPointMake(0.5, 0);
//    gradient.endPoint = CGPointMake(0.5, 1);
//    [colorView.layer addSublayer:gradient];
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake([NSString stringWithFormat:@"bg_%@750x144.png", self.cardRaiseCountListModel.card_bank], NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 74, 375, 72)];
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake([NSString stringWithFormat:@"logo_%@80.png", self.cardRaiseCountListModel.card_bank], NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 30, 94, 32, 32)];
    
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(91, 115, 245, 1, YES, 3, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 176, 345, 23)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(37, 65, 216, 1, YES, 6, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 20, 181, 336, 12)];
    
    self.backvView = [[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, YES, 3, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 24, 186, 327, 1000)];
    [self.backvView.layer setBorderColor:[[UIColor colorWithRed:220 / 255.0 green:226 / 255.0 blue:254 / 255.0 alpha:1] CGColor]];
    [self.backvView.layer setBorderWidth:2 * self.baseicFloat];
    
    self.bankIconImageView.image = [UIImage imageNamed:bg_BankCard_jh];
    self.userInfoLabel.text = [NSString stringWithFormat:@"%@ | 尾号 %@", self.cardRaiseCountListModel.credit_real_name, [self.cardRaiseCountListModel.card_no substringWithRange:NSMakeRange(self.cardRaiseCountListModel.card_no.length - 4, 4)]];
    self.bankNameLabel.text = self.cardRaiseCountListModel.card_bank;
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"提额类型", 1, 86, 112, 245, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 51, 205, 90, 14)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"提额金额", 1, 86, 112, 245, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 160, 205, 90, 14)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"时间", 1, 86, 112, 245, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 284, 205, 90, 14)];
    
    self.tableView.frame = CGRectMake(40 * self.baseicFloat, 174 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 295 * self.baseicFloat, 81 * self.baseicFloat);
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self getList];
    
    self.bankIconImageView.image = [UIImage imageNamed:zwt_yuan_128];
}

-(void)getList{
    [self urlHeadStr:AppCardsURL urlStr:UrlGetCardRaiseList parameters:[NSDictionary dictionaryWithObjectsAndKeys:@"10", @"limit", @"1", @"page", self.cardIdString, @"card_id", nil] Success:^(NSDictionary *obj) {
        if ([obj[@"result"][@"page"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in obj[@"result"][@"page"]) {
                [self.dataArray addObject:[[CardRaiseListModel alloc]initModelWithDic:dic]];
            }
            self.backvView.frame = CGRectMake(24 * self.baseicFloat, 122 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 327 * self.baseicFloat, (58 + (self.dataArray.count * 27)) * self.baseicFloat);
            self.tableView.frame = CGRectMake(40 * self.baseicFloat, 170 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 295 * self.baseicFloat, (self.dataArray.count * 27) * self.baseicFloat);
            [self.tableView reloadData];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 27 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UpMoneyRecordInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UpMoneyRecordInfoTableViewCell"];
    if (!cell) {
        cell = [[UpMoneyRecordInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UpMoneyRecordInfoTableViewCell"];
    }
    CardRaiseListModel *model = self.dataArray[indexPath.row];
    
    switch ([model.type intValue]) {
        case 1:
            {
                cell.upTypeString = @"固定额度增长";
            }
            break;
            
        case 2:
            {
                cell.upTypeString = @"固定额度减少";
            }
            break;
            
        case 3:
            {
                cell.upTypeString = @"临时额度增长";
            }
            break;
            
        default:
            break;
    }
    cell.upMoneyString = model.amount;
    cell.upTimeString = [model.time componentsSeparatedByString:@" "][0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIImageView *)bankIconImageView{
    if (!_bankIconImageView) {
        _bankIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 74, 345, 72)];
    }
    return _bankIconImageView;
}

-(UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 72, 97, 200, 14)];
    }
    return _bankNameLabel;
}

-(UILabel *)userInfoLabel{
    if (!_userInfoLabel) {
        _userInfoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 10, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 72, 115, 200, 10)];
    }
    return _userInfoLabel;
}

@end
