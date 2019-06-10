//
//  CardManageCeimbursementTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageCeimbursementTableViewCell.h"

@interface CardManageCeimbursementTableViewCell ()

/**
 还款金额
 */
@property(nonatomic, strong)UILabel *ceimbursementMoneyLabel;

/**
 标记还款金额
 */
@property(nonatomic, strong)UILabel *tagCeimbursementMoneyLabel;

/**
 标记还款
 */
@property(nonatomic, strong)UILabel *tagLabel;

/**
 确认还款
 */
@property(nonatomic, strong)UIButton *ceimbursementMoneyButton;

/**
 确认还款
 */
@property(nonatomic, strong)UIButton *ceimbursementeDMoneyButton;

@end

@implementation CardManageCeimbursementTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(238, 238, 238, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 70, 375, 1)];
    }
    return self;
}

-(void)ceimbursementMoney{
    self.cardManageCeimbursementBlock(_getOperatingInfoModel);
}

-(UILabel *)ceimbursementMoneyLabel{
    if (!_ceimbursementMoneyLabel) {
        _ceimbursementMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 18, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 16, 27, 200, 18)];
    }
    return _ceimbursementMoneyLabel;
}

-(UILabel *)tagCeimbursementMoneyLabel{
    if (!_tagCeimbursementMoneyLabel) {
        _tagCeimbursementMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 18, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 16, 19, 200, 18)];
    }
    return _tagCeimbursementMoneyLabel;
}

-(UILabel *)tagLabel{
    if (!_tagLabel) {
        _tagLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 17, 42, 200, 12)];
    }
    return _tagLabel;
}

-(UIButton *)ceimbursementMoneyButton{
    if (!_ceimbursementMoneyButton) {
        _ceimbursementMoneyButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"确认还款", 2, 255, 255, 255, 1, 86, 112, 254, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 23, 68, 26)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_ceimbursementMoneyButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(13 * (DelouchWidth / 375.0), 13 * (DelouchWidth / 375.0))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _ceimbursementMoneyButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _ceimbursementMoneyButton.layer.mask = maskLayer;
    }
    return _ceimbursementMoneyButton;
}

-(UIButton *)ceimbursementeDMoneyButton{
    if (!_ceimbursementeDMoneyButton) {
        _ceimbursementeDMoneyButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"已还款", 2, 102, 102, 102, 1, 255, 255, 255, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 23, 68, 26)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_ceimbursementeDMoneyButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(13 * (DelouchWidth / 375.0), 13 * (DelouchWidth / 375.0))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _ceimbursementeDMoneyButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _ceimbursementeDMoneyButton.layer.mask = maskLayer;
    }
    return _ceimbursementeDMoneyButton;
}

-(void)setCeimbursementMoneyString:(NSString *)ceimbursementMoneyString{
    _ceimbursementMoneyString = ceimbursementMoneyString;
}

-(void)setCeimbursementTypeString:(NSString *)ceimbursementTypeString{
//    if ([ceimbursementTypeString isEqualToString:@"1"]) {
////        self.ceimbursementMoneyLabel.text = _ceimbursementMoneyString;
//        [DelouchLibrary setMoneyLabel:self.tagCeimbursementMoneyLabel moneyText:_ceimbursementMoneyString bigFont:18 smallFont:12];
//        self.tagLabel.text = @"消费还款";
//        [self.ceimbursementeDMoneyButton addTarget:self action:@selector(ceimbursementeDMoney) forControlEvents:UIControlEventTouchUpInside];
//    }else{
////        self.tagCeimbursementMoneyLabel.text = _ceimbursementMoneyString;
//        [DelouchLibrary setMoneyLabel:self.tagCeimbursementMoneyLabel moneyText:_ceimbursementMoneyString bigFont:18 smallFont:12];
//        [self.ceimbursementMoneyButton addTarget:self action:@selector(ceimbursementMoney) forControlEvents:UIControlEventTouchUpInside];
//    }
    
    switch ([ceimbursementTypeString intValue]) {
        case 0:
            {
                [DelouchLibrary setMoneyLabel:self.tagCeimbursementMoneyLabel moneyText:_ceimbursementMoneyString bigFont:18 smallFont:12];
                [self.ceimbursementMoneyButton addTarget:self action:@selector(ceimbursementMoney) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        case 1:
            {
                [DelouchLibrary setMoneyLabel:self.tagCeimbursementMoneyLabel moneyText:_ceimbursementMoneyString bigFont:18 smallFont:12];
                self.tagLabel.text = @"消费还款";
                [self.ceimbursementeDMoneyButton addTarget:self action:@selector(ceimbursementeDMoney) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        default:
            break;
    }
    
    
}

-(void)ceimbursementeDMoney{
    
}

-(void)setGetOperatingInfoModel:(GetOperatingInfoModel *)getOperatingInfoModel{
    _getOperatingInfoModel = getOperatingInfoModel;
}

@end
