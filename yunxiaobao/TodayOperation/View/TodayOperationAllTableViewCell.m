//
//  TodayOperationAllTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/11.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "TodayOperationAllTableViewCell.h"

@implementation TodayOperationAllTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        DelouchView *backView = [[DelouchView alloc]initView:DelouchViewInfoMake(255, 68, 32, 1, YES, 3, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 10, 345, 100)];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = backView.bounds;
        gradient.colors = @[(id)[UIColor colorWithRed:255 / 255.0 green:107 / 255.0 blue:80 / 255.0 alpha:1].CGColor,(id)[UIColor colorWithRed:255 / 255.0 green:131 / 255.0 blue:108 / 255.0 alpha:1].CGColor,(id)[UIColor colorWithRed:255 / 255.0 green:146 / 255.0 blue:144 / 255.0 alpha:1].CGColor];
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(1, 1);
        [backView.layer addSublayer:gradient];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, backView) setFrame:DelouchFrameMake(FrameCellView, 173, 28, 1, 45)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"需消费总额(元)", 1, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 30, 30, 100, 12)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"需还款总额(元)", 1, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 203, 30, 100, 12)];
    }
    return self;
}

-(UILabel *)totalConsumptionLabel{
    if (!_totalConsumptionLabel) {
        _totalConsumptionLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 28, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 30, 60, 150, 27)];
    }
    return _totalConsumptionLabel;
}

-(UILabel *)reimbursementAmountLabel{
    if (!_reimbursementAmountLabel) {
        _reimbursementAmountLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 28, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 203, 60, 150, 27)];
    }
    return _reimbursementAmountLabel;
}

-(void)setTotalConsumptionString:(NSString *)totalConsumptionString{
//    self.totalConsumptionLabel.text = totalConsumptionString;
    [DelouchLibrary setMoneyLabel:self.totalConsumptionLabel moneyText:totalConsumptionString bigFont:28 smallFont:14];
}

-(void)setReimbursementAmountString:(NSString *)reimbursementAmountString{
//    self.reimbursementAmountLabel.text = reimbursementAmountString;
    [DelouchLibrary setMoneyLabel:self.reimbursementAmountLabel moneyText:reimbursementAmountString bigFont:28 smallFont:14];
}

@end
