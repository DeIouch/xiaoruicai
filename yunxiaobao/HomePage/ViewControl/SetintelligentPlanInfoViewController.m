//
//  SetintelligentPlanInfoViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "SetintelligentPlanInfoViewController.h"
#import "SelectOperationTypeView.h"

@interface SetintelligentPlanInfoViewController ()<SelectOperationTypeDelegate>

/**
 周六
 */
@property(nonatomic, strong)UIButton *saturdayButton;

/**
 周日
 */
@property(nonatomic, strong)UIButton *sundayButton;

/**
 乐刷
 */
@property(nonatomic, strong)UIButton *leShuaButton;

/**
 付临门
 */
@property(nonatomic, strong)UIButton *fuLingMengButton;

/**
 周六
 */
@property(nonatomic, assign)BOOL saturdayBOOL;

/**
 周日
 */
@property(nonatomic, assign)BOOL sundayBOOL;

/**
 乐刷
 */
@property(nonatomic, assign)BOOL leShuaBOOL;

/**
 周六
 */
@property(nonatomic, assign)BOOL fuLingMengBOOL;

/**
 消费总笔数
 */
@property(nonatomic, strong)UITextField *totalNumberTextField;

/**
 创建规划
 */
@property(nonatomic, strong)UIButton *createPlanButton;

/**
 规划模式
 */
@property(nonatomic, strong)UIImageView *setModeButton;

/**
 模式
 */
@property(nonatomic, strong)UILabel *modelLabel;

/**
 模式类型
 */
@property(nonatomic, strong)NSString *modeTypeString;

/**
 类型选择view
 */
@property(nonatomic, strong)SelectOperationTypeView *selectOperationTypeView;

@end

@implementation SetintelligentPlanInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"智能规划";
    
    [self.saturdayButton addTarget:self action:@selector(saturday) forControlEvents:UIControlEventTouchUpInside];
    [self.sundayButton addTarget:self action:@selector(sunday) forControlEvents:UIControlEventTouchUpInside];
    [self.leShuaButton addTarget:self action:@selector(leShua) forControlEvents:UIControlEventTouchUpInside];
    [self.fuLingMengButton addTarget:self action:@selector(fuLingMeng) forControlEvents:UIControlEventTouchUpInside];
    [self.createPlanButton addTarget:self action:@selector(createPlan) forControlEvents:UIControlEventTouchUpInside];
    self.totalNumberTextField.placeholder = @"输入总消费总笔数";
    [self.setModeButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setMode)]];
    self.modeTypeString = @"1";
    self.leShuaBOOL = YES;
    [self getMode];
}

-(void)getMode{
    [self urlHeadStr:AppCardPlanURL urlStr:UrlCreatePlanFirstSecond parameters:nil Success:^(NSDictionary *obj) {
        for (NSDictionary *dic in obj[@"result"][@"fundPlanModel"]) {
            [self.dataArray addObject:dic];
        }
    }];
}

- (void)didSelectTypeAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArray[indexPath.row];
    _modelLabel.text = dic[@"desc"];
    self.modeTypeString = dic[@"value"];
}

