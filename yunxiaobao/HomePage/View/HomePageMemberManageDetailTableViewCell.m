//
//  HomePageMemberManageDetailTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageMemberManageDetailTableViewCell.h"

@interface HomePageMemberManageDetailTableViewCell ()

/**
 会员头像
 */
@property(nonatomic, strong)UIImageView *memberIconImageView;

/**
 会员姓名
 */
@property(nonatomic, strong)UILabel *membernameLabel;

/**
 普通会员
 */
@property(nonatomic, strong)UIImageView *normalMemberImageView;

/**
 vip会员
 */
@property(nonatomic, strong)UIImageView *vipMemberImageView;

/**
 时间
 */
@property(nonatomic, strong)UILabel *timeLabel;

/**
 拨打电话
 */
@property(nonatomic, strong)UIImageView *phoneImageView;

@end

@implementation HomePageMemberManageDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 60, 77, 315, 1)];
    }
    return self;
}

-(UIImageView *)memberIconImageView{
    if (!_memberIconImageView) {
        _memberIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", YES, 20, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 16, 40, 40)];
    }
    return _memberIconImageView;
}

-(UILabel *)membernameLabel{
    if (!_membernameLabel) {
        _membernameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 69, 19, 100, 15)];
    }
    return _membernameLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 68, 42, 200, 12)];
    }
    return _timeLabel;
}

-(UIImageView *)normalMemberImageView{
    if (!_normalMemberImageView) {
        _normalMemberImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, _membernameLabel.frame.size.width + _membernameLabel.frame.origin.x + 10 * (DelouchWidth / 375.0), _membernameLabel.frame.origin.y - 3 * (DelouchWidth / 375.0),  15 * (DelouchWidth / 375.0), 19 * (DelouchWidth / 375.0))];
    }
    return _normalMemberImageView;
}

-(UIImageView *)phoneImageView{
    if (!_phoneImageView) {
        _phoneImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_telephone, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 324, 15, 41, 42)];
        _phoneImageView.contentMode = UIViewContentModeCenter;
    }
    return _phoneImageView;
}

-(UIImageView *)vipMemberImageView{
    if (!_vipMemberImageView) {
        _vipMemberImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameNotChange, _membernameLabel.frame.size.width + _membernameLabel.frame.origin.x + 10 * (DelouchWidth / 375.0), _membernameLabel.frame.origin.y - 2 * (DelouchWidth / 375.0), 20 * (DelouchWidth / 375.0), 17 * (DelouchWidth / 375.0))];
    }
    return _vipMemberImageView;
}

-(void)setMemberIconString:(NSString *)memberIconString{
    [self.memberIconImageView sd_setImageWithURL:[NSURL URLWithString:memberIconString] placeholderImage:[UIImage imageNamed:icon_heads]];
    
//    self.memberIconImageView.image = [UIImage imageNamed:icon_heads];
}

-(void)setMembernameString:(NSString *)membernameString{
    self.membernameLabel.frame = CGRectMake(self.membernameLabel.frame.origin.x, self.membernameLabel.frame.origin.y, [DelouchLibrary sizeWithText:membernameString withFont:15].width, self.membernameLabel.frame.size.height);
    self.membernameLabel.text = membernameString;
}

-(void)setPhoneString:(NSString *)phoneString{
    _phoneString = phoneString;
    [self.phoneImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callPhone)]];
}

-(void)setMemberTypeString:(NSString *)memberTypeString{
    if (memberTypeString.length > 0) {
        self.vipMemberImageView.image = [UIImage imageNamed:icon_VIP_hy];
        self.vipMemberImageView.frame = CGRectMake(_membernameLabel.frame.size.width + _membernameLabel.frame.origin.x + 10 * (DelouchWidth / 375.0), _membernameLabel.frame.origin.y - 2 * (DelouchWidth / 375.0), 20 * (DelouchWidth / 375.0), 17 * (DelouchWidth / 375.0));
    }else{
        self.normalMemberImageView.image = [UIImage imageNamed:icon_pthy];
        self.normalMemberImageView.frame = CGRectMake(_membernameLabel.frame.size.width + _membernameLabel.frame.origin.x + 10 * (DelouchWidth / 375.0), _membernameLabel.frame.origin.y - 3 * (DelouchWidth / 375.0),  15 * (DelouchWidth / 375.0), 19 * (DelouchWidth / 375.0));
    }
//    if ([memberTypeString isEqualToString:@"1"]) {
//        self.vipMemberImageView.image = [UIImage imageNamed:icon_VIP_hy];
//    }else{
//        self.normalMemberImageView.image = [UIImage imageNamed:icon_pthy];
//    }
}

-(void)setTimeString:(NSString *)timeString{
    self.timeLabel.text = timeString;
}

-(void)callPhone{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_phoneString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
