//
//  HomePageMemberManageTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageMemberManageTableViewCell.h"

@interface HomePageMemberManageTableViewCell ()

/**
 普通会员
 */
@property(nonatomic, strong)UILabel *normalMemberlabel;

/**
 VIP会员
 */
@property(nonatomic, strong)UILabel *vipMemberlabel;

/**
 收益月份
 */
@property(nonatomic, strong)UILabel *memberMouthLabel;

/**
 选择查看的月份
 */
@property(nonatomic, strong)UIImageView *chooseMouthButton;

@end

@implementation HomePageMemberManageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, YES, 14, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 0, 375, 64)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, YES, 14, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 16, 18, 109, 28)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, YES, 14, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 115, 375, 1)];
        
        self.normalMemberlabel.text = @"普通会员 20";
        self.vipMemberlabel.text = @" VIP会员 18";
        
        [self.chooseMouthButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseMouth)]];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"客户明细", 1, 153, 153, 153, 1, 255, 255, 255, 2, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 82, 200, 16)];
    }
    return self;
}

-(void)chooseMouth{
    [BRDatePickerView showDatePickerWithTitle:nil dateType:BRDatePickerModeYM defaultSelValue:nil minDate:[NSDate br_setYear:1970 month:1 day:1] maxDate:[NSDate date] isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        self.memberMouthString = [NSString stringWithFormat:@"%@年%@月",[selectValue componentsSeparatedByString:@"-"][0], [selectValue componentsSeparatedByString:@"-"][1]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"memberManageString" object:[NSString stringWithFormat:@"%@-%@",[selectValue componentsSeparatedByString:@"-"][0], [selectValue componentsSeparatedByString:@"-"][1]]];
        
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
    }];
}

-(UILabel *)normalMemberlabel{
    if (!_normalMemberlabel) {
        _normalMemberlabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 200, 14, 160, 14)];
    }
    return _normalMemberlabel;
}

-(UILabel *)vipMemberlabel{
    if (!_vipMemberlabel) {
        _vipMemberlabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 200, 37, 160, 14)];
    }
    return _vipMemberlabel;
}

-(UIImageView *)chooseMouthButton{
    if (!_chooseMouthButton) {
        _chooseMouthButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_sj_xl, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 100, 20, 20, 26)];
        _chooseMouthButton.contentMode = UIViewContentModeCenter;
    }
    return _chooseMouthButton;
}

-(UILabel *)memberMouthLabel{
    if (!_memberMouthLabel) {
        _memberMouthLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 51, 51, 51, 1, 255, 255, 252, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 23, 26, 81, 13)];
    }
    return _memberMouthLabel;
}

-(void)setMemberMouthString:(NSString *)memberMouthString{
    self.memberMouthLabel.text = memberMouthString;
}

-(void)setNormalMemberString:(NSString *)normalMemberString{
    self.normalMemberlabel.text = normalMemberString;
}

-(void)setVipMemberString:(NSString *)vipMemberString{
    self.vipMemberlabel.text = vipMemberString;
}

@end
