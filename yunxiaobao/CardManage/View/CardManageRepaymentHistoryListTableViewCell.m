//
//  CardManageRepaymentHistoryListTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CardManageRepaymentHistoryListTableViewCell.h"

@interface CardManageRepaymentHistoryListTableViewCell ()

/**
 账单icon
 */
@property(nonatomic, strong)UIImageView *repaymentHistoryIconImageView;

/**
 账单金额
 */
@property(nonatomic, strong)UILabel *moneyLabel;

/**
 账单类型
 */
@property(nonatomic, strong)UILabel *typeLabel;

/**
 日期
 */
@property(nonatomic, strong)UILabel *dateLabel;

@end

@implementation CardManageRepaymentHistoryListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(238, 238, 238, 1, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 0, 70, 360, 1)];
    }
    return self;
}

-(UIImageView *)repaymentHistoryIconImageView{
    if (!_repaymentHistoryIconImageView) {
        _repaymentHistoryIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", YES, 16, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 20, 32, 32)];
    }
    return _repaymentHistoryIconImageView;
}

-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 60, 17, 150, 18)];
    }
    return _moneyLabel;
}

-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 11, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 60, 42, 150, 12)];
    }
    return _typeLabel;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 220, 30, 135, 11)];
    }
    return _dateLabel;
}

-(void)setRepaymentHistoryIconString:(NSString *)repaymentHistoryIconString{
//    [self.repaymentHistoryIconImageView sd_setImageWithURL:[NSURL URLWithString:repaymentHistoryIconString] placeholderImage:[UIImage imageNamed:zwt_yuan_128]];
    
    self.repaymentHistoryIconImageView.image = [UIImage imageNamed:logo_zfb];
}

-(void)setMoneyString:(NSString *)moneyString{
    self.moneyLabel.text = moneyString;
}

-(void)setTypeString:(NSString *)typeString{
    self.typeLabel.text = typeString;
}

-(void)setDateString:(NSString *)dateString{
    self.dateLabel.text = dateString;
}

@end
