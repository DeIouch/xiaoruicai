//
//  HomePageBuyedPosViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageBuyedPosViewController.h"
#import "HomePageBuyedPosTableViewCell.h"
#import "HomePageApplyPosViewController.h"

@interface HomePageBuyedPosViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

/**
 返回购买页面
 */
@property(nonatomic, strong)UILabel *backLabel;

@end

@implementation HomePageBuyedPosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"已购买";
    self.tableView.frame = [self setTableViewNoBarFrame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        
    self.freshBOOL = YES;
    
}

-(void)freshTableView{
    [self urlHeadStr:AppPostURL urlStr:UrlQueryPackageByOrderListList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
        [self.dataArray removeAllObjects];
        for (NSDictionary *dic in obj[@"result"][@"list"]) {
            QueryPackageByOrderModel *model = [[QueryPackageByOrderModel alloc]initModelWithDic:dic];
//            if ([model.order_type isEqualToString:@"2"]) {
                [self.dataArray addObject:model];
//            }
        }
        if (self.dataArray.count == 0) {
            [self noBuyUI];
        }else{
            [self.tableView reloadData];
        }
    }];
}

-(void)noBuyUI{
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_gwc, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 84, 194, 251, 120)];
    [self.backLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backview)]];
}

-(void)leftSelect{
    HomePageApplyPosViewController *mainVC = nil;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[HomePageApplyPosViewController class]]) {
            mainVC = (HomePageApplyPosViewController *)vc;
        }
    }
    if (mainVC == nil) {
        mainVC = [[HomePageApplyPosViewController alloc]init];
    }
    [self.navigationController popToViewController:mainVC animated:YES];
}

-(void)backview{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
//  255
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    QueryPackageByOrderModel *model = self.dataArray[indexPath.row];
    if ([model.order_status isEqualToString:@"3"]) {
        return 265 * self.baseicFloat;
    }
    return 240 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageBuyedPosTableViewCell *homePageBuyedPosTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageBuyedPosTableViewCell"];
    if (!homePageBuyedPosTableViewCell) {
        homePageBuyedPosTableViewCell = [[HomePageBuyedPosTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageBuyedPosTableViewCell"];
    }
    QueryPackageByOrderModel *model = self.dataArray[indexPath.row];
    homePageBuyedPosTableViewCell.buyTimeString = model.creat_time;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:[[NSDictionary alloc]initWithObjectsAndKeys:model.real_price, @"real_price", model.pos_name, @"pos_name", model.order_num, @"order_num", nil]];
    homePageBuyedPosTableViewCell.dataArray = array;
//    homePageBuyedPosTableViewCell.nameString = model.user_name;
//    homePageBuyedPosTableViewCell.phoneString = model.phone;
    homePageBuyedPosTableViewCell.addressString = model.order_detail;
    
    switch ([model.order_status intValue]) {
        case 0:
        {
            homePageBuyedPosTableViewCell.buyStateString = @"未支付";
        }
            break;
            
        case 1:
        {
            homePageBuyedPosTableViewCell.buyStateString = @"已支付";
        }
            break;
            
        case 2:
        {
            homePageBuyedPosTableViewCell.buyStateString = @"待发货";
        }
            break;
            
        case 3:
        {
            homePageBuyedPosTableViewCell.buyStateString = @"已完成";
            homePageBuyedPosTableViewCell.logisticsNumberString = model.express_no;
        }
            break;
            
        default:
        {
            
        }
            break;
    }
    
    homePageBuyedPosTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return homePageBuyedPosTableViewCell;
}

-(UILabel *)backLabel{
    if (!_backLabel) {
        _backLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"您的购物车为空，请点击这里购买~", 2, 178, 178, 178, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 346, 375, 15)];
        _backLabel.userInteractionEnabled = YES;
    }
    return _backLabel;
}

@end
