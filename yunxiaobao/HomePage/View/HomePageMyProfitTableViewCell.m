//
//  HomePageMyProfitTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/10.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageMyProfitTableViewCell.h"

@implementation HomePageMyProfitTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"我的收益", 1, 51, 51, 51, 1, 255, 255, 255, 1, 20, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 16, 11, 300, 21)];
        
        [self.mybenefitsImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mybenefits)]];
        
        [self.myMemberImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myMember)]];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"总收益（元）", 1, 255, 255, 255, 1, 255, 255, 255, 2, 11, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 30, 85, 83, 13)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"推荐奖", 2, 255, 255, 255, 1, 255, 255, 255, 2, 11, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 48, 130, 37, 13)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"POS分润", 2, 255, 255, 255, 1, 255, 255, 255, 2, 11, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 138, 130, 48, 13)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"普通会员", 2, 255, 255, 255, 1, 255, 255, 255, 2, 11, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 244, 82, 47, 13)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"VIP会员", 2, 255, 255, 255, 1, 255, 255, 255, 2, 11, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 244, 130, 42, 13)];
        
//        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_earnings_Head_for, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 195, 66, 14, 14)];
        
//        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_earnings_Head_for, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 336, 66, 14, 14)];
        
        [self.seeMyAllBenefitsImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mybenefits)]];
        
        [self.seeMyAllMemberImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myMember)]];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"近期还款提醒", 1, 51, 51, 51, 1, 255, 255, 255, 1, 20, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 16, 185, 300, 21)];
    }
    return self;
}

-(void)mybenefits{
    self.homePageSeeMyBenefitsBlock(_allProfitString, _recommendProfitString, _posProfitString);
}

-(void)myMember{
    self.homePageMyMemberBlock();
}

-(UIImageView *)mybenefitsImageView{
    if (!_mybenefitsImageView) {
        _mybenefitsImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(background_earnings, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 50, 204, 105)];
    }
    return _mybenefitsImageView;
}

-(UIImageView *)myMemberImageView{
    if (!_myMemberImageView) {
        _myMemberImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(background_members, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 231, 50, 129, 105)];
    }
    return _myMemberImageView;
}

-(UILabel *)allProfitLabel{
    if (!_allProfitLabel) {
        _allProfitLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 31, 63, 180, 23)];
    }
    return _allProfitLabel;
}

-(UILabel *)posProfitLabel{
    if (!_posProfitLabel) {
        _posProfitLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 255, 255, 255, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 31, 110, 72, 17)];
    }
    return _posProfitLabel;
}

-(UILabel *)recommendProfitLabel{
    if (!_recommendProfitLabel) {
        _recommendProfitLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 255, 255, 255, 1, 255, 255, 255, 2, 21, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 126, 110, 73, 17)];
    }
    return _recommendProfitLabel;
}

-(UILabel *)normalMemberLabel{
    if (!_normalMemberLabel) {
        _normalMemberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 246, 60, 80, 13)];
    }
    return _normalMemberLabel;
}

-(UILabel *)vipMenberLabel{
    if (!_vipMenberLabel) {
        _vipMenberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 255, 255, 255, 1, 255, 255, 255, 2, 18, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 246, 108, 80, 13)];
    }
    return _vipMenberLabel;
}

-(void)setAllProfitString:(NSString *)allProfitString{
//    self.allProfitLabel.text = allProfitString;
    if (allProfitString.length == 0) {
        allProfitString = @"0";
    }
    _allProfitString = allProfitString;
    [DelouchLibrary setMoneyLabel:self.allProfitLabel moneyText:allProfitString bigFont:21 smallFont:12];
}

-(void)setRecommendProfitString:(NSString *)recommendProfitString{
//    self.recommendProfitLabel.text = recommendProfitString;
    if (recommendProfitString.length == 0) {
        recommendProfitString = @"0";
    }
    _recommendProfitString = recommendProfitString;
    [DelouchLibrary setMoneyLabel:self.recommendProfitLabel moneyText:recommendProfitString bigFont:18 smallFont:12];
}

-(void)setPosProfitString:(NSString *)posProfitString{
//    self.posProfitLabel.text= posProfitString;
    if (posProfitString.length == 0) {
        posProfitString = @"0";
    }
    _posProfitString = posProfitString;
    [DelouchLibrary setMoneyLabel:self.posProfitLabel moneyText:posProfitString bigFont:18 smallFont:12];
}

-(void)setNormalMemberString:(NSString *)normalMemberString{
    if (normalMemberString.length == 0) {
        normalMemberString = @"0";
    }
    self.normalMemberLabel.text = normalMemberString;
}

-(void)setVipMenberString:(NSString *)vipMenberString{
    if (vipMenberString.length == 0) {
        vipMenberString = @"0";
    }
    self.vipMenberLabel.text = vipMenberString;
}

-(UIImageView *)seeMyAllBenefitsImageView{
    if (!_seeMyAllBenefitsImageView) {
        _seeMyAllBenefitsImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_earnings_Head_for, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 195, 66, 14, 14)];
    }
    return _seeMyAllBenefitsImageView;
}

-(UIImageView *)seeMyAllMemberImageView{
    if (!_seeMyAllMemberImageView) {
        _seeMyAllMemberImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_earnings_Head_for, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 336, 66, 14, 14)];
    }
    return _seeMyAllMemberImageView;
}

@end
