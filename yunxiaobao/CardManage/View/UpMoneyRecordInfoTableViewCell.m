//
//  UpMoneyRecordInfoTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/6/3.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "UpMoneyRecordInfoTableViewCell.h"

@interface UpMoneyRecordInfoTableViewCell ()

/**
 提额类型
 */
@property(nonatomic, strong)UILabel *upTypeLabel;

/**
 提额金额
 */
@property(nonatomic, strong)UILabel *upMoneyLabel;

/**
 时间
 */
@property(nonatomic, strong)UILabel *upTimeLabel;

@end

@implementation UpMoneyRecordInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    }
    return self;
}



-(UILabel *)upTypeLabel{
    if (!_upTypeLabel) {
        _upTypeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 11, 0, 80, 12)];
    }
    return _upTypeLabel;
}

-(UILabel *)upMoneyLabel{
    if (!_upMoneyLabel) {
        _upMoneyLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 121, 0, 90, 12)];
    }
    return _upMoneyLabel;
}

-(UILabel *)upTimeLabel{
    if (!_upTimeLabel) {
        _upTimeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 219, 0, 90, 12)];
    }
    return _upTimeLabel;
}

-(void)setUpTypeString:(NSString *)upTypeString{
    self.upTypeLabel.text = upTypeString;
}

-(void)setUpMoneyString:(NSString *)upMoneyString{
    self.upMoneyLabel.text = upMoneyString;
}

-(void)setUpTimeString:(NSString *)upTimeString{
    self.upTimeLabel.text = upTimeString;
}

@end
