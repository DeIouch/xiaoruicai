//
//  CardManageAddConsumptionPlanedViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageAddConsumptionPlanedViewController.h"

@interface CardManageAddConsumptionPlanedViewController ()<UITextFieldDelegate>

/**
 确认添加
 */
@property(nonatomic, strong)UIButton *saveButton;

/**
 备注输入框
 */
@property(nonatomic, strong)UITextField *noteTextField;

/**
 备注字数
 */
@property(nonatomic, strong)UILabel *noteNumberLabel;

/**
 备注字数
 */
@property(nonatomic, assign)NSInteger noteNumber;

/**
 消费金额
 */
@property(nonatomic, strong)UITextField *consumptionAmountTextField;

/**
 消费时间
 */
@property(nonatomic, strong)UILabel *timeLabel;

/**
 选择时间按钮
 */
@property(nonatomic, strong)UIImageView *chooseTimeButton;

@end

@implementation CardManageAddConsumptionPlanedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"添加消费";
}

-(void)createUI{
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"消费金额", 1, 51, 51, 51, 1, 255, 255, 255, 2, 15, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 85, 80, 15)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(229, 229, 229, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 119, 375, 1)];
    
    [self.saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    self.noteTextField.delegate = self;
    self.noteNumber = 0;
    self.consumptionAmountTextField.placeholder = @"输入需要消费的金额";
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"消费时间", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 140, 80, 16)];
    
    [self.chooseTimeButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTime)]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    self.timeLabel.text = currentTimeString;
}

-(void)chooseTime{
    [BRDatePickerView showDatePickerWithTitle:nil dateType:BRDatePickerModeMDHM defaultSelValue:nil resultBlock:^(NSString *selectValue) {
        self.timeLabel.text = selectValue;
    }];
}

-(void)save{
    if (self.consumptionAmountTextField.text.length == 0 || self.noteTextField.text.length == 0) {
        self.notiString = @"数据请输入完整";
    }
//    else if([self.consumptionAmountTextField.text intValue] > [self.cardListModel.card_usable_amount intValue]) {
//        self.notiString = @"消费金额不能大于信用卡余额";
//    }
    else{
        [self urlHeadStr:AppCardsURL urlStr:UrlCardsAmountEditSbt parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", self.cardListModel.card_id, @"card_id", self.consumptionAmountTextField.text, @"consume_amount", self.noteTextField.text, @"deal_type_name", [NSString stringWithFormat:@"%@", self.timeLabel.text], @"consume_time", nil] Success:^(NSDictionary *obj) {
            self.notiString = @"添加成功";
            [self popVC];
        }];
    }
}

-(UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"确认添加", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 309, 345, 44)];
        [self setbuttonLayer:_saveButton layerMask:3];
    }
    return _saveButton;
}

-(UITextField *)noteTextField{
    if (!_noteTextField) {
        _noteTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"备注", NO, NO, 51, 51, 51, 1, 0, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 194, 345, 17)];
    }
    return _noteTextField;
}

-(UILabel *)noteNumberLabel{
    if (!_noteNumberLabel) {
        _noteNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 153, 153, 153, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 160, 219, 200, 14)];
    }
    return _noteNumberLabel;
}

-(void)setNoteNumber:(NSInteger)noteNumber{
    self.noteNumberLabel.text = [NSString stringWithFormat:@"(%ld/10)", noteNumber];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL isAllowEdit = YES;
    if([string length] > range.length && [textField.text length] + [string length] - range.length > 10)
    {
        isAllowEdit = NO;
    }
    self.noteNumber = textField.text.length;
    return isAllowEdit;
}

-(UITextField *)consumptionAmountTextField{
    if (!_consumptionAmountTextField) {
        _consumptionAmountTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"输入需要消费的金额", NO, NO, 51, 51, 51, 1, 0, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 107, 75, 253, 35)];
    }
    return _consumptionAmountTextField;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 107, 140, 233, 17)];
    }
    return _timeLabel;
}

-(UIImageView *)chooseTimeButton{
    if (!_chooseTimeButton) {
        _chooseTimeButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 345, 133, 26, 29)];
        _chooseTimeButton.contentMode = UIViewContentModeCenter;
    }
    return _chooseTimeButton;
}

@end
