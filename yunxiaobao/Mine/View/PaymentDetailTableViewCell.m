//
//  PaymentDetailTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/26.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "PaymentDetailTableViewCell.h"

@interface PaymentDetailTableViewCell ()

/**
 图标
 */
@property(nonatomic, strong)UIImageView *iconImageView;

/**
 收支名称
 */
@property(nonatomic, strong)UILabel *paymentNameLabel;

/**
 收支时间
 */
@property(nonatomic, strong)UILabel *paymentTimeLabel;

/**
 收入
 */
@property(nonatomic, strong)UILabel *incomeMoneyLabel;

/**
 支出
 */
@property(nonatomic, strong)UILabel *spendMoneyLabel;

@end

@implementation PaymentDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 60, 77, 315, 1)];
    }
    return self;
}









-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", YES, 20, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 16, 40, 40)];
    }
    return _iconImageView;
}

-(UILabel *)paymentNameLabel{
    if (!_paymentNameLabel) {
        _paymentNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 69, 19, 200, 15)];
    }
    return _paymentNameLabel;
}

-(UILabel *)paymentTimeLabel{
    if (!_paymentTimeLabel) {
        _paymentTimeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 68, 42, 200, 12)];
    }
    return _paymentTimeLabel;
}

-(UILabel *)incomeMoneyLabel{
    if (!_incomeMoneyLabel) {
        _incomeMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 253, 24, 35, 1, 255, 255, 255, 2, 20, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 270, 25, 90, 20)];
    }
    return _incomeMoneyLabel;
}

-(UILabel *)spendMoneyLabel{
    if (!_spendMoneyLabel) {
        _spendMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 20, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 270, 25, 90, 20)];
    }
    return _spendMoneyLabel;
}

-(void)setIconString:(NSString *)iconString{
    self.iconImageView.image = [UIImage imageNamed:iconString];
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconString]];
}

-(void)setPaymentNameString:(NSString *)paymentNameString{
    self.paymentNameLabel.text = paymentNameString;
}

-(void)setPaymentTimeString:(NSString *)paymentTimeString{
    self.paymentTimeLabel.text = paymentTimeString;
}

-(void)setMoneyNumberString:(NSString *)moneyNumberString{
    _moneyNumberString = moneyNumberString;
}

-(void)setPaymentTypeString:(NSString *)paymentTypeString{
    _paymentTypeString = paymentTypeString;
    switch ([paymentTypeString intValue]) {
        case 0:
            self.incomeMoneyLabel.text = [NSString stringWithFormat:@"+%@", _moneyNumberString];
            break;
            
        default:
            self.spendMoneyLabel.text = [NSString stringWithFormat:@"-%@", _moneyNumberString];
            break;
    }
    
    
}

@end
