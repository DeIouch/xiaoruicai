//
//  TodayOperationCardTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/11.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "TodayOperationCardTableViewCell.h"

@interface TodayOperationCardTableViewCell ()

/**
 银行图标
 */
@property(nonatomic, strong)UIImageView *bankIconImageView;

/**
 银行名称
 */
@property(nonatomic, strong)UILabel *bankNameLabel;

/**
 银行卡信息
 */
@property(nonatomic, strong)UILabel *bankInfoLabel;

/**
 操作按钮
 */
@property(nonatomic, strong)UIButton *bankOperationButton;

/**
 额度信息
 */
@property(nonatomic, strong)UILabel *limitLabel;

/**
 笔数信息
 */
@property(nonatomic, strong)UILabel *numberLabel;

/**
 额度类型
 */
@property(nonatomic, strong)UILabel *limitStateLabel;

/**
 笔数类型
 */
@property(nonatomic, strong)UILabel *numberStateLabel;

/**
 立即消费
 */
@property(nonatomic, strong)UIButton *immediateConsumptionButton;

/**
 立即还款
 */
@property(nonatomic, strong)UIButton *immediateRepaymentButton;

/**
 已消费
 */
@property(nonatomic, strong)UIButton *consumptionedButton;

/**
 已还款
 */
@property(nonatomic, strong)UIButton *repaymentedButton;

@end


@implementation TodayOperationCardTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15 * (DelouchWidth / 375.0), 5 * (DelouchWidth / 375.0), 345 * (DelouchWidth / 375.0), 117 * (DelouchWidth / 375.0))];
        view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        view.layer.shadowColor = [UIColor colorWithRed:36/255.0 green:37/255.0 blue:44/255.0 alpha:0.07].CGColor;
        view.layer.shadowOffset = CGSizeMake(0,2);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 11;
        view.layer.cornerRadius = 8;
        [self.contentView addSubview:view];
    }
    return self;
}


-(void)immediateConsumption{
    self.todayOperationCardImmediateConsumptionBlock(_todayPlanListModel);
}

-(void)consumptioned{
    
}

-(void)immediateRepayment{
    self.todayOperationCardImmediateRepaymentBlock(_todayPlanListModel);
}

-(void)repaymented{
    
}

-(UIImageView *)bankIconImageView{
    if (!_bankIconImageView) {
        _bankIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 15, 23, 23)];
    }
    return _bankIconImageView;
}

-(UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 26, 26, 26, 1, 255, 255, 255, 1, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 55, 20, 65, 14)];
        _bankNameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14 * (DelouchWidth / 375.0)];
    }
    return _bankNameLabel;
}

-(UILabel *)bankInfoLabel{
    if (!_bankInfoLabel) {
        _bankInfoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 120, 20, 150, 14)];
    }
    return _bankInfoLabel;
}

-(UILabel *)limitLabel{
    if (!_limitLabel) {
        _limitLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 0, 0, 0, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 63, 130, 19)];
    }
    return _limitLabel;
}

-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 0, 0, 0, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 164, 63, 48, 19)];
    }
    return _numberLabel;
}

-(UILabel *)limitStateLabel{
    if (!_limitStateLabel) {
        _limitStateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 23, 86, 51, 12)];
    }
    return _limitStateLabel;
}

-(UILabel *)numberStateLabel{
    if (!_numberStateLabel) {
        _numberStateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 164, 86, 51, 12)];
    }
    return _numberStateLabel;
}

-(void)setBankIconString:(NSString *)bankIconString{
//    [self.bankIconImageView sd_setImageWithURL:[NSURL URLWithString:bankIconString] placeholderImage:[UIImage imageNamed:zwt_yuan_128]];
    self.bankIconImageView.image = [UIImage imageNamed:bankIconString];
}

-(void)setBankNameString:(NSString *)bankNameString{
    self.bankNameLabel.text = bankNameString;
    self.bankIconString = [NSString stringWithFormat:@"logo_%@80.png",bankNameString];
}

-(void)setBankInfoString:(NSString *)bankInfoString{
    self.bankInfoLabel.text = bankInfoString;
}

-(void)setLimitString:(NSString *)limitString{
//    self.limitLabel.text = limitString;
    [DelouchLibrary setMoneyLabel:self.limitLabel moneyText:limitString bigFont:21 smallFont:12];
}

-(void)setNumberString:(NSString *)numberString{
    self.numberLabel.text = numberString;
    [DelouchLibrary setDicBoldFont:self.numberLabel font:21];
}

/**
 操作类型

 @param operationStateString 操作码
 
 0  消费类型    立即消费
 1  消费类型    已消费
 2  还款类型    立即还款
 3  还款类型    已还款
 */
-(void)setOperationStateString:(NSString *)operationStateString{
    switch ([operationStateString intValue]) {
        case 2:
            {
                self.limitStateLabel.text = @"消费额度";
                self.numberStateLabel.text = @"消费笔数";
                [self.immediateConsumptionButton addTarget:self action:@selector(immediateConsumption) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
//        case 1:
//            {
//                self.limitStateLabel.text = @"消费额度";
//                self.numberStateLabel.text = @"消费笔数";
//                [self.consumptionedButton addTarget:self action:@selector(consumptioned) forControlEvents:UIControlEventTouchUpInside];
//            }
//            break;
            
        case 1:
            {
                self.limitStateLabel.text = @"还款额度";
                self.numberStateLabel.text = @"还款笔数";
                [self.immediateRepaymentButton addTarget:self action:@selector(immediateRepayment) forControlEvents:UIControlEventTouchUpInside];
            }
            break;

//        case 3:
//            {
//                self.limitStateLabel.text = @"还款额度";
//                self.numberStateLabel.text = @"还款笔数";
//                [self.repaymentedButton addTarget:self action:@selector(repaymented) forControlEvents:UIControlEventTouchUpInside];
//            }
            break;
            
        default:
            break;
    }
}

-(UIButton *)immediateConsumptionButton{
    if (!_immediateConsumptionButton) {
        _immediateConsumptionButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"立即消费", 2, 255, 255, 255, 1, 86, 112, 254, 1, 13, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 255, 66, 80, 29)];
        [DelouchLibrary setbuttonLayer:_immediateConsumptionButton layerMask:15];
    }
    return _immediateConsumptionButton;
}

-(UIButton *)immediateRepaymentButton{
    if (!_immediateRepaymentButton) {
        _immediateRepaymentButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"立即还款", 2, 255, 255, 255, 1, 86, 112, 254, 1, 13, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 255, 66, 80, 29)];
        [DelouchLibrary setbuttonLayer:_immediateRepaymentButton layerMask:15];
    }
    return _immediateRepaymentButton;
}

-(UIButton *)consumptionedButton{
    if (!_consumptionedButton) {
        _consumptionedButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"已消费", 2, 204, 204, 204, 1, 245, 245, 245, 1, 13, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 255, 66, 80, 29)];
        [DelouchLibrary setbuttonLayer:_consumptionedButton layerMask:15];
    }
    return _consumptionedButton;
}

-(UIButton *)repaymentedButton{
    if (!_repaymentedButton) {
        _repaymentedButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"已还款", 2, 204, 204, 204, 1, 245, 245, 245, 1, 13, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 255, 66, 80, 29)];
        [DelouchLibrary setbuttonLayer:_repaymentedButton layerMask:15];
    }
    return _repaymentedButton;
}

-(void)setTodayPlanListModel:(TodayPlanListModel *)todayPlanListModel{
    _todayPlanListModel = todayPlanListModel;
}

@end
