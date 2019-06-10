//
//  CardManageSetChargeViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageSetChargeViewController.h"
#import "SelectOperationTypeView.h"

@interface CardManageSetChargeViewController ()<SelectOperationTypeDelegate>

/**
 套餐名称
 */
@property(nonatomic, strong)UILabel *packageLabel;

/**
 收费方式
 */
@property(nonatomic, strong)UILabel *wayChargeLabel;

/**
 提额收费比例
 */
@property(nonatomic, strong)UILabel *chargeProportionLabel;

/**
 收费基数
 */
@property(nonatomic, strong)UILabel *chargingBaseLabel;

/**
 保存按钮
 */
@property(nonatomic, strong)UIButton *saveButton;

/**
 设置额度信息
 */
@property(nonatomic, strong)UIImageView *seePackageButton;

/**
 设置收费方式
 */
@property(nonatomic, strong)UIImageView *setWayChargeButton;

/**
 设置收费比例
 */
@property(nonatomic, strong)UIImageView *seeChargeProportionButton;

/**
 设置收费基数
 */
@property(nonatomic, strong)UIImageView *setChargingBaseButton;

/**
 类型选择view
 */
@property(nonatomic, strong)SelectOperationTypeView *selectOperationTypeView;

/**
 套餐ID
 */
@property(nonatomic, strong)NSString *packageIdString;

@end

@implementation CardManageSetChargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"收费设置";
    [self getUrl];
}

-(void)getUrl{
    [self urlHeadStr:AppCardsURL urlStr:UrlAppQueryMealSettingsList parameters:nil Success:^(NSDictionary *obj) {
        if ([obj[@"result"][@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in obj[@"result"][@"data"]) {
                [self.dataArray addObject:[[AppQueryMealSettingsListModel alloc]initModelWithDic:dic]];
            }
            [self getCardInfo];
        }
    }];
}

-(void)getCardInfo{
    [self urlHeadStr:AppCardsURL urlStr:UrlCardInfo parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.cardListModel.card_id, @"cardId", nil] Success:^(NSDictionary *obj) {
        NeedToPlanModel *model = [[NeedToPlanModel alloc]initModelWithDic:obj[@"result"][@"cardData"]];
        for (AppQueryMealSettingsListModel *listModel in self.dataArray) {
            if ([model.meal_name isEqualToString:listModel.meal_name]) {
                self.chargeProportionLabel.text = listModel.meal_lift_percent;
                self.packageIdString = listModel.package_id;
            }
        }
        self.packageLabel.text = model.meal_name;
        self.packageLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
        self.wayChargeLabel.text = [model.card_pay_type isEqualToString:@"1"] ? @"保留金扣取" : @"转入";
        self.wayChargeLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
        self.chargeProportionLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
        
        switch ([model.card_pay_base_amount_type intValue]) {
            case 1:
                self.chargingBaseLabel.text = @"总信用额度";
                break;
                
            case 2:
                self.chargingBaseLabel.text = @"总应还款金额";
                break;
                
            case 3:
//                self.chargingBaseLabel.text = @"自定义金额";
                self.chargingBaseLabel.text = self.cardListModel.card_pay_base_amount;
                break;
                
            default:
                break;
        }
        self.chargingBaseLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
    }];
}

-(void)save{
    [self urlHeadStr:AppCardsURL urlStr:UrlUpdateCardsMealSetting parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.chargeProportionLabel.text, @"meal_lift_percent", self.packageIdString, @"card_meal_id", self.cardListModel.card_id, @"id", nil] Success:^(NSDictionary *obj) {
        self.notiString = @"修改成功";
        [self popVC];
    }];
}

-(void)seePackage{
    self.selectOperationTypeView.hidden = NO;
}

-(void)setWayCharge{
    
}

-(void)seeChargeProportion{
    
}

-(void)setChargingBase{
    
}

-(void)createUI{
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 221)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 119, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 174, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 229, 360, 1)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"套餐名称", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 85, 100, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"收费方式", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 140, 100, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"提额收费比例", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 195, 100, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"收费基数", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 250, 100, 15)];
    
    [self.saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    [self.seePackageButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seePackage)]];
//    [self.setWayChargeButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setWayCharge)]];
//    
//    [self.seeChargeProportionButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeChargeProportion)]];
//    [self.setChargingBaseButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setChargingBase)]];
}

-(void)didSelectTypeAtIndexPath:(NSIndexPath *)indexPath{
    AppQueryMealSettingsListModel *model = self.dataArray[indexPath.row];
    self.packageLabel.text = model.meal_name;
    self.chargeProportionLabel.text = model.meal_lift_percent;
    self.packageIdString = model.package_id;
    self.packageLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
    self.chargeProportionLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
}

-(UILabel *)packageLabel{
    if (!_packageLabel) {
        _packageLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 204, 204, 204, 1, 25, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 175, 85, 170, 15)];
    }
    return _packageLabel;
}

-(UILabel *)wayChargeLabel{
    if (!_wayChargeLabel) {
        _wayChargeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 204, 204, 204, 1, 25, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 175, 140, 170, 15)];
    }
    return _wayChargeLabel;
}

-(UILabel *)chargeProportionLabel{
    if (!_chargeProportionLabel) {
        _chargeProportionLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 204, 204, 204, 1, 25, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 175, 195, 170, 15)];
    }
    return _chargeProportionLabel;
}

-(UILabel *)chargingBaseLabel{
    if (!_chargingBaseLabel) {
        _chargingBaseLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 204, 204, 204, 1, 25, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 175, 250, 170, 15)];
    }
    return _chargingBaseLabel;
}

-(UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"保存", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 315, 345, 44)];
        [self setbuttonLayer:_saveButton layerMask:3];
    }
    return _saveButton;
}

-(UIImageView *)seePackageButton{
    if (!_seePackageButton) {
        _seePackageButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 346, 76, 27, 32)];
        _seePackageButton.contentMode = UIViewContentModeCenter;
    }
    return _seePackageButton;
}

-(UIImageView *)setWayChargeButton{
    if (!_setWayChargeButton) {
        _setWayChargeButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 346, 133, 27, 32)];
        _setWayChargeButton.contentMode = UIViewContentModeCenter;
    }
    return _setWayChargeButton;
}

-(UIImageView *)seeChargeProportionButton{
    if (!_seeChargeProportionButton) {
        _seeChargeProportionButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 346, 186, 27, 32)];
        _seeChargeProportionButton.contentMode = UIViewContentModeCenter;
    }
    return _seeChargeProportionButton;
}

-(UIImageView *)setChargingBaseButton{
    if (!_setChargingBaseButton) {
        _setChargingBaseButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 346, 241, 27, 32)];
        _setChargingBaseButton.contentMode = UIViewContentModeCenter;
    }
    return _setChargingBaseButton;
}

-(SelectOperationTypeView *)selectOperationTypeView{
    if (!_selectOperationTypeView) {
        _selectOperationTypeView = [[SelectOperationTypeView alloc]init];
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (AppQueryMealSettingsListModel *model in self.dataArray) {
            [array addObject:model.meal_name];
        }
        _selectOperationTypeView.titleString = @"套餐选择";
        _selectOperationTypeView.typeArray = array;
        _selectOperationTypeView.delegate = self;
        [self.view addSubview:_selectOperationTypeView];
    }
    return _selectOperationTypeView;
}

@end
