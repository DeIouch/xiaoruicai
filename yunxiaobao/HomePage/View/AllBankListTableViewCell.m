//
//  AllBankListTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "AllBankListTableViewCell.h"

@interface AllBankListTableViewCell ()

/**
 银行icon
 */
@property(nonatomic, strong)UIImageView *bankIconImageView;

/**
 银行名称
 */
@property(nonatomic, strong)UILabel *bankNameLabel;

@end

@implementation AllBankListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 353, 15, 8, 13)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 59, 375, 1)];
    }
    return self;
}



-(UIImageView *)bankIconImageView{
    if (!_bankIconImageView) {
        _bankIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 20, 18, 20, 20)];
    }
    return _bankIconImageView;
}

-(UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 59, 23, 250, 15)];
    }
    return _bankNameLabel;
}

-(void)setBankIconString:(NSString *)bankIconString{
    [self.bankIconImageView sd_setImageWithURL:[NSURL URLWithString:bankIconString]];
}

-(void)setBankNameString:(NSString *)bankNameString{
    self.bankNameLabel.text = bankNameString;
}

@end
