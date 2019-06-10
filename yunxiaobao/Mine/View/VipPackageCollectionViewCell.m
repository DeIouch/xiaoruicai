//
//  VipPackageCollectionViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/21.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "VipPackageCollectionViewCell.h"

@interface VipPackageCollectionViewCell ()

/**
 提示框
 */
@property(nonatomic, strong)UILabel *notiLabel;

/**
 vip日期
 */
@property(nonatomic, strong)UILabel *vipTimeLabel;

/**
 vip价格
 */
@property(nonatomic, strong)UILabel *vipPriceLabel;

/**
 vip旧价格
 */
@property(nonatomic, strong)UILabel *vipOldPriceLabel;

/**
 优惠金额
 */
@property(nonatomic, strong)UILabel *discountAmountLabel;

/**
 背景view
 */
@property(nonatomic, strong)UIView *backView;

@end

@implementation VipPackageCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(UILabel *)vipTimeLabel{
    if (!_vipTimeLabel) {
        _vipTimeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 102, 102, 102, 1, 255, 255, 255, 2, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 25, 100, 15)];
    }
    return _vipTimeLabel;
}

-(UILabel *)vipPriceLabel{
    if (!_vipPriceLabel) {
        _vipPriceLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 172, 102, 16, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 56, 100, 20)];
    }
    return _vipPriceLabel;
}

-(UILabel *)vipOldPriceLabel{
    if (!_vipOldPriceLabel) {
        _vipOldPriceLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 153, 153, 153, 1, 255, 255, 255, 2, 10, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 86, 100, 10)];
    }
    return _vipOldPriceLabel;
}

-(UILabel *)notiLabel{
    if (!_notiLabel) {
        _notiLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 253, 244, 229, 1, 78, 70, 67, 1, 10, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 2, 79, 16)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_notiLabel.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(5,5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _notiLabel.bounds;
        maskLayer.path = maskPath.CGPath;
        _notiLabel.layer.mask = maskLayer;
    }
    return _notiLabel;
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, YES, 3, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 10, 100, 124)];
        _backView.layer.borderWidth = 1;
    }
    return _backView;
}

-(UILabel *)discountAmountLabel{
    if (!_discountAmountLabel) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(231, 188, 121, 1, YES, 8, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 14, 102, 72, 16)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_dianzan, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 21, 105, 13, 11)];
        
        _discountAmountLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 10, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 38, 105, 52, 10)];
    }
    return _discountAmountLabel;
}

-(void)setVipPriceString:(NSString *)vipPriceString{
    self.vipPriceLabel.text = vipPriceString;
}

-(void)setVipOldPriceString:(NSString *)vipOldPriceString{
    self.vipOldPriceLabel.text = vipOldPriceString;
}

-(void)setVipTimeString:(NSString *)vipTimeString{
    self.vipTimeLabel.text = vipTimeString;
}

-(void)setNotiString:(NSString *)notiString{
    self.notiLabel.frame = CGRectMake(self.notiLabel.frame.origin.x, self.notiLabel.frame.origin.y, [DelouchLibrary sizeWithText:notiString withFont:12].width, self.notiLabel.frame.size.height);
    self.notiLabel.text = notiString;
}

-(void)setDiscountAmountString:(NSString *)discountAmountString{
    self.discountAmountLabel.text = [NSString stringWithFormat:@"立省%@元", discountAmountString];
}

-(void)setSelectStateBOOL:(BOOL)selectStateBOOL{
    _selectStateBOOL = selectStateBOOL;
    if (selectStateBOOL) {
        self.backView.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:221 / 255.0 blue:201 / 255.0 alpha:1];
        self.backView.layer.borderColor = [[UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:1] CGColor];
    }else{
        self.backView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1];
        self.backView.layer.borderColor = [[UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:1] CGColor];
    }
}

@end
