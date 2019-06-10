//
//  HomePageToolTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/10.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageToolTableViewCell.h"

@implementation HomePageToolTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cardHolderButton = [[DelouchImageButton alloc]initButton:DelouchImageButtonInfomake(icon_cardholder, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 24, 44, 44)];
        self.cardHolderButton.tag = 1;
        [self.cardHolderButton addTarget:self action:@selector(homePageToolButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.intelligentPlanButton = [[DelouchImageButton alloc]initButton:DelouchImageButtonInfomake(icon_Intelligent_planning, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 119, 24, 44, 44)];
        self.intelligentPlanButton.tag = 2;
        [self.intelligentPlanButton addTarget:self action:@selector(homePageToolButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.applyPosButton = [[DelouchImageButton alloc]initButton:DelouchImageButtonInfomake(icon_Apply_for_POS, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 213, 24, 44, 44)];
        self.applyPosButton.tag = 3;
        [self.applyPosButton addTarget:self action:@selector(homePageToolButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.activateMachButton = [[DelouchImageButton alloc]initButton:DelouchImageButtonInfomake(icon_Friend_recommended, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 306, 24, 44, 44)];
        self.activateMachButton.tag = 4;
        [self.activateMachButton addTarget:self action:@selector(homePageToolButton:) forControlEvents:UIControlEventTouchUpInside];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"持卡人", 2, 51, 51, 51, 1, 255, 255, 255, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 20, 74, 55, 16)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"智能规划", 2, 51, 51, 51, 1, 255, 255, 255, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 114, 74, 55, 16)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"购买POS", 2, 51, 51, 51, 1, 255, 255, 255, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 208, 74, 55, 16)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"激活POS", 2, 51, 51, 51, 1, 255, 255, 255, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 301, 74, 55, 16)];
    }
    return self;
}

-(void)homePageToolButton:(UIButton *)button{
    self.homepageToolBlock(button.tag);
}

@end
