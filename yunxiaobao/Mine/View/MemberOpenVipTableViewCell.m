//
//  MemberOpenVipTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/18.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "MemberOpenVipTableViewCell.h"

@interface MemberOpenVipTableViewCell ()

/**
 查看会员协议
 */
@property(nonatomic, strong)UIImageView *seeVipAgreementButton;

@end

@implementation MemberOpenVipTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 226, 375, 1000)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 142, 375, 10)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"会员升级服务声明", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 10, 200, 12)];
        
        UILabel *notiLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"1、成为本系统VIP会员，享受账单管理、自动还款、信用诊断、信用规划、技术更新、二级分销等全部会员权益；\n2、享有推荐权益，并可获得推广的二级分销收益；\n3、二级分销收益：\n     直接推荐朋友升级VIP,享受100元+万分之5奖励；\n     间接推荐朋友升级VIP,享受50元+万分之3奖励。", 1, 153, 153, 153, 1, 255, 255, 255, 2, 11, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 31, 342, 100)];
        notiLabel.numberOfLines = 0;
        [notiLabel sizeToFit];
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 202, 375, 34)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"VIP会员开通协议", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 170, 200, 16)];
        
        [self.seeVipAgreementButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeVipAgreement)]];
    }
    return self;
}

-(void)seeVipAgreement{
    
}

-(UIImageView *)seeVipAgreementButton{
    if (!_seeVipAgreementButton) {
        _seeVipAgreementButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 344, 162, 26, 30)];
        _seeVipAgreementButton.contentMode = UIViewContentModeCenter;
    }
    return _seeVipAgreementButton;
}

@end
