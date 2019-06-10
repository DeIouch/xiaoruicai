//
//  CardManageBillingDetailsHeadView.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CardManageBillingDetailsHeaderView.h"

@interface CardManageBillingDetailsHeaderView ()

/**
 月份
 */
@property(nonatomic, strong)UILabel *mouthLabel;

/**
 日期
 */
@property(nonatomic, strong)UILabel *dateLabel;

/**
 金额
 */
@property(nonatomic, strong)UILabel *moneyNumberLabel;

/**
 还款金额
 */
@property(nonatomic, strong)UILabel *repaymentMoneyNumberLabel;

/**
 出帐日期
 */
@property(nonatomic, strong)UILabel *outAccountDayLabel;

/**
 还款日期
 */
@property(nonatomic, strong)UILabel *repaymentDayLabel;

/**
 更新账单
 */
@property(nonatomic, strong)UIButton *updateBillButton;

/**
 展开收缩
 */
@property(nonatomic, strong)UIImageView *showMoreButton;

@end

@implementation CardManageBillingDetailsHeaderView

-(UIView *)initWithFrame:(CGRect)viewFrame{
    if (self = [super initWithFrame:viewFrame]) {
        self.frame = viewFrame;
        self.backgroundColor = [UIColor whiteColor];
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(238, 238, 238, 1, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 15, 69, 360, 1)];
    }
    return self;
}

-(void)updateBill{
    
}

-(void)showMore{
    
}

-(UIImageView *)showMoreButton{
    if (!_showMoreButton) {
        _showMoreButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_zdmx_xl, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 336, 19, 30, 27)];
        _showMoreButton.contentMode = UIViewContentModeCenter;
    }
    return _showMoreButton;
}

-(UILabel *)mouthLabel{
    if (!_mouthLabel) {
        _mouthLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 0, 0, 0, 1, 255, 255, 255, 2, 18, YES, self) setFrame:DelouchFrameMake(FrameCellView, 21, 20, 100, 17)];
    }
    return _mouthLabel;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self) setFrame:DelouchFrameMake(FrameCellView, 20, 40, 150, 11)];
    }
    return _dateLabel;
}

-(UILabel *)moneyNumberLabel{
    if (!_moneyNumberLabel) {
        _moneyNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self) setFrame:DelouchFrameMake(FrameCellView, 250, 27, 90, 18)];
    }
    return _moneyNumberLabel;
}

-(UILabel *)outAccountDayLabel{
    if (!_outAccountDayLabel) {
        _outAccountDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 253, 24, 35, 1, 255, 255, 255, 2, 12, YES, self) setFrame:DelouchFrameMake(FrameCellView, 259, 40, 81, 12)];
    }
    return _outAccountDayLabel;
}

-(UILabel *)repaymentDayLabel{
    if (!_repaymentDayLabel) {
        _repaymentDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 253, 24, 35, 1, 255, 255, 255, 2, 12, YES, self) setFrame:DelouchFrameMake(FrameCellView, 259, 40, 81, 12)];
    }
    return _repaymentDayLabel;
}

-(UIButton *)updateBillButton{
    if (!_updateBillButton) {
        _updateBillButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"更新账单", 2, 255, 255, 255, 1, 255, 68, 32, 1, 12, YES, self) setFrame:DelouchFrameMake(FrameCellView, 292, 22, 68, 26)];
        [DelouchLibrary setbuttonLayer:_updateBillButton layerMask:13];
    }
    return _updateBillButton;
}

-(void)setMouthString:(NSString *)mouthString{
    self.mouthLabel.text = mouthString;
}

-(void)setDateString:(NSString *)dateString{
    self.dateLabel.text = dateString;
}

-(void)setMoneyNumberString:(NSString *)moneyNumberString{
//    self.moneyNumberLabel.text = moneyNumberString;
    [DelouchLibrary setMoneyLabel:self.moneyNumberLabel moneyText:moneyNumberString bigFont:18 smallFont:12];
}

/**
 账单类型

 @param billTypeString 账单类型： 1，未更新账单    2，出帐账单  3、还款账单
 */
-(void)setBillTypeString:(NSString *)billTypeString{
    switch ([billTypeString intValue]) {
        case 0:
            {
                [self.updateBillButton addTarget:self action:@selector(updateBill) forControlEvents:UIControlEventTouchUpInside];
                self.moneyNumberLabel.hidden = YES;
            }
            break;
            
        case 1:
            {
                self.outAccountDayLabel.text = [NSString stringWithFormat:@"%@天后出账", _endDayString];
                [self.showMoreButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMore)]];
            }
            break;
            
        case 2:
            {
                self.repaymentDayLabel.text = [NSString stringWithFormat:@"%@天后还款", _endDayString];
                [self.showMoreButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMore)]];
            }
            break;
            
        default:
            break;
    }
}

-(void)setEndDayString:(NSString *)endDayString{
    _endDayString = endDayString;
}

-(UILabel *)repaymentMoneyNumberLabel{
    if (!_repaymentMoneyNumberLabel) {
        _repaymentMoneyNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self) setFrame:DelouchFrameMake(FrameCellView, 250, 27, 90, 18)];
    }
    return _repaymentMoneyNumberLabel;
}

-(void)setRepaymentMoneyNumberString:(NSString *)repaymentMoneyNumberString{
//    self.repaymentMoneyNumberLabel.text = repaymentMoneyNumberString;
    [DelouchLibrary setMoneyLabel:self.repaymentMoneyNumberLabel moneyText:repaymentMoneyNumberString bigFont:18 smallFont:12];
    [self.showMoreButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMore)]];
}



@end
