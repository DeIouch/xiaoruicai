//
//  ConsumptionPlanListHeaderView.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ConsumptionPlanListHeaderView.h"

@interface ConsumptionPlanListHeaderView ()

/**
 月份
 */
@property(nonatomic, strong)UILabel *mouthDayLabel;

/**
 详细日期
 */
@property(nonatomic, strong)UILabel *dateLabel;

/**
 总金额
 */
@property(nonatomic, strong)UILabel *totalNumberLabel;

/**
 收缩按钮
 */
@property(nonatomic, strong)UIImageView *shrinkageButton;

/**
 出账日期
 */
@property(nonatomic, strong)UILabel *accountDateLabel;

/**
 还款日期
 */
@property(nonatomic, strong)UILabel *collectionDateLabel;

@end

@implementation ConsumptionPlanListHeaderView

-(UIView *)initWithFrame:(CGRect)viewFrame{
    if (self = [super initWithFrame:viewFrame]) {
        self.frame = viewFrame;
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 0, 0, 375, 70)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(248, 248, 248, 1, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 0, 70, 375, 35)];
        
        self.shrinkageButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_zd_xl, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 336, 21, 30, 27)];
        self.shrinkageButton.contentMode = UIViewContentModeCenter;
        [self.shrinkageButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shrinkage)]];
    }
    return self;
}

-(void)shrinkage{
    self.shrinkageBlock();
}

-(UILabel *)mouthDayLabel{
    if (!_mouthDayLabel) {
        _mouthDayLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 0, 0, 0, 1, 255, 255, 255, 2, 18, YES, self) setFrame:DelouchFrameMake(FrameCellView, 21, 20, 100, 17)];
    }
    return _mouthDayLabel;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 12, YES, self) setFrame:DelouchFrameMake(FrameCellView, 20, 40, 150, 12)];
    }
    return _dateLabel;
}

-(UILabel *)totalNumberLabel{
    if (!_totalNumberLabel) {
        _totalNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self) setFrame:DelouchFrameMake(FrameCellView, 190, 26, 150, 18)];
    }
    return _totalNumberLabel;
}

-(UILabel *)accountDateLabel{
    if (!_accountDateLabel) {
        _accountDateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self) setFrame:DelouchFrameMake(FrameCellView, 15, 83, 150, 12)];
    }
    return _accountDateLabel;
}

-(UILabel *)collectionDateLabel{
    if (!_collectionDateLabel) {
        _collectionDateLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self) setFrame:DelouchFrameMake(FrameCellView, 230, 83, 130, 12)];
    }
    return _collectionDateLabel;
}

//-(UIImageView *)shrinkageButton{
//    if (!_shrinkageButton) {
//        _shrinkageButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_zd_xl_slices, NO, 0, self) setFrame:DelouchFrameMake(FrameCellView, 336, 21, 30, 27)];
//    }
//    return _shrinkageButton;
//}

-(void)setMouthDayString:(NSString *)mouthDayString{
    self.mouthDayLabel.text = mouthDayString;
}

-(void)setDateString:(NSString *)dateString{
    self.dateLabel.text = dateString;
}

-(void)setTotalNumberString:(NSString *)totalNumberString{
//    self.totalNumberLabel.text = totalNumberString;
    [DelouchLibrary setMoneyLabel:self.totalNumberLabel moneyText:totalNumberString bigFont:18 smallFont:14];
}

-(void)setAccountDateString:(NSString *)accountDateString{
    self.accountDateLabel.text = [NSString stringWithFormat:@"出账日期   %@", accountDateString];
}

-(void)setCollectionDateString:(NSString *)collectionDateString{
    self.collectionDateLabel.text = [NSString stringWithFormat:@"还款日期   %@", collectionDateString];
}

@end
