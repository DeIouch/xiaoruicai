//
//  OrderShopListTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "OrderShopListTableViewCell.h"

@interface OrderShopListTableViewCell ()

/**
 pos机图片
 */
@property(nonatomic, strong)UIImageView *posIconImageView;

/**
 pos机名称
 */
@property(nonatomic, strong)UILabel *posNameLabel;

/**
 pos机价格
 */
@property(nonatomic, strong)UILabel *posPriceLabel;

/**
 pos机数量
 */
@property(nonatomic, strong)UILabel *posNumberLabel;


@end

@implementation OrderShopListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 0, 345, 97)];
    }
    return self;
}

-(UIImageView *)posIconImageView{
    if (!_posIconImageView) {
        _posIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 15, 62, 62)];
    }
    return _posIconImageView;
}

-(UILabel *)posNameLabel{
    if (!_posNameLabel) {
        _posNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 97, 25, 253, 16)];
    }
    return _posNameLabel;
}

-(UILabel *)posPriceLabel{
    if (!_posPriceLabel) {
        _posPriceLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 97, 54, 150, 16)];
    }
    return _posPriceLabel;
}

-(UILabel *)posNumberLabel{
    if (!_posNumberLabel) {
        _posNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 300, 55, 49, 15)];
    }
    return _posNumberLabel;
}

-(void)setPosIconString:(NSString *)posIconString{
    [self.posIconImageView sd_setImageWithURL:[NSURL URLWithString:posIconString]];
}

-(void)setPosNameString:(NSString *)posNameString{
    self.posNameLabel.text = posNameString;
}

-(void)setPosPriceString:(NSString *)posPriceString{
    self.posPriceLabel.text = [NSString stringWithFormat:@"¥%@", posPriceString];
}

-(void)setPosNumberString:(NSString *)posNumberString{
    self.posNumberLabel.text = [NSString stringWithFormat:@"x%@", posNumberString];
}

@end
