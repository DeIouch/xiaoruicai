//
//  IntelligentPlanTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "IntelligentPlanTableViewCell.h"

@interface IntelligentPlanTableViewCell ()

/**
 银行icon
 */
@property(nonatomic, strong)UIImageView *bankIconImageView;

/**
 银行名称
 */
@property(nonatomic, strong)UILabel *bankNameLabel;

/**
 用户信息
 */
@property(nonatomic, strong)UILabel *userNameLabel;

/**
 本期应还
 */
@property(nonatomic, strong)UILabel *shouldAlsoLabel;

/**
 账单日
 */
@property(nonatomic, strong)UILabel *orderDayLabel;

/**
 立即规划
 */
@property(nonatomic, strong)UIButton *planningButton;

/**
 已规划
 */
@property(nonatomic, strong)UIButton *planedButton;

@end

@implementation IntelligentPlanTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 353, 15, 8, 13)];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15 * (DelouchWidth / 375.0), 5 * (DelouchWidth / 375.0), 345 * (DelouchWidth / 375.0), 117 * (DelouchWidth / 375.0))];
        view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        view.layer.shadowColor = [UIColor colorWithRed:36/255.0 green:37/255.0 blue:44/255.0 alpha:0.07].CGColor;
        view.layer.shadowOffset = CGSizeMake(0,2);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 11;
        [self.contentView addSubview:view];
    }
    return self;
}

-(UIImageView *)bankIconImageView{
    if (!_bankIconImageView) {
        _bankIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 27, 22, 19, 19)];
    }
    return _bankIconImageView;
}

-(UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1,26, 26, 26, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 55, 25, 65, 14)];
    }
    return _bankNameLabel;
}

-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 130, 25, 100, 14)];
    }
    return _userNameLabel;
}

-(UILabel *)shouldAlsoLabel{
    if (!_shouldAlsoLabel) {
        _shouldAlsoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 68, 120, 19)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"本期应还", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 91, 70, 12)];
    }
    return _shouldAlsoLabel;
}

-(UILabel *)orderDayLabel{
    if (!_orderDayLabel) {
        _orderDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 161, 68, 129, 19)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"账单日", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 161, 91, 53, 12)];
    }
    return _orderDayLabel;
}

-(UIButton *)planningButton{
    if (!_planningButton) {
        _planningButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"立即规划", 2, 255, 255, 255, 1, 86, 112, 254, 1, 13, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 270, 71, 80, 29)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_planningButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(15 * (DelouchWidth / 375.0), 15 * (DelouchWidth / 375.0))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _planningButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _planningButton.layer.mask = maskLayer;
    }
    return _planningButton;
}

-(UIButton *)planedButton{
    if (!_planedButton) {
        _planedButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"已规划", 2, 204, 204, 204, 1, 245, 245, 245, 1, 13, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 270, 71, 80, 29)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_planedButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(15 * (DelouchWidth / 375.0), 15 * (DelouchWidth / 375.0))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _planedButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _planedButton.layer.mask = maskLayer;
    }
    return _planedButton;
}

-(void)setBankIconString:(NSString *)bankIconString{
//    [self.bankIconImageView sd_setImageWithURL:[NSURL URLWithString:bankIconString] placeholderImage:[UIImage imageNamed:zwt_yuan_128]];
    
    self.bankIconImageView.image = [UIImage imageNamed:bankIconString];
}

-(void)setBankNameString:(NSString *)bankNameString{
    self.bankNameLabel.text = bankNameString;
}

-(void)setUserNameString:(NSString *)userNameString{
    self.userNameLabel.text = userNameString;
}

-(void)setShouldAlsoString:(NSString *)shouldAlsoString{
//    self.shouldAlsoLabel.text = shouldAlsoString;
    [DelouchLibrary setMoneyLabel:self.shouldAlsoLabel moneyText:shouldAlsoString bigFont:21 smallFont:12];
}

-(void)setOrderDayString:(NSString *)orderDayString{
    self.orderDayLabel.text = orderDayString;
    [DelouchLibrary setDicBoldFont:self.orderDayLabel font:21];
}

-(void)setPlanStateString:(NSString *)planStateString{
    switch ([planStateString intValue]) {
        case 0:
            {
                [self.planningButton addTarget:self action:@selector(planning) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        case 1:
            {
                [self.planedButton addTarget:self action:@selector(planed) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        default:
            break;
    }
}

-(void)setNeedToPlanModel:(NeedToPlanModel *)needToPlanModel{
    _needToPlanModel = needToPlanModel;
}

-(void)planning{
    self.setIntelligentPlanBlock(_needToPlanModel);
}

-(void)planed{
    
}

@end