-(void)createPlan{
    if (self.totalNumberTextField.text.length == 0) {
        self.notiString = @"请输入消费笔数";
    }else{
        [self urlHeadStr:AppCardPlanURL urlStr:UrlCreatePlanValidate parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.needToPlanModel.card_id, @"card_id", [NSString stringWithFormat:@"1,%@%@", self.saturdayBOOL ? @"2," : @"", self.sundayBOOL ? @"2," : @""], @"plan_date", self.modeTypeString, @"plan_mode", self.totalNumberTextField.text, @"consume_num", self.shouldAlsoString, @"card_current_bill_return_amount", @"1", @"pos_id", self.availableCreditString, @"card_usable_amount", self.baseMoneyNumberString, @"card_pay_base_amount_type", self.baseMoneyString, @"card_meal_id", nil] Success:^(NSDictionary *obj) {
            [self pushViewControl:@"MakeSureIntelligentPlanViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.packageString, @"packageString", self.baseMoneyString, @"baseMoneyString", [NSString stringWithFormat:@"%@", self.saturdayBOOL ? @"1" : @"0"], @"haveZhouliu", [NSString stringWithFormat:@"%@", self.sundayBOOL ? @"1" : @"0"], @"haveZhouRi", self.modeTypeString, @"modeType", [NSString stringWithFormat:@"%@", self.leShuaBOOL ? @"1" : @"0"], @"leshua", [NSString stringWithFormat:@"%@", self.fuLingMengBOOL ? @"1" : @"0"], @"fulingmen", self.totalNumberTextField.text, @"number", self.needToPlanModel, @"needToPlanModel", self.shouldAlsoString, @"shouldAlsoString", self.availableCreditString, @"availableCreditString", self.baseMoneyNumberString, @"baseMoneyNumberString", nil]];
        }];

//        @"1", @"pos_id"
        
//        [self pushViewControl:@"MakeSureIntelligentPlanViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.packageString, @"packageString", self.baseMoneyString, @"baseMoneyString", [NSString stringWithFormat:@"%@", self.saturdayBOOL ? @"1" : @"0"], @"haveZhouliu", [NSString stringWithFormat:@"%@", self.sundayBOOL ? @"1" : @"0"], @"haveZhouRi", self.modeTypeString, @"modeType", [NSString stringWithFormat:@"%@", self.leShuaBOOL ? @"1" : @"0"], @"leshua", [NSString stringWithFormat:@"%@", self.fuLingMengBOOL ? @"1" : @"0"], @"fulingmen", self.totalNumberTextField.text, @"number", self.needToPlanModel, @"needToPlanModel", nil]];
        
        
//        [self urlHeadStr:AppCardPlanURL urlStr:UrlCreatePlanValidate parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.needToPlanModel.card_id, @"card_id", [NSString stringWithFormat:@"1,%@%@", self.saturdayBOOL ? @"2," : @"", self.sundayBOOL ? @"2," : @""], @"plan_date", self.modeTypeString, @"plan_mode", @"1", @"consume_num", self.shouldAlsoString, @"card_current_bill_return_amount", self.availableCreditString, @"card_usable_amount", nil] Success:^(NSDictionary *obj) {
//            [self pushViewControl:@"MakeSureIntelligentPlanViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.packageString, @"packageString", self.baseMoneyString, @"baseMoneyString", [NSString stringWithFormat:@"%@", self.saturdayBOOL ? @"1" : @"0"], @"haveZhouliu", [NSString stringWithFormat:@"%@", self.sundayBOOL ? @"1" : @"0"], @"haveZhouRi", self.modeTypeString, @"modeType", [NSString stringWithFormat:@"%@", self.leShuaBOOL ? @"1" : @"0"], @"leshua", [NSString stringWithFormat:@"%@", self.fuLingMengBOOL ? @"1" : @"0"], @"fulingmen", self.totalNumberTextField.text, @"number", self.needToPlanModel, @"needToPlanModel", self.shouldAlsoString, @"shouldAlsoString", self.availableCreditString, @"availableCreditString", nil]];
//        }];
        
        
    }
}

-(void)setMode{
    self.selectOperationTypeView.hidden = NO;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.dataArray) {
        [array addObject:dic[@"desc"]];
    }
    self.selectOperationTypeView.typeArray = array;
}

-(void)saturday{
    self.saturdayBOOL = !self.saturdayBOOL;
}

-(void)sunday{
    self.sundayBOOL = !self.sundayBOOL;
}

-(void)leShua{
    self.leShuaBOOL = YES;
}

-(void)fuLingMeng{
    self.fuLingMengBOOL = !self.fuLingMengBOOL;
}


-(void)createUI{
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_setIntelligenPlan_banner, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 130)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"规划日期", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 224, 90, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"规划模式", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 288, 90, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"通道选择", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 352, 90, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"消费总笔数", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 416, 90, 15)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 262, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 326, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 390, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 455, 360, 1)];
    
    UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(107.5 * self.baseicFloat, 160.5 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 120 * self.baseicFloat, 14 * self.baseicFloat)];
    NSMutableAttributedString *dayString = [[NSMutableAttributedString alloc] initWithString:@"周一至周五(必选)" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12 * self.baseicFloat],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    [dayString addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize: 16 * self.baseicFloat]} range:NSMakeRange(0, 5)];
    dayLabel.attributedText = dayString;
    [self.view addSubview:dayLabel];
    
    _modelLabel = [[UILabel alloc] initWithFrame:CGRectMake( 108 * self.baseicFloat, 223 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 200 * self.baseicFloat, 15.5 * self.baseicFloat)];
    NSMutableAttributedString *modelString = [[NSMutableAttributedString alloc] initWithString:@"资金不过夜(当天还,当天刷)" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: 12 * self.baseicFloat],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    [modelString addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize: 16 * self.baseicFloat]} range:NSMakeRange(0, 5)];
    _modelLabel.attributedText = modelString;
    [self.view addSubview:_modelLabel];
    
    UILabel *instructionsLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"规划说明：\n1、系统规划的时间段为当前日期到该卡片最后还款日前一天\n2、系统规划会自动控制卡片可用余额，禁止对卡片进行超额消费\n3、若您需在还款日后到下一期账单日前进行消费，可前往卡片管理 >添加资金动向>添加消费\n4、若您选择的卡片套餐有控制负债，系统会自动规划在还款日后下一期账单日期间进行还款操作，请勿在该期间去进行消费以保证有效控制卡片负债率\n5、卡片本期应还金额，可以余额请输入精确金额，本身系统会自动计算本期卡片应还金额，卡片可用余额，可手动去对应银行查询，再做修正，点击创建规划会同步修改卡片该俩条数据，请谨慎操作", 1, 129, 130, 134, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 554, 345, 300)];
    instructionsLabel.numberOfLines = 0;
    [instructionsLabel sizeToFit];
    
    
    
}

