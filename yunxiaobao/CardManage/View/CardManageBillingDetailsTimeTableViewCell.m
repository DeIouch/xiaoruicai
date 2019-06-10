//
//  CardManageBillingDetailsTimeTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CardManageBillingDetailsTimeTableViewCell.h"

@interface CardManageBillingDetailsTimeTableViewCell ()

/**
 出账日期
 */
@property(nonatomic, strong)UILabel *outAccountDayLabel;

/**
 还款日期
 */
@property(nonatomic, strong)UILabel *payMentDayLabel;

@end

@implementation CardManageBillingDetailsTimeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    }
    return self;
}

-(UILabel *)outAccountDayLabel{
    if (!_outAccountDayLabel) {
        _outAccountDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 13, 200, 12)];
    }
    return _outAccountDayLabel;
}

-(UILabel *)payMentDayLabel{
    if (!_payMentDayLabel) {
        _payMentDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 225, 13, 150, 12)];
    }
    return _payMentDayLabel;
}

-(void)setOutAccountDayString:(NSString *)outAccountDayString{
    self.outAccountDayLabel.text = outAccountDayString;
}

-(void)setPayMentDayString:(NSString *)payMentDayString{
    self.payMentDayLabel.text = payMentDayString;
}

@end
