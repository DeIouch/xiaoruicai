//
//  CardManageUpMoneyRecordTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageUpMoneyRecordTableViewCell.h"

@interface CardManageUpMoneyRecordTableViewCell ()

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
 固定额度
 */
@property(nonatomic, strong)UILabel *fixedQuotaLabel;

/**
 临时额度
 */
@property(nonatomic, strong)UILabel *temporaryLinesLabel;

/**
 卡贷额度
 */
@property(nonatomic, strong)UILabel *cardCreditLimitLabel;

@end

@implementation CardManageUpMoneyRecordTableViewCell

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
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"固定额度下降", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 26, 95, 69, 14)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"固定额度提升", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 143, 95, 69, 14)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"临时额度提升", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 260, 95, 69, 14)];
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
    }
    return _bankNameLabel;
}

-(UILabel *)bankInfoLabel{
    if (!_bankInfoLabel) {
        _bankInfoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 120, 29, 200, 16)];
    }
    return _bankInfoLabel;
}

-(UILabel *)fixedQuotaLabel{
    if (!_fixedQuotaLabel) {
        _fixedQuotaLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 0, 0, 0, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 26, 72, 128, 21)];
    }
    return _fixedQuotaLabel;
}

-(UILabel *)temporaryLinesLabel{
    if (!_temporaryLinesLabel) {
        _temporaryLinesLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 0, 0, 0, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 144, 73, 100, 16)];
    }
    return _temporaryLinesLabel;
}

-(UILabel *)cardCreditLimitLabel{
    if (!_cardCreditLimitLabel) {
        _cardCreditLimitLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 0, 0, 0, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 262, 73, 100, 16)];
    }
    return _cardCreditLimitLabel;
}

-(void)setBankIconString:(NSString *)bankIconString{
//    [self.bankIconImageView sd_setImageWithURL:[NSURL URLWithString:bankIconString] placeholderImage:[UIImage imageNamed:zwt_yuan_128]];
}

-(void)setBankNameString:(NSString *)bankNameString{
    self.bankNameLabel.text = bankNameString;
    self.bankIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"logo_%@80.png", bankNameString]];
}

-(void)setBankInfoString:(NSString *)bankInfoString{
    self.bankInfoLabel.text = bankInfoString;
}

-(void)setFixedQuotaString:(NSString *)fixedQuotaString{
    self.fixedQuotaLabel.text = fixedQuotaString;
}

-(void)setTemporaryLinesString:(NSString *)temporaryLinesString{
    self.temporaryLinesLabel.text = temporaryLinesString;
}

-(void)setCardCreditLimitString:(NSString *)cardCreditLimitString{
    self.cardCreditLimitLabel.text = cardCreditLimitString;
}

@end
