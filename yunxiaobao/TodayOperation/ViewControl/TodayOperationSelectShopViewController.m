//
//  TodayOperationSelectShopViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "TodayOperationSelectShopViewController.h"
#import "TodayOperationChooseShopTableViewCell.h"
#import "SelectOperationTypeView.h"
#import "ShopListModel.h"

@interface TodayOperationSelectShopViewController ()<UITableViewDelegate, UITableViewDataSource, SelectOperationTypeDelegate>

/**
 商户品类
 */
@property(nonatomic, strong)UILabel *shopTypeLabel;

/**
 更多商户品类
 */
@property(nonatomic, strong)UIImageView *moreShopTypeButton;

/**
 换一批
 */
@property(nonatomic, strong)UIView *refreshBatchButton;

/**
 确认提交
 */
@property(nonatomic, strong)UIView *makeSureButton;

@property(nonatomic, assign)NSInteger selectIndex;
/**
 类型选择view
 */
@property(nonatomic, strong)SelectOperationTypeView *selectOperationTypeView;

/**
 type对应值
 */
@property(nonatomic, assign)NSInteger typeInteger;

@property(nonatomic, strong)NSString *cupsId;


@property(nonatomic, strong)NSArray *shopTypeArray;

@end

@implementation TodayOperationSelectShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"商户选取";
}

-(void)createUI{
    self.typeInteger = 1;
    self.shopTypeLabel.text = @"餐饮";
    self.tableView.frame = CGRectMake(0, 62 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - 111 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.moreShopTypeButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreShopType)]];
    
    [self.makeSureButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(makeSure)]];
    
    [self.refreshBatchButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(refreshBatch)]];
    self.shopTypeArray = [[NSArray alloc]initWithObjects:@"餐饮", @"娱乐", @"住宿", @"生活", @"购物", @"加油站", nil];
    [self refreshBatch];
}

-(void)makeSure{
    [self urlHeadStr:AppPosURL urlStr:UrlSelectShop parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.customer_no.length > 0 ? self.userInfoModel.customer_no : @"8628300031", @"customerNo", self.cupsId, @"cupsId", self.planIdString, @"plan_id", nil] Success:^(NSDictionary *obj) {
        UIAlertController *deleteAlert=[UIAlertController
                                        alertControllerWithTitle: nil
                                        message:@"确定已进行付款操作？"
                                        preferredStyle:UIAlertControllerStyleAlert
                                        ];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [cancelAction setValue:[UIColor colorWithRed:9 / 255.0 green:1 / 255.0 blue:3 / 255.0 alpha:1] forKey:@"titleTextColor"];
        __weak typeof(self) weakSelf = self;
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf deleteCard];
        }];
        [deleteAction setValue:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forKey:@"titleTextColor"];
        [deleteAlert addAction:deleteAction];
        [deleteAlert addAction:cancelAction];
        [self presentViewController:deleteAlert animated:true completion:nil];
    }];
}

-(void)deleteCard{
    [self urlHeadStr:AppCardPlanURL urlStr:UrlUpdatePlanStatus parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.planIdString, @"plan_id", nil] Success:^(NSDictionary *obj) {
        [self popVC];
    }];
}

- (void)didSelectTypeAtIndexPath:(NSIndexPath *)indexPath{
    self.selectOperationTypeView.hidden = YES;
    self.typeInteger = indexPath.row + 1;
    self.shopTypeLabel.text = self.shopTypeArray[indexPath.row];
    self.selectIndex = 0;
    [self refreshBatch];
}

-(void)refreshBatch{
    [self urlHeadStr:AppPosURL urlStr:UrlShopList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.customer_no.length > 0 ? self.userInfoModel.customer_no : @"8628300031", @"customerNo", self.shopTypeLabel.text, @"type", nil] Success:^(NSDictionary *obj) {
        [self.dataArray removeAllObjects];
        self.selectIndex = 0;
        for (NSDictionary *dic in obj[@"result"]) {
            [self.dataArray addObject:[[ShopListModel alloc]initModelWithDic:dic]];
        }
        [self.tableView reloadData];
    }];
}

-(void)moreShopType{
    self.selectOperationTypeView.hidden = NO;
}

-(UILabel *)shopTypeLabel{
    if (!_shopTypeLabel) {
        _shopTypeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 20, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 86, 200, 20)];
    }
    return _shopTypeLabel;
}

-(UIImageView *)moreShopTypeButton{
    if (!_moreShopTypeButton) {
        _moreShopTypeButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 343, 80, 27, 32)];
        _moreShopTypeButton.contentMode = UIViewContentModeCenter;
    }
    return _moreShopTypeButton;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TodayOperationChooseShopTableViewCell *todayOperationChooseShopTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"TodayOperationChooseShopTableViewCell"];
    if (!todayOperationChooseShopTableViewCell) {
        todayOperationChooseShopTableViewCell = [[TodayOperationChooseShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TodayOperationChooseShopTableViewCell"];
    }
    ShopListModel *model = self.dataArray[indexPath.row];
    todayOperationChooseShopTableViewCell.shopNameString = model.fMerchantName;
    if (indexPath.row == self.selectIndex) {
        todayOperationChooseShopTableViewCell.chooseBOOL = YES;
        self.cupsId = model.fCupsId;
    }else{
        todayOperationChooseShopTableViewCell.chooseBOOL = NO;
    }
    todayOperationChooseShopTableViewCell.cellIndex = indexPath.row;
    
    todayOperationChooseShopTableViewCell.todayOperationChooseShopBlock = ^(NSInteger index) {
        self.selectIndex = index;
        [self.tableView reloadData];
    };
    
    todayOperationChooseShopTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return todayOperationChooseShopTableViewCell;
}

-(UIView *)refreshBatchButton{
    if (!_refreshBatchButton) {
        _refreshBatchButton = [[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameNotChange, 0, DelouchHeight - 49 * self.baseicFloat, DelouchWidth * 0.5, 49 * self.baseicFloat)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"换一批", 1, 102, 102, 102, 1, 255, 255, 255, 2, 16, YES, _refreshBatchButton) setFrame:DelouchFrameMake(FrameCellView, 82, 17, 100, 16)];
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_hyp, NO, 0, _refreshBatchButton) setFrame:DelouchFrameMake(FrameCellView, 59, 18, 14, 14)];
    }
    return _refreshBatchButton;
}

-(UIView *)makeSureButton{
    if (!_makeSureButton) {
        _makeSureButton = [[DelouchView alloc]initView:DelouchViewInfoMake(86, 112, 254, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameNotChange, DelouchWidth * 0.5, DelouchHeight - 49 * self.baseicFloat, DelouchWidth * 0.5, 49 * self.baseicFloat)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"确认提交", 2, 255, 255, 255, 1, 255, 255, 255, 2, 16, YES, _makeSureButton) setFrame:DelouchFrameMake(FrameCellView, 53, 17, 83, 16)];
    }
    return _makeSureButton;
}

-(SelectOperationTypeView *)selectOperationTypeView{
    if (!_selectOperationTypeView) {
        _selectOperationTypeView = [[SelectOperationTypeView alloc]init];
        _selectOperationTypeView.titleString = @"类型选择";
        _selectOperationTypeView.delegate = self;
        _selectOperationTypeView.typeArray = [[NSMutableArray alloc]initWithArray:self.shopTypeArray];
        [self.view addSubview:_selectOperationTypeView];
    }
    return _selectOperationTypeView;
}

@end
