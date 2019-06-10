//
//  CardHolderTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CardHolderTableViewCell.h"

@interface CardHolderTableViewCell ()

@property(nonatomic, strong)UICollectionView *collectionView;

@end

@implementation CardHolderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 0, 375, 1)];
        
        [self.exportBillButton addTarget:self action:@selector(exportBill) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)exportBill{
    self.importBillBlock(_appCustomersListModel);
}

-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 26, 26, 26, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 26, 23, 49, 16)];
        _userNameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16 * (DelouchWidth / 375.0)];
    }
    return _userNameLabel;
}

-(UILabel *)userPhoneLabel{
    if (!_userPhoneLabel) {
        _userPhoneLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 102, 102, 102, 1, 255, 25, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 75, 23, 150, 16)];
    }
    return _userPhoneLabel;
}

-(UILabel *)cardNumberLabel{
    if (!_cardNumberLabel) {
        _cardNumberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 88, 65, 100, 13)];
    }
    return _cardNumberLabel;
}

-(UILabel *)noCardNumberlabel{
    if (!_noCardNumberlabel) {
        _noCardNumberlabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 49, 65, 100, 13)];
    }
    return _noCardNumberlabel;
}

-(UIImageView *)noCardImageView{
    if (!_noCardImageView) {
        _noCardImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 63, 17, 17)];
    }
    return _noCardImageView;
}

-(UIButton *)exportBillButton{
    if (!_exportBillButton) {
        _exportBillButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"导入账单", 2, 86, 112, 254, 1, 255, 255, 255, 2, 13, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 270, 38, 80, 29)];
        [_exportBillButton.layer setCornerRadius:15];
        _exportBillButton.layer.masksToBounds = YES;
        [_exportBillButton.layer setBorderColor:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1].CGColor];
        [_exportBillButton.layer setBorderWidth:1.0];
    }
    return _exportBillButton;
}

-(void)setUserNameString:(NSString *)userNameString{
    self.userNameLabel.text = userNameString;
    self.userNameLabel.frame = CGRectMake(self.userNameLabel.frame.origin.x, self.userNameLabel.frame.origin.y, [DelouchLibrary sizeWithText:userNameString withFont:16].width, self.userNameLabel.frame.size.height);
    
    self.userPhoneLabel.frame = CGRectMake(self.userNameLabel.frame.origin.x + self.userNameLabel.frame.size.width + 8 * (DelouchWidth / 375.0), self.userPhoneLabel.frame.origin.y, self.userPhoneLabel.frame.size.width, self.userPhoneLabel.frame.size.height);
}

-(void)setUserPhoneString:(NSString *)userPhoneString{
    self.userPhoneLabel.text = userPhoneString;
}

-(void)setCardNumberString:(NSString *)cardNumberString{
    _cardNumberString = cardNumberString;
    if ([cardNumberString isEqualToString:@"0"]) {
        self.noCardNumberlabel.text = @"暂无卡片";
        self.noCardImageView.image = [UIImage imageNamed:icon_no_card];
        self.cardNumberLabel.hidden = YES;
    }else{
        self.cardNumberLabel.text = [NSString stringWithFormat:@"%@张卡片", cardNumberString];
        
        self.cardNumberLabel.frame = CGRectMake((40 + 12 * ([cardNumberString intValue] > 4 ? 4 : [cardNumberString intValue])) * (DelouchWidth / 375.0), 65 * (DelouchWidth / 375.0), 100 * (DelouchWidth / 375.0), 13 * (DelouchWidth / 375.0));
        
        self.collectionView.frame = CGRectMake(25 * (DelouchWidth / 375.0), 63 * (DelouchWidth / 375.0), (5 + 12 * ([cardNumberString intValue] > 4 ? 4 : [cardNumberString intValue])) * (DelouchWidth / 375.0), (DelouchWidth / 375.0) * 17);
        
        self.noCardNumberlabel.hidden = YES;
        self.noCardImageView.hidden = YES;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_cardNumberString intValue] > 4 ? 4 : [_cardNumberString intValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardHolderCollectionViewCell *cell = (CardHolderCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CardHolderCollectionViewCell" forIndexPath:indexPath];
    
    cell.bankIconString = @"zwt_yuan_128";
    
    return cell;
}

-(void)setAppCustomersListModel:(AppCustomersListModel *)appCustomersListModel{
    _appCustomersListModel = appCustomersListModel;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(17 * (DelouchWidth / 375.0), 17 * (DelouchWidth / 375.0));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = -5 * (DelouchWidth / 375.0);
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(25 * (DelouchWidth / 375.0), 63 * (DelouchWidth / 375.0), 170 * (DelouchWidth / 375.0), 17 * (DelouchWidth / 375.0)) collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[CardHolderCollectionViewCell class] forCellWithReuseIdentifier:@"CardHolderCollectionViewCell"];
        [self.contentView addSubview:self.collectionView];
    }
    return _collectionView;
}

@end
