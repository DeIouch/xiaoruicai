//
//  TodayOperationChooseShopTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "TodayOperationChooseShopTableViewCell.h"

@interface TodayOperationChooseShopTableViewCell ()

/**
 商户名称
 */
@property(nonatomic, strong)UILabel *shopNameLabel;

/**
 选择商户
 */
@property(nonatomic, strong)UIImageView *chooseShopButton;

@end

@implementation TodayOperationChooseShopTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 54, 360, 1)];
        [self.chooseShopButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseShop)]];
    }
    return self;
}

-(void)chooseShop{
    self.chooseBOOL = YES;
    self.todayOperationChooseShopBlock(_cellIndex);
}

-(UILabel *)shopNameLabel{
    if (!_shopNameLabel) {
        _shopNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 30, 20, 270, 15)];
    }
    return _shopNameLabel;
}

-(UIImageView *)chooseShopButton{
    if (!_chooseShopButton) {
        _chooseShopButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_zf_wx, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 332, 10, 38, 38)];
        _chooseShopButton.contentMode = UIViewContentModeCenter;
    }
    return _chooseShopButton;
}

-(void)setShopNameString:(NSString *)shopNameString{
    self.shopNameLabel.text = shopNameString;
}

-(void)setChooseBOOL:(BOOL)chooseBOOL{
    _chooseBOOL = chooseBOOL;
    if (chooseBOOL) {
        self.chooseShopButton.image = [UIImage imageNamed:icon_zf_yx];
    }else{
        self.chooseShopButton.image = [UIImage imageNamed:icon_zf_wx];
    }
}

-(void)setCellIndex:(NSInteger)cellIndex{
    _cellIndex = cellIndex;
}

@end
