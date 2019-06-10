//
//  ActivitePosInfoTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/31.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "ActivitePosInfoTableViewCell.h"

@implementation ActivitePosInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 54, 360, 1)];
    }
    return self;
}

-(UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 102, 102, 102, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 140, 10, 205, 35)];
    }
    return _infoLabel;
}

-(UITextField *)infoTextField{
    if (!_infoTextField) {
        _infoTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 102, 102, 102, 1, 0, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 140, 10, 220, 35)];
        _infoTextField.textAlignment = NSTextAlignmentRight;
    }
    return _infoTextField;
}

-(UIImageView *)chooseButton{
    if (!_chooseButton) {
        _chooseButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 345, 13, 26, 29)];
        _chooseButton.contentMode = UIViewContentModeCenter;
    }
    return _chooseButton;
}

-(UILabel *)infoTitleLabel{
    if (!_infoTitleLabel) {
        _infoTitleLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 20, 115, 15)];
    }
    return _infoTitleLabel;
}

-(UITextField *)addressTextField{
    if (!_addressTextField) {
        _addressTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 102, 102, 102, 1, 0, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 12, 345, 31)];
    }
    return _addressTextField;
}

-(void)setTitleString:(NSString *)titleString{
    self.infoTitleLabel.text = titleString;
}

-(UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"下一步", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 6, 345, 44)];
        [DelouchLibrary setbuttonLayer:_nextButton layerMask:3];
    }
    return _nextButton;
}

@end
