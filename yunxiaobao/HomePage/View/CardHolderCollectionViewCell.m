//
//  CardHolderCollectionViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/6/3.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "CardHolderCollectionViewCell.h"

@interface CardHolderCollectionViewCell ()

/**
 银行图标
 */
@property(nonatomic, strong)UIImageView *bankIconImageView;

@end

@implementation CardHolderCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(UIImageView *)bankIconImageView{
    if (!_bankIconImageView) {
        _bankIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 0, 17, 17)];
    }
    return _bankIconImageView;
}

-(void)setBankIconString:(NSString *)bankIconString{
    [self.bankIconImageView sd_setImageWithURL:[NSURL URLWithString:bankIconString] placeholderImage:[UIImage imageNamed:logo_icbc]];
}

@end
