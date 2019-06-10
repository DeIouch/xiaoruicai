//
//  OrderAddressTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "OrderAddressTableViewCell.h"

@interface OrderAddressTableViewCell ()

@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic, strong)UILabel *phoneLabel;

@property(nonatomic, strong)UILabel *addressLabel;

@end

@implementation OrderAddressTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 10, 345, 92)];
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_address, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 28, 55, 11, 15)];
        self.chooseAddressButton.contentMode = UIViewContentModeCenter;
    }
    return self;
}

-(void)chooseAddress{
    
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 25, 56, 15)];
    }
    return _nameLabel;
}

-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 81, 25, 200, 15)];
    }
    return _phoneLabel;
}

-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"安徽省-合肥市-庐阳区 某某某街道阜阳北路与北城大道交口创智天地", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 51, 55, 259, 35)];
        [_addressLabel sizeToFit];
        _addressLabel.numberOfLines = 2;
    }
    return _addressLabel;
}

-(UIImageView *)chooseAddressButton{
    if (!_chooseAddressButton) {
        _chooseAddressButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 330, 41, 26, 30)];
//        _chooseAddressButton.contentMode = UIViewContentModeCenter;
    }
    return _chooseAddressButton;
}

-(void)setNameString:(NSString *)nameString{
    self.nameLabel.text = nameString;
}

-(void)setPhoneString:(NSString *)phoneString{
    self.phoneLabel.text = phoneString;
}

-(void)setAddressString:(NSString *)addressString{
    self.addressLabel.text = addressString;
}

@end
