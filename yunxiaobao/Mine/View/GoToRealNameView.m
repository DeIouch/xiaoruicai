//
//  GoToRealNameView.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/27.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "GoToRealNameView.h"

@implementation GoToRealNameView

-(UIView *)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:0.6];
        self.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight);
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, YES, 5, self) setFrame:DelouchFrameMake(FrameStatusBar, 46, 210, 280, 290)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_gorenzhen_tx, NO, 0, self) setFrame:DelouchFrameMake(FrameStatusBar, 123, 145, 130, 143)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"个人实名认证", 2, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self) setFrame:DelouchFrameMake(FrameStatusBar, 0, 322, 375, 18)];
        
        UILabel *notiLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"您还没有进行实名认证，认证后即可提现", 2, 153, 153, 153, 1, 255, 255, 255, 2, 18, YES, self) setFrame:DelouchFrameMake(FrameStatusBar, 73, 357, 223, 34)];
        notiLabel.numberOfLines = 2;
        [notiLabel sizeToFit];
        
        UIButton *goToCertificationButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"立即认证", 2, 254, 254, 254, 1, 86, 112, 254, 1, 16, YES, self) setFrame:DelouchFrameMake(FrameStatusBar, 86, 413, 201, 43)];
        [DelouchLibrary setbuttonLayer:goToCertificationButton layerMask:22];
        
        [goToCertificationButton addTarget:self action:@selector(goToCertification) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *cancelButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_guanbi_other, NO, 0, self) setFrame:DelouchFrameMake(FrameStatusBar, 285, 215, 37, 37)];
        cancelButton.contentMode = UIViewContentModeCenter;
        [cancelButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancel)]];
    }
    return self;
}

-(void)goToCertification{
    self.hidden = YES;
    [DelouchLibrary pushViewControl:@"GoRealNameViewController" propertyDic:nil];
}

-(void)cancel{
    self.hidden = YES;
}

@end
