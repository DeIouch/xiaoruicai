//
//  MemberVipInfoTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/18.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "MemberVipInfoTableViewCell.h"

@interface MemberVipInfoTableViewCell ()

/**
 用户头像
 */
@property(nonatomic, strong)UIImageView *userIconImageView;

/**
 用户昵称
 */
@property(nonatomic, strong)UILabel *nickNameLabel;

/**
 到期时间
 */
@property(nonatomic, strong)UILabel *endDateLabel;

/**
 用户ID
 */
@property(nonatomic, strong)UILabel *userNoLabel;

@end

@implementation MemberVipInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(bg_huiyuan, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 0, 375, 154)];
        
        self.contentView.backgroundColor = [UIColor colorWithRed:64 / 255.0 green:64 / 255.0 blue:64 / 255.0 alpha:1];
    }
    return self;
}

-(UIImageView *)userIconImageView{
    if (!_userIconImageView) {
        _userIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", YES, 19, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 30, 41, 38, 38)];
    }
    return _userIconImageView;
}

-(UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 176, 109, 25, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 84, 44, 200, 16)];
    }
    return _nickNameLabel;
}

-(UILabel *)endDateLabel{
    if (!_endDateLabel) {
        _endDateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 176, 109, 25, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 83, 69, 200, 12)];
    }
    return _endDateLabel;
}

-(UILabel *)userNoLabel{
    if (!_userNoLabel) {
        _userNoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 176, 109, 25, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 30, 112, 200, 12)];
    }
    return _userNoLabel;
}

-(void)setUserIconString:(NSString *)userIconString{
    [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:userIconString]];
}

-(void)setNickNameString:(NSString *)nickNameString{
    self.nickNameLabel.text = nickNameString;
}

-(void)setEndDateString:(NSString *)endDateString{
    self.endDateLabel.text = endDateString;
}

-(void)setUserNoString:(NSString *)userNoString{
    self.userNoLabel.text = userNoString;
}

@end
