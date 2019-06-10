//
//  CardListTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CardListTableViewCell.h"

@interface CardListTableViewCell ()

/**
 背景图片
 */
@property(nonatomic, strong)UIImageView *backImageView;

/**
 银行icon
 */
@property(nonatomic, strong)UIImageView *bankIconImageView;

/**
 银行名称
 */
@property(nonatomic, strong)UILabel *bankNameLabel;

/**
 银行卡尾号
 */
@property(nonatomic, strong)UILabel *bankNumberLabel;

/**
 本期应还
 */
@property(nonatomic, strong)UILabel *shouldAlsoLabel;

/**
 总金额(元)
 */
@property(nonatomic, strong)UILabel *totalAmountLabel;

/**
 账单日
 */
@property(nonatomic, strong)UILabel *billDayLabel;

/**
 还款日
 */
@property(nonatomic, strong)UILabel *reimbursementDayLabel;

@end

@implementation CardListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    }
    return self;
}

-(UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 5, 345, 138)];
    }
    return _backImageView;
}

-(UIImageView *)bankIconImageView{
    if (!_bankIconImageView) {
        _bankIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 30, 25, 32, 32)];
    }
    return _bankIconImageView;
}

-(UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 72, 28, 200, 14)];
    }
    return _bankNameLabel;
}

-(UILabel *)bankNumberLabel{
    if (!_bankNumberLabel) {
        _bankNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 10, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 72, 46, 200, 10)];
    }
    return _bankNumberLabel;
}

-(UILabel *)shouldAlsoLabel{
    if (!_shouldAlsoLabel) {
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"本期应还", 1, 255, 255, 255, 0.6, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 39, 90, 78, 12)];
        _shouldAlsoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 36, 111, 68, 12)];
    }
    return _shouldAlsoLabel;
}

-(UILabel *)totalAmountLabel{
    if (!_totalAmountLabel) {
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"总金额(元)", 1, 255, 255, 255, 0.6, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 134, 90, 78, 12)];
        _totalAmountLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 134, 111, 68, 12)];
    }
    return _totalAmountLabel;
}

-(UILabel *)billDayLabel{
    if (!_billDayLabel) {
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"账单日", 1, 255, 255, 255, 0.6, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 234, 90, 78, 12)];
        _billDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 234, 111, 68, 12)];
    }
    return _billDayLabel;
}

-(UILabel *)reimbursementDayLabel{
    if (!_reimbursementDayLabel) {
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"还款日", 1, 255, 255, 255, 0.6, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 307, 90, 78, 12)];
        _reimbursementDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 307, 111, 68, 12)];
    }
    return _reimbursementDayLabel;
}

-(void)setBankNameString:(NSString *)bankNameString{
    self.bankNameLabel.text = bankNameString;
}

-(void)setBankNumberString:(NSString *)bankNumberString{
    self.bankNumberLabel.text = bankNumberString;
}

-(void)setShouldAlsoString:(NSString *)shouldAlsoString{
//    self.shouldAlsoLabel.text = shouldAlsoString;
    [DelouchLibrary setMoneyLabel:self.shouldAlsoLabel moneyText:shouldAlsoString bigFont:14 smallFont:10];
}

-(void)setTotalAmountString:(NSString *)totalAmountString{
//    self.totalAmountLabel.text = totalAmountString;
    [DelouchLibrary setMoneyLabel:self.totalAmountLabel moneyText:totalAmountString bigFont:14 smallFont:10];
}

-(void)setBillDayString:(NSString *)billDayString{
    self.billDayLabel.text = billDayString;
    [DelouchLibrary setDicBoldFont:self.billDayLabel font:14];
}

-(void)setReimbursementDayString:(NSString *)reimbursementDayString{
    self.reimbursementDayLabel.text = reimbursementDayString;
    [DelouchLibrary setDicBoldFont:self.reimbursementDayLabel font:14];
}

-(void)setBackString:(NSString *)backString{
//    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:backString] placeholderImage:[UIImage imageNamed:bg_BankCard_jh]];
    
    self.backImageView.image = [UIImage imageNamed:backString];
    
}

-(void)setBankIconString:(NSString *)bankIconString{
//    [self.bankIconImageView sd_setImageWithURL:[NSURL URLWithString:bankIconString] placeholderImage:[UIImage imageNamed:zwt_yuan_128]];
    
    self.bankIconImageView.image = [UIImage imageNamed:bankIconString];
}

@end
