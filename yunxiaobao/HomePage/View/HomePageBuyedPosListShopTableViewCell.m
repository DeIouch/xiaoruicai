//
//  HomePageBuyedPosListShopTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageBuyedPosListShopTableViewCell.h"

@interface HomePageBuyedPosListShopTableViewCell ()

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

@implementation HomePageBuyedPosListShopTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(UIImageView *)posIconImageView{
    if (!_posIconImageView) {
        _posIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 0, 62, 62)];
    }
    return _posIconImageView;
}

-(UILabel *)posNameLabel{
    if (!_posNameLabel) {
        _posNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 97, 10, 253, 16)];
    }
    return _posNameLabel;
}

-(UILabel *)posPriceLabel{
    if (!_posPriceLabel) {
        _posPriceLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 97, 39, 150, 16)];
    }
    return _posPriceLabel;
}

-(UILabel *)posNumberLabel{
    if (!_posNumberLabel) {
        _posNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 300, 40, 49, 15)];
    }
    return _posNumberLabel;
}

-(void)setPosIconString:(NSString *)posIconString{
    [self.posIconImageView sd_setImageWithURL:[NSURL URLWithString:posIconString] placeholderImage:[UIImage imageNamed:zwt_POS_242_242]];
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
