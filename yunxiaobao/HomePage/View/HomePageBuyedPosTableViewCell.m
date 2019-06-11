//
//  HomePageBuyedPosTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageBuyedPosTableViewCell.h"
#import "HomePageBuyedPosListShopTableViewCell.h"

@interface HomePageBuyedPosTableViewCell ()<UITableViewDelegate, UITableViewDataSource>

/**
 商品列表
 */
@property(nonatomic, strong)UITableView *tableView;

/**
 购买时间
 */
@property(nonatomic, strong)UILabel *buyTimeLabel;

/**
 购买状态
 */
@property(nonatomic, strong)UILabel *buyStateLabel;

/**
 用户姓名
 */
@property(nonatomic, strong)UILabel *nameLabel;

/**
 用户手机号码
 */
@property(nonatomic, strong)UILabel *phoneLabel;

/**
 购买地址
 */
@property(nonatomic, strong)UILabel *addressLabel;

/**
 物流编号
 */
@property(nonatomic, strong)UILabel *logisticsNumberLabel;

/**
 复制按钮
 */
@property(nonatomic, strong)UIButton *replicationButton;

@end

@implementation HomePageBuyedPosTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 0, DelouchWidth, 10 * (DelouchWidth / 375.0))];
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_shijian, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 27, 15, 15)];
    }
    return self;
}

-(UILabel *)buyTimeLabel{
    if (!_buyTimeLabel) {
        _buyTimeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 51, 28, 200, 14)];
    }
    return _buyTimeLabel;
}

-(UILabel *)buyStateLabel{
    if (!_buyStateLabel) {
        _buyStateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 86, 112, 254, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 299, 28, 51, 14)];
    }
    return _buyStateLabel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:_tableView];
    }
    return _tableView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameNotChange, 15 * (DelouchWidth / 375.0), _tableView.frame.size.height + _tableView.frame.origin.y, 360 * (DelouchWidth / 375.0), 1 * (DelouchWidth / 375.0))];
        _nameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameNotChange, 25 * (DelouchWidth / 375.0), 15 * (DelouchWidth / 375.0) + _tableView.frame.size.height + _tableView.frame.origin.y, 50 * (DelouchWidth / 375.0), 15 * (DelouchWidth / 375.0))];
    }
    return _nameLabel;
}

-(UIButton *)replicationButton{
    if (!_replicationButton) {
        _replicationButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"复制", 2, 86, 112, 254, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameNotChange, 25 * (DelouchWidth / 375.0), 74 * (DelouchWidth / 375.0) + _tableView.frame.size.height + _tableView.frame.origin.y, 50 * (DelouchWidth / 375.0), 35 * (DelouchWidth / 375.0))];
    }
    return _replicationButton;
}

-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameNotChange, 71 * (DelouchWidth / 375.0), 15 * (DelouchWidth / 375.0) + _tableView.frame.size.height + _tableView.frame.origin.y, 150 * (DelouchWidth / 375.0), 14 * (DelouchWidth / 375.0))];
    }
    return _phoneLabel;
}

-(void)replication{
    [UIPasteboard generalPasteboard].string = _logisticsNumberString;
    [WKProgressHUD popMessage:@"订单号已复制" inView:[UIApplication sharedApplication].keyWindow.rootViewController.view duration:1.0 animated:YES];
}

-(void)setLogisticsNumberString:(NSString *)logisticsNumberString{
    _logisticsNumberString = logisticsNumberString;
    self.logisticsNumberLabel.text = [NSString stringWithFormat:@"订单号：%@", logisticsNumberString];
    self.logisticsNumberLabel.frame = CGRectMake(self.logisticsNumberLabel.frame.origin.x, self.logisticsNumberLabel.frame.origin.y, [DelouchLibrary sizeWithText:self.logisticsNumberLabel.text withFont:14].width, 15 * (DelouchWidth / 375.0));
    [self.replicationButton addTarget:self action:@selector(replication) forControlEvents:UIControlEventTouchUpInside];
    self.replicationButton.frame = CGRectMake(self.logisticsNumberLabel.frame.origin.x + self.logisticsNumberLabel.size.width, self.replicationButton.frame.origin.y, self.replicationButton.size.width, self.replicationButton.size.height);
}

