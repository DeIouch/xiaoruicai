//
//  TodayOperationRecordsListTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "TodayOperationRecordsListTableViewCell.h"

@interface TodayOperationRecordsListTableViewCell ()

/**
 用户头像
 */
@property(nonatomic, strong)UIImageView *userIconImageView;

/**
 用户姓名
 */
@property(nonatomic, strong)UILabel *userNameLabel;

/**
 日期
 */
@property(nonatomic, strong)UILabel *dateLabel;

/**
 金额
 */
@property(nonatomic, strong)UILabel *moneyLabel;

@end

@implementation TodayOperationRecordsListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 70, 360, 1)];
    }
    return self;
}

-(UIImageView *)userIconImageView{
    if (!_userIconImageView) {
        _userIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", YES, 16, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 20, 32, 32)];
    }
    return _userIconImageView;
}

-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 59, 19, 150, 14)];
    }
    return _userNameLabel;
}

-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 220, 27, 140, 18)];
    }
    return _moneyLabel;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 60, 44, 150, 11)];
    }
    return _dateLabel;
}

-(void)setUserIconString:(NSString *)userIconString{
    self.userIconImageView.image = [UIImage imageNamed:userIconString];
//    [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:userIconString] placeholderImage:[UIImage imageNamed:icon_heads]];
}

-(void)setUserNameString:(NSString *)userNameString{
    self.userNameLabel.text = userNameString;
}

-(void)setDateString:(NSString *)dateString{
    self.dateLabel.text = dateString;
}

-(void)setMoneyString:(NSString *)moneyString{
//    self.moneyLabel.text = [NSString stringWithFormat:@"+%@", moneyString];
    
    switch ([_typeString intValue]) {
        case 1:
            {
                self.moneyLabel.text = [NSString stringWithFormat:@"+%@", moneyString];
//                [DelouchLibrary setMoneyLabel:self.moneyLabel moneyText:[moneyString] bigFont:18 smallFont:12];
            }
            break;

        default:
            {
                self.moneyLabel.text = [NSString stringWithFormat:@"-%@", moneyString];
//                [DelouchLibrary setMoneyLabel:self.moneyLabel moneyText:moneyString bigFont:18 smallFont:12];
            }
            break;
    }
    
//    [DelouchLibrary setMoneyLabel:self.moneyLabel moneyText:moneyString bigFont:18 smallFont:12];
}

-(void)setTypeString:(NSString *)typeString{
    _typeString = typeString;
}

@end
