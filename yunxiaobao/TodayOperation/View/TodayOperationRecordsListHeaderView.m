//
//  TodayOperationRecordsListHeaderView.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "TodayOperationRecordsListHeaderView.h"

@interface TodayOperationRecordsListHeaderView ()

/**
 日期
 */
@property(nonatomic, strong)UILabel *dateLabel;

/**
 收缩list
 */
@property(nonatomic, strong)UIImageView *showListButton;

/**
 消费金额
 */
@property(nonatomic, strong)UILabel *consumptionMoneyLabel;

/**
 还款金额
 */
@property(nonatomic, strong)UILabel *repaymentMoneyLabel;

@end

@implementation TodayOperationRecordsListHeaderView

-(UIView *)initWithFrame:(CGRect)viewFrame{
    if (self = [super initWithFrame:viewFrame]) {
        self.frame = viewFrame;
        self.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
        [self.showListButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showList)]];
    }
    return self;
}

-(void)showList{
    
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 0, 0, 0, 1, 255, 255, 255, 2, 18, YES, self) setFrame:DelouchFrameMake(FrameCellView, 21, 26, 82, 18)];
    }
    return _dateLabel;
}

-(UIImageView *)showListButton{
    if (!_showListButton) {
        _showListButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_sj_xl, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 93, 22, 30, 27)];
        _showListButton.contentMode = UIViewContentModeCenter;
    }
    return _showListButton;
}

-(UILabel *)consumptionMoneyLabel{
    if (!_consumptionMoneyLabel) {
        _consumptionMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 153, 153, 153, 1, 255, 255, 255, 2, 14, YES, self) setFrame:DelouchFrameMake(FrameCellView, 200, 17, 160, 14)];
    }
    return _consumptionMoneyLabel;
}

-(UILabel *)repaymentMoneyLabel{
    if (!_repaymentMoneyLabel) {
        _repaymentMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 153, 153, 153, 1, 255, 255, 255, 2, 14, YES, self) setFrame:DelouchFrameMake(FrameCellView, 200, 40, 160, 14)];
    }
    return _repaymentMoneyLabel;
}

-(void)setDateString:(NSString *)dateString{
    self.dateLabel.text = dateString;
}

-(void)setConsumptionMoneyString:(NSString *)consumptionMoneyString{
    self.consumptionMoneyLabel.text = [NSString stringWithFormat:@"消费 ￥%@", consumptionMoneyString];
}

-(void)setRepaymentMoneyString:(NSString *)repaymentMoneyString{
    self.repaymentMoneyLabel.text = [NSString stringWithFormat:@"还款 ￥%@", repaymentMoneyString];
}

@end
