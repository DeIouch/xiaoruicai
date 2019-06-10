//
//  MemberVipPrivilegeTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/18.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "MemberVipPrivilegeTableViewCell.h"

@interface MemberVipPrivilegeTableViewCell ()

/**
 使用说明
 */
@property(nonatomic, strong)UIImageView *useDirectionsButton;

@end

@implementation MemberVipPrivilegeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithRed:64 / 255.0 green:64 / 255.0 blue:64 / 255.0 alpha:1];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"VIP特权", 1, 255, 255, 255, 1, 255, 255, 255, 2, 20, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 21, 150, 19)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"使用说明", 3, 153, 153, 153, 1, 255, 255, 255, 2, 13, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 200, 21, 147, 13)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"账单管理", 2, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 14, 119, 68, 12)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"自动还款", 2, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 109, 119, 68, 12)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"信用诊断", 2, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 201, 119, 68, 12)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"信用规划", 2, 255, 255, 255, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 295, 119, 68, 12)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_zdgl, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 55, 45, 45)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_zdhk, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 118, 55, 45, 45)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_xyzd, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 212, 55, 45, 45)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_xygh, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 306, 55, 45, 45)];
        
        [self.useDirectionsButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(useDirections)]];
        
    }
    return self;
}

-(void)useDirections{
    
}

-(UIImageView *)useDirectionsButton{
    if (!_useDirectionsButton) {
        _useDirectionsButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 344, 12, 26, 30)];
        _useDirectionsButton.contentMode = UIViewContentModeCenter;
    }
    return _useDirectionsButton;
}

@end
