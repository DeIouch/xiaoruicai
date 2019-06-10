//
//  TodayOperationImmediateRepaymentTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "TodayOperationImmediateRepaymentTableViewCell.h"

@interface TodayOperationImmediateRepaymentTableViewCell ()

/**
 还款金额
 */
@property(nonatomic, strong)UILabel *repaymentMoneyLabel;

/**
 还款日期
 */
@property(nonatomic, strong)UILabel *repaymentDateLabel;

/**
 确认还款
 */
@property(nonatomic, strong)UIButton *makeSureRepaymentButton;

/**
 已还款
 */
@property(nonatomic, strong)UIButton *repaymentedButton;

@end

@implementation TodayOperationImmediateRepaymentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 70, 375, 1)];
    }
    return self;
}

-(UILabel *)repaymentMoneyLabel{
    if (!_repaymentMoneyLabel) {
        _repaymentMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 19, 200, 18)];
    }
    return _repaymentMoneyLabel;
}

-(UILabel *)repaymentDateLabel{
    if (!_repaymentDateLabel) {
        _repaymentDateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 42, 200, 12)];
    }
    return _repaymentDateLabel;
}

-(UIButton *)makeSureRepaymentButton{
    if (!_makeSureRepaymentButton) {
        _makeSureRepaymentButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"确认还款", 2, 255, 255, 255, 1, 86, 112, 254, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 23, 68, 26)];
        [DelouchLibrary setbuttonLayer:_makeSureRepaymentButton layerMask:13];
    }
    return _makeSureRepaymentButton;
}

-(UIButton *)repaymentedButton{
    if (!_repaymentedButton) {
        _repaymentedButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"已还款", 2, 255, 255, 255, 1, 204, 204, 204, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 23, 68, 26)];
        [DelouchLibrary setbuttonLayer:_repaymentedButton layerMask:13];
    }
    return _repaymentedButton;
}

-(void)setRepaymentMoneyString:(NSString *)repaymentMoneyString{
//    self.repaymentMoneyLabel.text = repaymentMoneyString;
    [DelouchLibrary setMoneyLabel:self.repaymentMoneyLabel moneyText:repaymentMoneyString bigFont:18 smallFont:12];
}

-(void)setRepaymentDateString:(NSString *)repaymentDateString{
    self.repaymentDateLabel.text = repaymentDateString;
}

/**
 还款类型

 @param repaymentTypeString     0、未还款   1、已还款
 */
-(void)setRepaymentTypeString:(NSString *)repaymentTypeString{
    switch ([repaymentTypeString intValue]) {
        case 1:
            [self.repaymentedButton addTarget:self action:@selector(repaymented) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        default:
            {
                [self.makeSureRepaymentButton addTarget:self action:@selector(makeSureRepayment) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
    }
}

-(void)repaymented{
    
}

-(void)setPlanOperationalModel:(PlanOperationalModel *)planOperationalModel{
    _planOperationalModel = planOperationalModel;
}

-(void)makeSureRepayment{
    self.todayOperationImmediateRepaymentBlock(_planOperationalModel);
}

@end
