//
//  ShippingAddressListTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ShippingAddressListTableViewCell.h"

@interface ShippingAddressListTableViewCell ()

/**
 是否选中
 */
@property(nonatomic, strong)UIImageView *isChooseImageView;

/**
 用户姓名
 */
@property(nonatomic, strong)UILabel *nameLabel;

/**
 是否是默认地址
 */
@property(nonatomic, strong)UILabel *isDefaultLabel;

/**
 手机号码
 */
@property(nonatomic, strong)UILabel *phoneLabel;

/**
 详细地址
 */
@property(nonatomic, strong)UILabel *addressLabel;

/**
 修改地址信息
 */
@property(nonatomic, strong)UIImageView *editAddressInfoButton;

@end

@implementation ShippingAddressListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, YES, 3, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 5, 345, 92)];
        
        [self.editAddressInfoButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(editAddressInfo)]];
    }
    return self;
}

-(void)editAddressInfo{
    self.editAddressInfoBlock(_addressModel, _defaulteAddressString);
}

-(UIImageView *)isChooseImageView{
    if (!_isChooseImageView) {
        _isChooseImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_check, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 50, 16, 12)];
    }
    return _isChooseImageView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 52, 27, 31, 15)];
    }
    return _nameLabel;
}

-(UILabel *)isDefaultLabel{
    if (!_isDefaultLabel) {
        _isDefaultLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"默认", 1, 86, 112, 254, 1, 255, 255, 255, 2, 11, YES, self.contentView) setFrame:DelouchFrameMake(FrameNotChange, _nameLabel.frame.size.width + _nameLabel.frame.origin.x + 7 * (DelouchWidth / 375.0), 29 * (DelouchWidth / 375.0), 30 * (DelouchWidth / 375.0), 11 * (DelouchWidth / 375.0))];
    }
    return _isDefaultLabel;
}

-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 156, 27, 150, 16)];
    }
    return _phoneLabel;
}

-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"安徽省-合肥市-庐阳区某某某街道阜阳北路与北城大道交口创智天地", 1, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 52, 57, 254, 35)];
        _addressLabel.numberOfLines = 2;
        [_addressLabel sizeToFit];
    }
    return _addressLabel;
}

-(UIImageView *)editAddressInfoButton{
    if (!_editAddressInfoButton) {
        _editAddressInfoButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_AddressEditing, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 323, 37, 37, 38)];
        _editAddressInfoButton.contentMode = UIViewContentModeCenter;
    }
    return _editAddressInfoButton;
}

-(void)setIsChooseAddressBOOL:(BOOL)isChooseAddressBOOL{
    self.isChooseImageView.hidden = !isChooseAddressBOOL;
}

-(void)setIsDefaultAddressBOOL:(BOOL)isDefaultAddressBOOL{
    if (isDefaultAddressBOOL) {
        self.isDefaultLabel.text = @"默认";
    }else{
        self.isDefaultLabel.text = @"";
    }
}

-(void)setNameString:(NSString *)nameString{
    self.nameLabel.text = nameString;
    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, [DelouchLibrary sizeWithText:nameString withFont:16].width > 110 * (DelouchWidth / 375.0) ? 110 * (DelouchWidth / 375.0) : [DelouchLibrary sizeWithText:nameString withFont:16].width, self.nameLabel.frame.size.height);
}

-(void)setPhoneString:(NSString *)phoneString{
    self.phoneLabel.text = phoneString;
}

-(void)setAddressString:(NSString *)addressString{
    self.addressLabel.text = addressString;
}

-(void)setAddressModel:(AddressModel *)addressModel{
    _addressModel = addressModel;
}

-(void)setDefaulteAddressString:(NSString *)defaulteAddressString{
    _defaulteAddressString = defaulteAddressString;
}

@end
