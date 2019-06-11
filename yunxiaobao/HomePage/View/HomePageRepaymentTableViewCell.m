//
//  HomePageRepaymentTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/11.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageRepaymentTableViewCell.h"

@interface HomePageRepaymentTableViewCell ()

/**
 银行icon
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
 剩余额度
 */
@property(nonatomic, strong)UILabel *remainingLabel;

/**
 本期应还
 */
@property(nonatomic, strong)UILabel *shouldAsloLabel;

/**
 到期日期
 */
@property(nonatomic, strong)UILabel *endTimeLabel;

/**
 剩余天数
 */
@property(nonatomic, strong)UILabel *endDayLabel;

/**
 到期说明
 */
@property(nonatomic, strong)UILabel *endInstrucLabel;

/**
 还款状态
 */
@property(nonatomic, strong)UILabel *asloStateLabel;

/**
 规划状态
 */
@property(nonatomic, strong)UIImageView *planStateImageView;

@end

@implementation HomePageRepaymentTableViewCell

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
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"剩余额度", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 26, 95, 69, 14)];
    }
    return self;
}

-(UIImageView *)bankIconImageView{
    if (!_bankIconImageView) {
        _bankIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 27, 27, 19, 19)];
    }
    return _bankIconImageView;
}

-(UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 26, 26, 26, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 54, 30, 65, 16)];
        _bankNameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14 * (DelouchWidth / 375.0)];
    }
    return _bankNameLabel;
}

-(UILabel *)bankInfoLabel{
    if (!_bankInfoLabel) {
        _bankInfoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 120, 30, 200, 16)];
    }
    return _bankInfoLabel;
}

-(UILabel *)remainingLabel{
    if (!_remainingLabel) {
        _remainingLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 0, 0, 0, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 26, 72, 128, 21)];
    }
    return _remainingLabel;
}

-(UILabel *)shouldAsloLabel{
    if (!_shouldAsloLabel) {
        _shouldAsloLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 0, 0, 0, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 154, 73, 100, 16)];
    }
    return _shouldAsloLabel;
}

-(UILabel *)endDayLabel{
    if (!_endDayLabel) {
        _endDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 255, 68, 32, 1, 255, 255, 255, 2, 35, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 216, 77, 65, 26)];
        
    }
    return _endDayLabel;
}

-(UILabel *)endInstrucLabel{
    if (!_endInstrucLabel) {
        _endInstrucLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 153, 95, 69, 14)];
    }
    return _endInstrucLabel;
}

-(UILabel *)endTimeLabel{
    if (!_endTimeLabel) {
        _endTimeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 283, 91, 76, 13)];
    }
    return _endTimeLabel;
}

-(UILabel *)asloStateLabel{
    if (!_asloStateLabel) {
        _asloStateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 283, 76, 88, 14)];
    }
    return _asloStateLabel;
}

-(UIImageView *)planStateImageView{
    if(!_planStateImageView){
        _planStateImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 315, 1, 50, 50)];
    }
    return _planStateImageView;
}

-(void)setBankIconString:(NSString *)bankIconString{
    self.bankIconImageView.image = [UIImage imageNamed:bankIconString];
}

-(void)setBankNameString:(NSString *)bankNameString{
    self.bankNameLabel.text = bankNameString;
    self.bankIconString = [NSString stringWithFormat:@"logo_%@80.png", bankNameString];
}

-(void)setBankInfoString:(NSString *)bankInfoString{
    self.bankInfoLabel.text = bankInfoString;
}

-(void)setRemainingString:(NSString *)remainingString{
    [DelouchLibrary setMoneyLabel:self.remainingLabel moneyText:remainingString bigFont:21 smallFont:12];
}

-(void)setShouldAsloString:(NSString *)shouldAsloString{
    [DelouchLibrary setMoneyLabel:self.shouldAsloLabel moneyText:shouldAsloString bigFont:21 smallFont:12];
}

-(void)setEndDayString:(NSString *)endDayString{
//    self.endDayLabel.text = endDayString;
    if ([_asloStateString isEqualToString:@"2"]) {
        self.asloStateLabel.text = [NSString stringWithFormat:@"逾期%@天", endDayString];
    }else{
        self.endDayLabel.text = endDayString;
    }
}

-(void)setEndTimeString:(NSString *)endTimeString{
    self.endTimeLabel.text = endTimeString;
}

-(void)setAsloStateString:(NSString *)asloStateString{
    _asloStateString = asloStateString;
    switch ([asloStateString intValue]) {
        case 0:
            {
                self.remainingLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
                self.shouldAsloLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
                self.endDayLabel.textColor = [UIColor colorWithRed:255 / 255.0 green:68 / 255.0 blue:32 / 255.0 alpha:1];
                self.endInstrucLabel.text = @"本期应还";
                self.asloStateLabel.textColor = [UIColor colorWithRed:255 / 255.0 green:68 / 255.0 blue:32 / 255.0 alpha:1];
                self.asloStateLabel.text = @"天后到期";
            }
            break;
            
        case 1:
            {
                self.remainingLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
                self.shouldAsloLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
                self.endDayLabel.textColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.7];
                self.endInstrucLabel.text = @"未出账单";
                self.asloStateLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:0.7];
                self.asloStateLabel.text = @"天后出账";
            }
            break;
            
        case 2:
            {
                self.remainingLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
                self.shouldAsloLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
                self.endDayLabel.textColor = [UIColor colorWithRed:255 / 255.0 green:68 / 255.0 blue:32 / 255.0 alpha:1];
                self.endInstrucLabel.text = @"本期应还";
                self.asloStateLabel.textColor = [UIColor colorWithRed:255 / 255.0 green:68 / 255.0 blue:32 / 255.0 alpha:1];
//                self.asloStateLabel.text = @"天后出账";
            }
            break;
            
        default:
            break;
    }
}

-(void)setPlanStateString:(NSString *)planStateString{
    if([planStateString isEqualToString:@"1"]){
        self.planStateImageView.image = [UIImage imageNamed:iocn_ygh];
    }else{
        self.planStateImageView.image = [UIImage imageNamed:iocn_kgh];
    }
}

@end
