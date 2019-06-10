//
//  NotVipView.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/6/1.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "NotVipView.h"

@interface NotVipView ()

/**
 开通会员
 */
@property(nonatomic, strong)UIButton *openVipButton;

@end

@implementation NotVipView

-(UIView *)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:0.6];
        self.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight);
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(dt, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 44, 127, 288, 345)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"尊贵的用户您还不是VIP", 2, 255, 255, 255, 1, 255, 255, 255, 2, 21, YES, self) setFrame:DelouchFrameMake(FrameCellView, 0, 244, 375, 19)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"请先开通会员使用", 2, 255, 255, 255, 1, 255, 255, 255, 2, 16, YES, self) setFrame:DelouchFrameMake(FrameCellView, 0, 275, 375, 19)];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(117.5 * (DelouchWidth / 375.0), 387.5 * (DelouchWidth / 375.0), 140 * (DelouchWidth / 375.0), 44 * (DelouchWidth / 375.0))];
        view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        view.layer.shadowColor = [UIColor colorWithRed:137/255.0 green:29/255.0 blue:9/255.0 alpha:0.25].CGColor;
        view.layer.shadowOffset = CGSizeMake(0,8);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 20;
        view.layer.cornerRadius = 22 * (DelouchWidth / 375.0);
        [self addSubview:view];
        
        [self.openVipButton addTarget:self action:@selector(openVip) forControlEvents:UIControlEventTouchUpInside];        
    }
    return self;
}

-(UIButton *)openVipButton{
    if (!_openVipButton) {
        _openVipButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"立即开通", 2, 255, 68, 32, 1, 255, 255, 255, 2, 18, YES, self) setFrame:DelouchFrameMake(FrameCellView, 118, 389, 140, 44)];
    }
    return _openVipButton;
}

-(void)openVip{
    self.notVipBlock();
}

@end
