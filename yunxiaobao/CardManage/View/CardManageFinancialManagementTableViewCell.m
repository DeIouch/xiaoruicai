//
//  CardManageFinancialManagementTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardManageFinancialManagementTableViewCell.h"

@interface CardManageFinancialManagementTableViewCell ()

/**
 账单日期
 */
@property(nonatomic, strong)UILabel *financiaDateLabel;

/**
 账单未出
 */
@property(nonatomic, strong)UILabel *financiaNotLabel;

/**
 去收款
 */
@property(nonatomic, strong)UIButton *goCollectionButton;

/**
 查看账单
 */
@property(nonatomic, strong)UIButton *seeFinanciaButton;

@end

@implementation CardManageFinancialManagementTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 57, 375, 5)];
    }
    return self;
}

-(void)goCollection{
    self.goCollectionBlock(_financesListModel);
}

-(void)seeFinancia{
    self.seeFinanciaBlock(_financesListModel);
}

-(UILabel *)financiaDateLabel{
    if (!_financiaDateLabel) {
        _financiaDateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 16, 20, 250, 16)];
    }
    return _financiaDateLabel;
}

-(UILabel *)financiaNotLabel{
    if (!_financiaNotLabel) {
        _financiaNotLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 16, 68, 26)];
    }
    return _financiaNotLabel;
}

-(UIButton *)goCollectionButton{
    if (!_goCollectionButton) {
        _goCollectionButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"去收款", 2, 255, 255, 255, 1, 86, 112, 254, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 16, 68, 26)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_goCollectionButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(13 * (DelouchWidth / 375.0), 13 * (DelouchWidth / 375.0))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _goCollectionButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _goCollectionButton.layer.mask = maskLayer;
    }
    return _goCollectionButton;
}

-(UIButton *)seeFinanciaButton{
    if (!_seeFinanciaButton) {
        _seeFinanciaButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"查看", 2, 51, 51, 51, 1, 255, 255, 255, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 16, 68, 26)];
        _seeFinanciaButton.layer.cornerRadius = 13 * (DelouchWidth / 375.0);
        _seeFinanciaButton.layer.borderColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1].CGColor;
        _seeFinanciaButton.layer.borderWidth = DelouchWidth / 375.0;
    }
    return _seeFinanciaButton;
}

-(void)setFinanciaDateString:(NSString *)financiaDateString{
    self.financiaDateLabel.text = financiaDateString;
}

-(void)setFinanciaTypeString:(NSString *)financiaTypeString{
    switch ([financiaTypeString intValue]) {
        case 0:
            {
                self.financiaNotLabel.text = @"账单未出";
            }
            break;
            
        case 1:
            {
                [self.goCollectionButton addTarget:self action:@selector(goCollection) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        case 2:
            {
                [self.seeFinanciaButton addTarget:self action:@selector(seeFinancia) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        default:
            break;
    }
}

-(void)setFinancesListModel:(FinancesListModel *)financesListModel{
    _financesListModel = financesListModel;
}

@end
