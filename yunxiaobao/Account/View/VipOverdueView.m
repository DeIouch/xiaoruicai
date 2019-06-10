//
//  VipOverdueView.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/6/2.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "VipOverdueView.h"

@interface VipOverdueView ()

/**
 开通会员
 */
@property(nonatomic, strong)UIButton *openVipButton;

/**
 关闭提示框
 */
@property(nonatomic, strong)UIImageView *closeNotiButton;

@end

@implementation VipOverdueView

-(UIView *)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:0.6];
        self.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight);
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(dt_no, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 44, 127, 288, 345)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"尊贵的会员即将到期", 2, 255, 255, 255, 1, 255, 255, 255, 2, 21, YES, self) setFrame:DelouchFrameMake(FrameCellView, 0, 244, 375, 19)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"会员特权即将失效", 2, 255, 255, 255, 1, 255, 255, 255, 2, 16, YES, self) setFrame:DelouchFrameMake(FrameCellView, 0, 275, 375, 19)];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(117.5 * (DelouchWidth / 375.0), 387.5 * (DelouchWidth / 375.0), 140 * (DelouchWidth / 375.0), 44 * (DelouchWidth / 375.0))];
        view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        view.layer.shadowColor = [UIColor colorWithRed:137/255.0 green:29/255.0 blue:9/255.0 alpha:0.25].CGColor;
        view.layer.shadowOffset = CGSizeMake(0,8);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 20;
        view.layer.cornerRadius = 22 * (DelouchWidth / 375.0);
        [self addSubview:view];
        [self.openVipButton addTarget:self action:@selector(openVip) forControlEvents:UIControlEventTouchUpInside];
        
        [self.closeNotiButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeNoti)]];
    }
    return self;
}

-(void)closeNoti{
    self.hidden = YES;
}

-(UIButton *)openVipButton{
    if (!_openVipButton) {
        _openVipButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"立即开通", 2, 255, 68, 32, 1, 255, 255, 255, 2, 18, YES, self) setFrame:DelouchFrameMake(FrameCellView, 118, 389, 140, 44)];
    }
    return _openVipButton;
}

-(void)openVip{
    self.vipOverdueBlock();
}

-(UIImageView *)closeNotiButton{
    if (!_closeNotiButton) {
        _closeNotiButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_guanbi_vip, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 158, 492, 59, 59)];
    }
    return _closeNotiButton;
}

@end
