//
//  CardManageSearchHistoryView.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CardManageSearchHistoryView.h"

@implementation CardManageSearchHistoryView

-(UIView *)initWithFrame:(CGRect)viewFrame{
    if (self = [super initWithFrame:viewFrame]) {
        self.frame = viewFrame;
        self.backgroundColor = [UIColor whiteColor];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"历史搜索", 1, 102, 102, 102, 1, 255, 255, 255, 2, 13, YES, self) setFrame:DelouchFrameMake(FrameCellView, 15, 19, 200, 13)];
        [self.deleteHistoryButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteHistory)]];
    }
    return self;
}

-(UIImageView *)deleteHistoryButton{
    if (!_deleteHistoryButton) {
        _deleteHistoryButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_shanchu, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 333, 7, 35, 35)];
        _deleteHistoryButton.contentMode = UIViewContentModeCenter;
    }
    return _deleteHistoryButton;
}

-(void)deleteHistory{
    
}

@end
