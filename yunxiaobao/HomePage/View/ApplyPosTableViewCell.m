//
//  ApplyPosTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ApplyPosTableViewCell.h"

@interface ApplyPosTableViewCell ()

/**
 pos机图片
 */
@property(nonatomic, strong)UIImageView *posIconImageView;

/**
 pos机名称
 */
@property(nonatomic, strong)UILabel *posNameLabel;

/**
 pos机介绍
 */
@property(nonatomic, strong)UILabel *posInstructionsLabel;

/**
 pos机价格
 */
@property(nonatomic, strong)UILabel *posPriceLabel;

/**
 pos机数量
 */
@property(nonatomic, strong)UILabel *posNumberLabel;

/**
 减少数量
 */
@property(nonatomic, strong)UIButton *reductionNumberButton;

/**
 添加数量
 */
@property(nonatomic, strong)UIButton *addNumberButton;

@end

@implementation ApplyPosTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 274, 97, 86, 1)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 274, 121, 86, 1)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 274, 97, 1, 24)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 298, 97, 1, 24)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 336, 97, 1, 24)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 204, 204, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 360, 97, 1, 24)];
        
        [self.addNumberButton addTarget:self action:@selector(addNumber) forControlEvents:UIControlEventTouchUpInside];
        
        [self.reductionNumberButton addTarget:self action:@selector(reductionNumber) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)addNumber{
    self.posNumberString = [NSString stringWithFormat:@"%d", [self.posNumberString intValue] + 1];
    _posListModel.pos_number = self.posNumberString;
    self.applyPosAddBlock(_posListModel, _cellIndex, [_posListModel.pos_price floatValue], self.posNumberString);
}

-(void)setCellIndex:(NSInteger)cellIndex{
    _cellIndex = cellIndex;
}

-(void)reductionNumber{
    self.posNumberString = [NSString stringWithFormat:@"%d", [self.posNumberString intValue] - 1];
    _posListModel.pos_number = self.posNumberString;
    self.applyPosReductionBlock(_posListModel, _cellIndex, [_posListModel.pos_price floatValue], self.posNumberString);
}

-(UIImageView *)posIconImageView{
    if (!_posIconImageView) {
        _posIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 10, 121, 121)];
    }
    return _posIconImageView;
}

-(UILabel *)posNameLabel{
    if (!_posNameLabel) {
        _posNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 160, 25, 200, 15)];
    }
    return _posNameLabel;
}

-(UILabel *)posInstructionsLabel{
    if (!_posInstructionsLabel) {
        _posInstructionsLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 160, 50, 200, 12)];
    }
    return _posInstructionsLabel;
}

-(UILabel *)posPriceLabel{
    if (!_posPriceLabel) {
        _posPriceLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 86, 112, 254, 1, 255, 255, 255, 2, 20, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 160, 99, 100, 20)];
    }
    return _posPriceLabel;
}

-(UIButton *)reductionNumberButton{
    if (!_reductionNumberButton) {
        _reductionNumberButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"-", 2, 204, 204, 204, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 274, 97, 24, 24)];
    }
    return _reductionNumberButton;
}

-(UIButton *)addNumberButton{
    if (!_addNumberButton) {
        _addNumberButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"+", 2, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 336, 97, 24, 24)];
    }
    return _addNumberButton;
}

-(UILabel *)posNumberLabel{
    if (!_posNumberLabel) {
        _posNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 0, 0, 0, 1, 255, 255, 255, 2, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 298, 97, 38, 24)];
    }
    return _posNumberLabel;
}

-(void)setPosIconString:(NSString *)posIconString{
    [self.posIconImageView sd_setImageWithURL:[NSURL URLWithString:posIconString] placeholderImage:[UIImage imageNamed:zwt_POS_242_242]];
}

-(void)setPosNameString:(NSString *)posNameString{
    self.posNameLabel.text = posNameString;
}

-(void)setPosInstructionsString:(NSString *)posInstructionsString{
    self.posInstructionsLabel.text = posInstructionsString;
}

-(void)setPosPriceString:(NSString *)posPriceString{
    self.posPriceLabel.text = posPriceString;
}

-(void)setPosNumberString:(NSString *)posNumberString{
    _posNumberString = posNumberString;
    self.posNumberLabel.text = posNumberString;
    _posListModel.pos_number = posNumberString;
    if ([posNumberString isEqualToString:@"0"]) {
        self.reductionNumberButton.userInteractionEnabled = NO;
        [self.reductionNumberButton setTitleColor:[UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        self.reductionNumberButton.userInteractionEnabled = YES;
        [self.reductionNumberButton setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    }
}

-(void)setPosListModel:(PosListModel *)posListModel{
    _posListModel = posListModel;
}

@end