-(UILabel *)logisticsNumberLabel{
    if (!_logisticsNumberLabel) {
        _logisticsNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameNotChange, 25 * (DelouchWidth / 375.0), 84 * (DelouchWidth / 375.0) + _tableView.frame.size.height + _tableView.frame.origin.y, 150 * (DelouchWidth / 375.0), 15 * (DelouchWidth / 375.0))];
    }
    return _logisticsNumberLabel;
}

-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"安徽省-合肥市-庐阳区 某某某街道阜阳北路与北城大道交口创智天地", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameNotChange, 26 * (DelouchWidth / 375.0), 40 * (DelouchWidth / 375.0) + _tableView.frame.size.height + _tableView.frame.origin.y, 323 * (DelouchWidth / 375.0), 40 * (DelouchWidth / 375.0))];
        _addressLabel.numberOfLines = 2;
        [_addressLabel sizeToFit];
    }
    return _addressLabel;
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    self.tableView.frame = CGRectMake(0, 57 * (DelouchWidth / 375.0), DelouchWidth, 82 * (DelouchWidth / 375.0) * dataArray.count);
    [self.tableView reloadData];
}

-(void)setBuyTimeString:(NSString *)buyTimeString{
    self.buyTimeLabel.text = buyTimeString;
}

-(void)setBuyStateString:(NSString *)buyStateString{
    self.buyStateLabel.text = buyStateString;
    if ([buyStateString isEqualToString:@"已支付"]) {
        self.buyStateLabel.textColor = [UIColor colorWithRed:253 / 255.0 green:24 / 255.0 blue:35 / 255.0 alpha:1];
    }else{
        self.buyStateLabel.textColor = [UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:154 / 255.0 alpha:1];
    }
}

-(void)setNameString:(NSString *)nameString{
    self.nameLabel.text = nameString;
    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, [DelouchLibrary sizeWithText:nameString withFont:16].width, self.nameLabel.frame.size.height);
    self.phoneLabel.frame = CGRectMake(self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width + 5 * (DelouchWidth / 375.0), self.phoneLabel.frame.origin.y, self.phoneLabel.frame.size.width, self.phoneLabel.frame.size.height);
}

-(void)setPhoneString:(NSString *)phoneString{
    self.phoneLabel.text = phoneString;
}

-(void)setAddressString:(NSString *)addressString{
    NSRange range1 = [addressString rangeOfString:@"收货地址:"];
    NSRange range2 = [addressString rangeOfString:@"收货人信息:"];
    NSRange range3 = [addressString rangeOfString:@"(联系电话:"];
    NSRange range4 = [addressString rangeOfString:@"),,备注"];
    self.addressLabel.text = [addressString substringWithRange:NSMakeRange(range1.location + range1.length, addressString.length - range1.location - range1.length)];
    
    if (range2.length > 0 && range3.length > 0) {
        self.nameString = [addressString substringWithRange:NSMakeRange(range2.length, range3.location - range2.length)];
    }
    
    if (range3.length > 0 && range4.length > 0) {
        self.phoneString = [addressString substringWithRange:NSMakeRange(range3.length + range3.location, range4.location - range3.location - range3.length)];
    }
//    self.nameString = [addressString substringWithRange:NSMakeRange(range2.length, range3.location - range2.length)];
//    self.phoneString = [addressString substringWithRange:NSMakeRange(range3.length + range3.location, range4.location - range3.location)];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 82 * (DelouchWidth / 375.0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageBuyedPosListShopTableViewCell *homePageBuyedPosListShopTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageBuyedPosListShopTableViewCell"];
    if (!homePageBuyedPosListShopTableViewCell) {
        homePageBuyedPosListShopTableViewCell = [[HomePageBuyedPosListShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageBuyedPosListShopTableViewCell"];
    }
    NSDictionary *dic = self.dataArray[indexPath.row];
    homePageBuyedPosListShopTableViewCell.posIconString = @"";
    
    homePageBuyedPosListShopTableViewCell.posNameString = dic[@"pos_name"];
    homePageBuyedPosListShopTableViewCell.posPriceString = dic[@"real_price"];
    homePageBuyedPosListShopTableViewCell.posNumberString = dic[@"order_num"];
    homePageBuyedPosListShopTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return homePageBuyedPosListShopTableViewCell;
}

@end
