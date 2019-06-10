//
//  ConsumptionPlanListTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ConsumptionPlanListTableViewCell.h"

@interface ConsumptionPlanListTableViewCell ()

/**
 消费头像
 */
@property(nonatomic, strong)UIImageView *typeImageView;

/**
 消费名称
 */
@property(nonatomic, strong)UILabel *consumptionNameLabel;

/**
 消费类型
 */
@property(nonatomic, strong)UILabel *consumptionTypeLabel;

/**
 消费金额
 */
@property(nonatomic, strong)UILabel *consumptionNumberLabel;

@end

@implementation ConsumptionPlanListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 71, 375, 1)];
    }
    return self;
}

-(UIImageView *)typeImageView{
    if (!_typeImageView) {
        _typeImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 20, 32, 32)];
    }
    return _typeImageView;
}

-(UILabel *)consumptionNameLabel{
    if (!_consumptionNameLabel) {
        _consumptionNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 59, 19, 200, 14)];
    }
    return _consumptionNameLabel;
}

-(UILabel *)consumptionTypeLabel{
    if (!_consumptionTypeLabel) {
        _consumptionTypeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 59, 41, 200, 12)];
    }
    return _consumptionTypeLabel;
}

-(UILabel *)consumptionNumberLabel{
    if (!_consumptionNumberLabel) {
        _consumptionNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 260, 27, 100, 18)];
    }
    return _consumptionNumberLabel;
}

-(void)setTypeString:(NSString *)typeString{
    _typeString = typeString;
    [self.typeImageView sd_setImageWithURL:[NSURL URLWithString:typeString] placeholderImage:[UIImage imageNamed:zwt_yuan_128]];
}

-(void)setConsumptionNameString:(NSString *)consumptionNameString{
    _consumptionNameString = consumptionNameString;
    self.consumptionNameLabel.text = consumptionNameString;
}

-(void)setConsumptionTypeString:(NSString *)consumptionTypeString{
    _consumptionTypeString = consumptionTypeString;
    self.consumptionTypeLabel.text = consumptionTypeString;
}

-(void)setConsumptionNumberString:(NSString *)consumptionNumberString{
    _consumptionNumberString = consumptionNumberString;
//    self.consumptionNumberLabel.text = consumptionNumberString;
    [DelouchLibrary setMoneyLabel:self.consumptionNumberLabel moneyText:consumptionNumberString bigFont:18 smallFont:12];
}

@end
