//
//  CardManageBillingDateilsInfoTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CardManageBillingDateilsInfoTableViewCell.h"

@interface CardManageBillingDateilsInfoTableViewCell ()

/**
 账单名称
 */
@property(nonatomic, strong)UILabel *billNameLabel;

/**
 账单日期
 */
@property(nonatomic, strong)UILabel *billDateLabel;

/**
 账单价格
 */
@property(nonatomic, strong)UILabel *billPriceLabel;

/**
 账单icon
 */
@property(nonatomic, strong)UIImageView *billIconImageView;

@end

@implementation CardManageBillingDateilsInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(238, 238, 238, 1, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 15, 79, 360, 1)];
    }
    return self;
}

-(UILabel *)billNameLabel{
    if (!_billNameLabel) {
        _billNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"转账还款-网联  支付宝-支付宝（中国）网络科技有限公司", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 59, 18, 190, 32)];
        _billNameLabel.numberOfLines = 2;
        [_billNameLabel sizeToFit];
    }
    return _billNameLabel;
}

-(UILabel *)billDateLabel{
    if (!_billDateLabel) {
        _billDateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 59, 56, 180, 12)];
    }
    return _billDateLabel;
}

-(UIImageView *)billIconImageView{
    if (!_billIconImageView) {
        _billIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", YES, 16, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 18, 32, 32)];
    }
    return _billIconImageView;
}

-(UILabel *)billPriceLabel{
    if (!_billPriceLabel) {
        _billPriceLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 260, 32, 100, 18)];
    }
    return _billPriceLabel;
}

-(void)setBillIconString:(NSString *)billIconString{
//    [self.billIconImageView sd_setImageWithURL:[NSURL URLWithString:billIconString] placeholderImage:[UIImage imageNamed:zwt_yuan_128]];
    
    self.billIconImageView.image = [UIImage imageNamed:logo_zfb];
}

-(void)setBillNameString:(NSString *)billNameString{
    self.billNameLabel.text = billNameString;
}

-(void)setBillDateString:(NSString *)billDateString{
    self.billDateLabel.text = billDateString;
}

-(void)setBillPriceString:(NSString *)billPriceString{
    _billPriceString = billPriceString;
}

-(void)setBillTypeString:(NSString *)billTypeString{
    switch ([billTypeString intValue]) {
        case 1:
            {
//                self.billPriceLabel.text = [NSString stringWithFormat:@"+%@", _billPriceString];
                
                [DelouchLibrary setMoneyLabel:self.billPriceLabel moneyText:[NSString stringWithFormat:@"+%@", _billPriceString] bigFont:18 smallFont:12];
                
            }
            break;
            
        default:
            {
//                self.billPriceLabel.text = [NSString stringWithFormat:@"-%@", _billPriceString];
                
                [DelouchLibrary setMoneyLabel:self.billPriceLabel moneyText:[NSString stringWithFormat:@"-%@", _billPriceString] bigFont:18 smallFont:12];
            }
            break;
    }
}

@end
