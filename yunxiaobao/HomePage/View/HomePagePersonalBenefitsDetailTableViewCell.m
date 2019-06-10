//
//  HomePagePersonalBenefitsDetailTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePagePersonalBenefitsDetailTableViewCell.h"

@interface HomePagePersonalBenefitsDetailTableViewCell ()

/**
 收益类型
 */
@property(nonatomic, strong)UILabel *benefitsTypeLabel;

/**
 收益时间
 */
@property(nonatomic, strong)UILabel *benefitsTimeLabel;

/**
 收益金额
 */
@property(nonatomic, strong)UILabel *benefitsNumberLabel;

@end

@implementation HomePagePersonalBenefitsDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_szmx, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 16, 30, 30)];
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 60, 77, 315, 1)];
    }
    return self;
}

-(UILabel *)benefitsTypeLabel{
    if (!_benefitsTypeLabel) {
        _benefitsTypeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 60, 20, 200, 14)];
    }
    return _benefitsTypeLabel;
}

-(UILabel *)benefitsTimeLabel{
    if (!_benefitsTimeLabel) {
        _benefitsTimeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 60, 47, 200, 12)];
    }
    return _benefitsTimeLabel;
}

-(UILabel *)benefitsNumberLabel{
    if (!_benefitsNumberLabel) {
        _benefitsNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 255, 68, 32, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 269, 18, 90, 18)];
    }
    return _benefitsNumberLabel;
}

-(void)setBenefitsTypeString:(NSString *)benefitsTypeString{
    self.benefitsTypeLabel.text = benefitsTypeString;
}

-(void)setBenefitsTimeString:(NSString *)benefitsTimeString{
    self.benefitsTimeLabel.text = benefitsTimeString;
}

-(void)setBenefitsNumberString:(NSString *)benefitsNumberString{
    self.benefitsNumberLabel.text = [NSString stringWithFormat:@"+%@", benefitsNumberString];
}

@end
