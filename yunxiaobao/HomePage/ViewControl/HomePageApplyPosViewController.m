//
//  HomePageApplyPosViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageApplyPosViewController.h"
#import "ApplyPosTableViewCell.h"

@interface HomePageApplyPosViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UILabel *allNumberLabel;

@property(nonatomic, strong)UILabel *allPriceLabel;

@property(nonatomic, strong)UIButton *goPayButton;

@property(nonatomic, assign)NSInteger posNumberInt;

@property(nonatomic, assign)float allPriceInt;

@end

@implementation HomePageApplyPosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"购买POS";
    self.infoDic = DelouchRightButtonInfomake(@"已购买", 51, 51, 51, 1, 255, 255, 255, 2, 15);
    self.tableView.frame = CGRectMake(0, DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - DelouchTabbarSafeBottomMargin - (49 * self.baseicFloat));
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.posNumberInt = 0;
    self.allPriceInt = 0;
    [self.goPayButton addTarget:self action:@selector(goPay) forControlEvents:UIControlEventTouchUpInside];
    [self urlHeadStr:AppPostURL urlStr:UrlPosList parameters:nil Success:^(NSDictionary *obj) {
        if ([obj[@"result"][@"list"][@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in obj[@"result"][@"list"][@"data"]) {
                PosListModel *model = [[PosListModel alloc]initModelWithDic:dic];
                model.pos_number = @"0";
                [self.dataArray addObject:[[PosListModel alloc]initModelWithDic:dic]];
            }
            [self.tableView reloadData];
        }
    }];
}

-(void)goPay{
    NSMutableArray *posArray = [[NSMutableArray alloc]init];
    for (PosListModel *model in self.dataArray) {
        if ([model.pos_number intValue] > 0) {
            [posArray addObject:model];
        }
    }
    if (posArray.count > 0) {
        [self pushViewControl:@"CreateBuyPosOrderViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:posArray, @"posArray", [NSString stringWithFormat:@"%ld", self.posNumberInt], @"posNumberString", [NSString stringWithFormat:@"%.02lf", self.allPriceInt], @"allPriceString", nil]];
    }else{
        self.notiString = @"请先选择要购买的商品";
    }
}

-(void)rightSelect{
    [self pushViewControl:@"HomePageBuyedPosViewController" propertyDic:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 141 * self.baseicFloat;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApplyPosTableViewCell *applyPosTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ApplyPosTableViewCell"];
    if (!applyPosTableViewCell) {
        applyPosTableViewCell = [[ApplyPosTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ApplyPosTableViewCell"];
    }
    PosListModel *model = self.dataArray[indexPath.row];
    
    
    applyPosTableViewCell.posIconString = @"";
    applyPosTableViewCell.posListModel = model;
    applyPosTableViewCell.posNameString = model.pos_name;
    applyPosTableViewCell.posInstructionsString = model.pos_introduce;
    applyPosTableViewCell.posPriceString = [NSString stringWithFormat:@"¥%@", model.pos_price];
    applyPosTableViewCell.posIconString = model.pos_img;
    applyPosTableViewCell.posNumberString = @"0";
    applyPosTableViewCell.cellIndex = indexPath.row;
    applyPosTableViewCell.applyPosAddBlock = ^(PosListModel * _Nonnull model, NSInteger cellIndex, float price, NSString *posNumber) {
        [self.dataArray replaceObjectAtIndex:cellIndex withObject:model];
        self.posNumberInt++;
        self.allPriceInt += price;
    };
    
    applyPosTableViewCell.applyPosReductionBlock = ^(PosListModel * _Nonnull model, NSInteger cellIndex, float price, NSString *posNumber) {
        [self.dataArray replaceObjectAtIndex:cellIndex withObject:model];
        self.posNumberInt--;
        self.allPriceInt -= price;
    };
    
    applyPosTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return applyPosTableViewCell;
}

-(UIButton *)goPayButton{
    if (!_goPayButton) {
        _goPayButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"去付款", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 260 * self.baseicFloat, DelouchHeight - DelouchTabbarSafeBottomMargin - 45 * self.baseicFloat, 100 * self.baseicFloat, 40 * self.baseicFloat)];
        [self setbuttonLayer:_goPayButton layerMask:3];
    }
    return _goPayButton;
}

-(UILabel *)allNumberLabel{
    if (!_allNumberLabel) {
        _allNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 15 * self.baseicFloat, DelouchHeight - DelouchTabbarSafeBottomMargin - 30 * self.baseicFloat, 70 * self.baseicFloat, 12 * self.baseicFloat)];
    }
    return _allNumberLabel;
}

-(UILabel *)allPriceLabel{
    if (!_allPriceLabel) {
        _allPriceLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 86, 112, 254, 1, 255, 255, 255, 2, 18, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 90 * self.baseicFloat, DelouchHeight - DelouchTabbarSafeBottomMargin - 34 * self.baseicFloat, 100 * self.baseicFloat, 17 * self.baseicFloat)];
    }
    return _allPriceLabel;
}

-(void)setPosNumberInt:(NSInteger)posNumberInt{
    _posNumberInt = posNumberInt;
    self.allNumberLabel.text = [NSString stringWithFormat:@"共%ld件，总计:", posNumberInt];
    self.allNumberLabel.frame = CGRectMake(self.allNumberLabel.frame.origin.x, self.allNumberLabel.frame.origin.y, [DelouchLibrary sizeWithText:self.allNumberLabel.text withFont:12].width, self.allNumberLabel.frame.size.height);
    self.allPriceLabel.frame = CGRectMake(5 * (DelouchWidth / 375.0) +self.allNumberLabel.frame.origin.x + self.allNumberLabel.frame.size.width, self.allPriceLabel.origin.y, self.allPriceLabel.frame.size.width, self.allPriceLabel.frame.size.height);
}

-(void)setAllPriceInt:(float)allPriceInt{
    _allPriceInt = allPriceInt;
    self.allPriceLabel.text = [NSString stringWithFormat:@"¥%.02lf", allPriceInt];
}

@end
