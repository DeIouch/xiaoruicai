//
//  ShareView.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/6/1.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ShareView.h"

@interface ShareView ()

/**
 分享微信好友
 */
@property(nonatomic, strong)UIImageView *shareWxFriendButton;

/**
 分享微信朋友圈
 */
@property(nonatomic, strong)UIImageView *shareWxCircleButton;

/**
 背景view
 */
@property(nonatomic, strong)UIView *backView;

@end

@implementation ShareView

-(UIView *)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:0.6];
        self.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight);
        self.backView = [[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self) setFrame:DelouchFrameMake(FrameNotChange, 0, DelouchHeight - 155 * (DelouchWidth / 375.0), DelouchWidth, 155 * (DelouchWidth / 375.0))];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"微信好友", 2, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.backView) setFrame:DelouchFrameMake(FrameCellView, 61, 79, 76, 14)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"朋友圈", 2, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.backView) setFrame:DelouchFrameMake(FrameCellView, 240, 79, 76, 14)];
        
        [self.shareWxFriendButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareWxFriend)]];
        
        [self.shareWxCircleButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareWxCircle)]];
    }
    return self;
}

-(void)shareWxFriend{
    self.shareWxFriendBlock();
}

-(void)shareWxCircle{
    self.shareWxCircleBlock();
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch = touches.anyObject;
    CGPoint rootViewLocation = [touch locationInView:self];
    if (rootViewLocation.y < self.backView.frame.origin.y) {
        self.hidden = YES;
    }
}

-(UIImageView *)shareWxFriendButton{
    if (!_shareWxFriendButton) {
        _shareWxFriendButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(logo_wxhy, NO, 0, self.backView) setFrame:DelouchFrameMake(FrameCellView, 60, 7, 76, 76)];
        _shareWxFriendButton.contentMode = UIViewContentModeCenter;
    }
    return _shareWxFriendButton;
}

-(UIImageView *)shareWxCircleButton{
    if (!_shareWxCircleButton) {
        _shareWxCircleButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(logo_pyq, NO, 0, self.backView) setFrame:DelouchFrameMake(FrameCellView, 239, 7, 76, 76)];
        _shareWxCircleButton.contentMode = UIViewContentModeCenter;
    }
    return _shareWxCircleButton;
}

@end
