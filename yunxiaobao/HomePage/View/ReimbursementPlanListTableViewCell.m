//
//  ReimbursementPlanListTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ReimbursementPlanListTableViewCell.h"

@interface ReimbursementPlanListTableViewCell ()

/**
 还款日期
 */
@property(nonatomic, strong)UILabel *dateLabel;

/**
 还款金额
 */
@property(nonatomic, strong)UILabel *moneyLabel;

@end

@implementation ReimbursementPlanListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 55, 375, 1)];
    }
    return self;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 22, 150, 12)];
    }
    return _dateLabel;
}

-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 200, 19, 160, 18)];
    }
    return _moneyLabel;
}

-(void)setDateString:(NSString *)dateString{
    self.dateLabel.text = dateString;
}

-(void)setMoneyString:(NSString *)moneyString{
//    self.moneyLabel.text = moneyString;
    [DelouchLibrary setMoneyLabel:self.moneyLabel moneyText:moneyString bigFont:18 smallFont:12];
}

@end
