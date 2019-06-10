//
//  AddNewAddressTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "AddNewAddressTableViewCell.h"

@implementation AddNewAddressTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 10, 345, 54)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"新增收货地址", 1, 86, 112, 254, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 155, 30, 200, 15)];
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_new, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 127, 29, 16, 16)];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.addNewAddressBlock();
}

@end