-(UIButton *)saturdayButton{
    if (!_saturdayButton) {
        _saturdayButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"周六", 2, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 240, 219, 55, 24)];
        [_saturdayButton setImage:[UIImage imageNamed:icon_gh_wx] forState:UIControlStateNormal];
        [_saturdayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -_saturdayButton.frame.size.width, 0, 0)];
        
    }
    return _saturdayButton;
}

-(UIButton *)sundayButton{
    if (!_sundayButton) {
        _sundayButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"周日", 2, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 300, 219, 55, 24)];
        [_sundayButton setImage:[UIImage imageNamed:icon_gh_wx] forState:UIControlStateNormal];
        [_sundayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -_sundayButton.frame.size.width, 0, 0)];
    }
    return _sundayButton;
}

-(UIButton *)leShuaButton{
    if (!_leShuaButton) {
        _leShuaButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"乐刷", 2, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 109, 347, 55, 24)];
        [_leShuaButton setImage:[UIImage imageNamed:icon_gh_wx] forState:UIControlStateNormal];
        [_leShuaButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -_leShuaButton.frame.size.width, 0, 0)];
    }
    return _leShuaButton;
}

-(UIButton *)fuLingMengButton{
    if (!_fuLingMengButton) {
//        _fuLingMengButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"付临门", 2, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 169, 347, 55, 24)];
//        [_fuLingMengButton setImage:[UIImage imageNamed:icon_gh_wx] forState:UIControlStateNormal];
//        [_fuLingMengButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -_fuLingMengButton.frame.size.width, 0, 0)];
    }
    return _fuLingMengButton;
}

-(void)setSaturdayBOOL:(BOOL)saturdayBOOL{
    _saturdayBOOL = saturdayBOOL;
    if (saturdayBOOL) {
        [self.saturdayButton setImage:[UIImage imageNamed:icon_td] forState:UIControlStateNormal];
        [self.saturdayButton setTitleColor:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        [self.saturdayButton setImage:[UIImage imageNamed:icon_gh_wx] forState:UIControlStateNormal];
        [self.saturdayButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
    }
}

-(void)setSundayBOOL:(BOOL)sundayBOOL{
    _sundayBOOL = sundayBOOL;
    if (sundayBOOL) {
        [self.sundayButton setImage:[UIImage imageNamed:icon_td] forState:UIControlStateNormal];
        [self.sundayButton setTitleColor:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        [self.sundayButton setImage:[UIImage imageNamed:icon_gh_wx] forState:UIControlStateNormal];
        [self.sundayButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
    }
}

-(void)setLeShuaBOOL:(BOOL)leShuaBOOL{
    _leShuaBOOL = leShuaBOOL;
    if (leShuaBOOL) {
        [self.leShuaButton setImage:[UIImage imageNamed:icon_td] forState:UIControlStateNormal];
        [self.leShuaButton setTitleColor:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        [self.leShuaButton setImage:[UIImage imageNamed:icon_gh_wx] forState:UIControlStateNormal];
        [self.leShuaButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
    }
}

-(void)setFuLingMengBOOL:(BOOL)fuLingMengBOOL{
    _fuLingMengBOOL = fuLingMengBOOL;
    if (fuLingMengBOOL) {
        [self.fuLingMengButton setImage:[UIImage imageNamed:icon_td] forState:UIControlStateNormal];
        [self.fuLingMengButton setTitleColor:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        [self.fuLingMengButton setImage:[UIImage imageNamed:icon_gh_wx] forState:UIControlStateNormal];
        [self.fuLingMengButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
    }
}

-(UITextField *)totalNumberTextField{
    if (!_totalNumberTextField) {
        _totalNumberTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"输入总消费总笔数", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 109, 412, 250, 23)];
    }
    return _totalNumberTextField;
}

-(UIButton *)createPlanButton{
    if (!_createPlanButton) {
        _createPlanButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"创建规划", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 485, 345, 44)];
    }
    return _createPlanButton;
}

-(UIImageView *)setModeButton{
    if (!_setModeButton) {
        _setModeButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 342, 279, 27, 32)];
        _setModeButton.contentMode = UIViewContentModeCenter;
    }
    return _setModeButton;
}

-(SelectOperationTypeView *)selectOperationTypeView{
    if (!_selectOperationTypeView) {
        _selectOperationTypeView = [[SelectOperationTypeView alloc]init];
        _selectOperationTypeView.titleString = @"模式选择";
        _selectOperationTypeView.delegate = self;
        [self.view addSubview:_selectOperationTypeView];
    }
    return _selectOperationTypeView;
}

@end
