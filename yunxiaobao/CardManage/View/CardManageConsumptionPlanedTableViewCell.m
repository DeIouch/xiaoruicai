//
//  CardManageConsumptionPlanedTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageConsumptionPlanedTableViewCell.h"

@interface CardManageConsumptionPlanedTableViewCell ()

/**
 消费类型
 */
@property(nonatomic, strong)UILabel *consumerTypeLabel;

/**
 消费商户
 */
@property(nonatomic, strong)UILabel *consumerShopLabel;

/**
 消费金额
 */
@property(nonatomic, strong)UILabel *consumerMoneyLabel;

/**
 暂未消费
 */
@property(nonatomic, strong)UILabel *notConsumerNameLabel;

/**
 取消消费
 */
@property(nonatomic, strong)UIButton *cancelConsumerButton;

/**
 等待消费
 */
@property(nonatomic, strong)UIButton *waitConsumerButton;

/**
 刷卡消费
 */
@property(nonatomic, strong)UIButton *goConsumerButton;

@end

@implementation CardManageConsumptionPlanedTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(238, 238, 238, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 70, 375, 1)];
    }
    return self;
}

-(void)cancelConsumer{
//    self.cardManageConsumptionPlanedDeleteShopBlock(_planIdString);
}

-(void)goConsumer{
    self.cardManageConsumptionPlanedSelectShopBlock(_planIdString);
}

-(UILabel *)waitConsumerLabel{
    if (!_waitConsumerLabel) {
        _waitConsumerLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"等待消费", 2, 255, 255, 255, 1, 255, 101, 71, 1, 9, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 0, 45, 15)];
    }
    return _waitConsumerLabel;
}

-(UILabel *)notConsumerNameLabel{
    if (!_notConsumerNameLabel) {
        _notConsumerNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"暂未消费", 2, 255, 255, 255, 1, 149, 165, 253, 1, 9, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 0, 45, 15)];
    }
    return _notConsumerNameLabel;
}

-(UILabel *)consumerTypeLabel{
    if (!_consumerTypeLabel) {
        _consumerTypeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 16, 23, 142, 14)];
    }
    return _consumerTypeLabel;
}

-(UILabel *)consumerShopLabel{
    if (!_consumerShopLabel) {
        _consumerShopLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 16, 45, 142, 12)];
    }
    return _consumerShopLabel;
}

-(UILabel *)consumerMoneyLabel{
    if (!_consumerMoneyLabel) {
        _consumerMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 158, 31, 130, 18)];
    }
    return _consumerMoneyLabel;
}

-(UIButton *)cancelConsumerButton{
    if (!_cancelConsumerButton) {
        _cancelConsumerButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"取消消费", 2, 102, 102, 102, 1, 255, 255, 255, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 23, 68, 26)];
        _cancelConsumerButton.layer.cornerRadius = 13 * (DelouchWidth / 375.0);
        _cancelConsumerButton.layer.borderColor = [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1].CGColor;
        _cancelConsumerButton.layer.borderWidth = DelouchWidth / 375.0;
    }
    return _cancelConsumerButton;
}

-(UIButton *)goConsumerButton{
    if (!_goConsumerButton) {
        _goConsumerButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"刷卡消费", 2, 255, 255, 255, 1, 86, 112, 254, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 23, 68, 26)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_goConsumerButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(13 * (DelouchWidth / 375.0), 13 * (DelouchWidth / 375.0))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _goConsumerButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _goConsumerButton.layer.mask = maskLayer;
    }
    return _goConsumerButton;
}

/**
 是否已消费

 @param consumeredString 消费类型：1 等待消费 2 暂未消费
 */
-(void)setConsumeredString:(NSString *)consumeredString{
    switch ([consumeredString intValue]) {
        case 0:
            {
                self.waitConsumerLabel.text = @"暂未消费";
                self.waitConsumerLabel.backgroundColor = [UIColor colorWithRed:149 / 255.0 green:165 / 255.0 blue:253 / 255.0 alpha:1];
                [self.goConsumerButton addTarget:self action:@selector(goConsumer) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        case 1:
            {
                self.waitConsumerLabel.text = @"已消费";
                [self.waitConsumerButton addTarget:self action:@selector(waitConsumer) forControlEvents:UIControlEventTouchUpInside];
//                [self.cancelConsumerButton addTarget:self action:@selector(cancelConsumer) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        case 2:
            {
                self.waitConsumerLabel.text = @"等待消费";
                self.waitConsumerLabel.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:101 / 255.0 blue:71 / 255.0 alpha:1];
//                [self.waitConsumerButton addTarget:self action:@selector(waitConsumer) forControlEvents:UIControlEventTouchUpInside];
                [self.cancelConsumerButton addTarget:self action:@selector(cancelConsumer) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        default:
            break;
    }
    
    
//    if ([consumeredString isEqualToString:@"1"]) {
//        self.waitConsumerLabel.text = @"刷卡中";
////        [self.cancelConsumerButton addTarget:self action:@selector(cancelConsumer) forControlEvents:UIControlEventTouchUpInside];
//    }else{
//        self.notConsumerNameLabel.text = @"暂未消费";
//        [self.goConsumerButton addTarget:self action:@selector(goConsumer) forControlEvents:UIControlEventTouchUpInside];
//    }
}

//-(void)cancelConsumer{
//
//}

//  0   暂未消费    1   已消费     2   刷卡中
//-(void)setOperatingListModel:(OperatingListModel *)operatingListModel{
//    _operatingListModel = operatingListModel;
//}

-(void)setConsumerTypeString:(NSString *)consumerTypeString{
    self.consumerTypeLabel.text = consumerTypeString;
}

-(void)setConsumerShopString:(NSString *)consumerShopString{
    self.consumerShopLabel.text = consumerShopString;
}

-(void)setConsumerMoneyString:(NSString *)consumerMoneyString{
    self.consumerMoneyLabel.text = consumerMoneyString;
}

//-(void)setPlanOperationalModel:(PlanOperationalModel *)planOperationalModel{
//    _planOperationalModel = planOperationalModel;
//}

//-(void)setGetOperatingInfoModel:(GetOperatingInfoModel *)getOperatingInfoModel{
//    _getOperatingInfoModel = getOperatingInfoModel;
//}

-(void)setPlanIdString:(NSString *)planIdString{
    _planIdString = planIdString;
}

-(void)waitConsumer{
    
}

-(UIButton *)waitConsumerButton{
    if (!_waitConsumerButton) {
        _waitConsumerButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"已消费", 2, 102, 102, 102, 1, 255, 255, 255, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 23, 68, 26)];
        _waitConsumerButton.layer.cornerRadius = 13 * (DelouchWidth / 375.0);
        _waitConsumerButton.layer.borderColor = [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1].CGColor;
        _waitConsumerButton.layer.borderWidth = DelouchWidth / 375.0;
    }
    return _waitConsumerButton;
}

@end
