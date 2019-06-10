//
//  HomePagePersonalBenefitsTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePagePersonalBenefitsTableViewCell.h"

@interface HomePagePersonalBenefitsTableViewCell ()

/**
 收益总额
 */
@property(nonatomic, strong)UILabel *totalBenefitsLabel;

/**
 收益月份
 */
@property(nonatomic, strong)UILabel *benefitsMouthLabel;

/**
 本月POS分润额
 */
@property(nonatomic, strong)UILabel *posBenefitsLabel;

/**
 本月推荐额
 */
@property(nonatomic, strong)UILabel *recommendLabel;

/**
 选择查看的月份
 */
@property(nonatomic, strong)UIImageView *chooseMouthButton;

@end

@implementation HomePagePersonalBenefitsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, YES, 14, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 0, 375, 64)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, YES, 14, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 16, 18, 109, 28)];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15 * (DelouchWidth / 375.0),79 * (DelouchWidth / 375.0),345 * (DelouchWidth / 375.0),84 * (DelouchWidth / 375.0))];
        view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.07].CGColor;
        view.layer.shadowOffset = CGSizeMake(0,2);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 8;
        view.layer.cornerRadius = 3 * (DelouchWidth / 375.0);
        [self.contentView addSubview:view];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"本月收益总额", 3, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 259, 37, 102, 12)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"本期收益明细", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 191, 200, 16)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"本月POS分润额", 2, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 40, 127, 124, 12)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"本月推荐额", 2, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 204, 127, 140, 12)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, YES, 14, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 224, 375, 1)];
        
        [self.chooseMouthButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseMouth)]];        
    }
    return self;
}

-(void)chooseMouth{
    [BRDatePickerView showDatePickerWithTitle:nil dateType:BRDatePickerModeYM defaultSelValue:nil minDate:[NSDate br_setYear:1970 month:1 day:1] maxDate:[NSDate date] isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        self.benefitsMouthString = [NSString stringWithFormat:@"%@年%@月",[selectValue componentsSeparatedByString:@"-"][0], [selectValue componentsSeparatedByString:@"-"][1]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"benefitsMouthString" object:[NSString stringWithFormat:@"%@-%@",[selectValue componentsSeparatedByString:@"-"][0], [selectValue componentsSeparatedByString:@"-"][1]]];
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
    }];
}

-(UILabel *)totalBenefitsLabel{
    if (!_totalBenefitsLabel) {
        _totalBenefitsLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 201, 17, 160, 17)];
    }
    return _totalBenefitsLabel;
}

-(UILabel *)benefitsMouthLabel{
    if (!_benefitsMouthLabel) {
        _benefitsMouthLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 51, 51, 51, 1, 255, 255, 252, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 23, 26, 81, 13)];
    }
    return _benefitsMouthLabel;
}

-(UILabel *)posBenefitsLabel{
    if (!_posBenefitsLabel) {
        _posBenefitsLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 51, 51, 51, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 40, 102, 124, 20)];
    }
    return _posBenefitsLabel;
}

-(UILabel *)recommendLabel{
    if (!_recommendLabel) {
        _recommendLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 51, 51, 51, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 204, 102, 140, 20)];
    }
    return _recommendLabel;
}

-(UIImageView *)chooseMouthButton{
    if (!_chooseMouthButton) {
        _chooseMouthButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_sj_xl, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 100, 20, 20, 26)];
        _chooseMouthButton.contentMode = UIViewContentModeCenter;
    }
    return _chooseMouthButton;
}

-(void)setBenefitsMouthString:(NSString *)benefitsMouthString{
    self.benefitsMouthLabel.text = benefitsMouthString;
}

-(void)setTotalBenefitsString:(NSString *)totalBenefitsString{
//    self.totalBenefitsLabel.text = totalBenefitsString;
    [DelouchLibrary setMoneyLabel:self.totalBenefitsLabel moneyText:totalBenefitsString == nil? @"0":totalBenefitsString bigFont:18 smallFont:12];
}

-(void)setPosBenefitsString:(NSString *)posBenefitsString{
    _posBenefitsString = posBenefitsString;
//    self.posBenefitsLabel.text = posBenefitsString;
    [DelouchLibrary setMoneyLabel:self.posBenefitsLabel moneyText:posBenefitsString == nil? @"0":posBenefitsString bigFont:21 smallFont:12];
}

-(void)setRecommendString:(NSString *)recommendString{
    _recommendString = recommendString;
    self.recommendLabel.text = recommendString;
    [DelouchLibrary setMoneyLabel:self.recommendLabel moneyText:recommendString == nil? @"0":recommendString bigFont:21 smallFont:12];
}

@end
