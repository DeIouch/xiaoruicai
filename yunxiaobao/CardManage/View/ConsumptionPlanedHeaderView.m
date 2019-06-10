//
//  ConsumptionPlanedHeaderView.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "ConsumptionPlanedHeaderView.h"

@interface ConsumptionPlanedHeaderView ()

/**
 消费日期
 */
@property(nonatomic, strong)UILabel *dateLabel;

/**
 消费金额
 */
@property(nonatomic, strong)UILabel *consumptionLabel;

/**
 消费类型
 */
@property(nonatomic, strong)UILabel *consumptionTypeLabel;

@end

@implementation ConsumptionPlanedHeaderView

-(UIView *)initWithFrame:(CGRect)viewFrame{
    if (self = [super initWithFrame:viewFrame]) {
        self.frame = viewFrame;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self) setFrame:DelouchFrameMake(FrameCellView, 15, 21, 100, 15)];
    }
    return _dateLabel;
}

-(UILabel *)consumptionLabel{
    if (!_consumptionLabel) {
        _consumptionLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self) setFrame:DelouchFrameMake(FrameCellView, 160, 11, 200, 16)];
    }
    return _consumptionLabel;
}

-(UILabel *)consumptionTypeLabel{
    if (!_consumptionTypeLabel) {
        _consumptionTypeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self) setFrame:DelouchFrameMake(FrameCellView, 160, 31, 200, 13)];
    }
    return _consumptionTypeLabel;
}

-(void)setDateString:(NSString *)dateString{
    self.dateLabel.text = dateString;
}

-(void)setConsumptionString:(NSString *)consumptionString{
//    self.consumptionLabel.text = consumptionString;
    [DelouchLibrary setMoneyLabel:self.consumptionLabel moneyText:consumptionString bigFont:18 smallFont:12];
}

-(void)setConsumptionTypeString:(NSString *)consumptionTypeString{
    if ([consumptionTypeString isEqualToString:@"1"]) {
        self.consumptionTypeLabel.text = @"今日消费";
    }else{
        self.consumptionTypeLabel.text = @"今日还款";
    }
}

@end
