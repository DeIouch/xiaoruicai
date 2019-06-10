//
//  MemberVipPackageTableViewCell.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/18.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "MemberVipPackageTableViewCell.h"
#import "VipPackageCollectionViewCell.h"
#import "VipPackageModel.h"

@interface MemberVipPackageTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic, strong)UIImageView *seeHelpButton;

@property(nonatomic, strong)NSIndexPath *selectedIndexPath;

@end

@implementation MemberVipPackageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"套餐选择", 1, 51, 51, 51, 1, 255, 255, 255, 2, 20, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 25, 150, 19)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"支付引导帮助", 3, 153, 153, 153, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 167, 28, 183, 13)];
        
        [self.seeHelpButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeHelp)]];
    }
    return self;
}

-(void)seeHelp{
    
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(110 * (DelouchWidth / 375.0), 144 * (DelouchWidth / 375.0));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15 * (DelouchWidth / 375.0), 62 * (DelouchWidth / 375.0), 360 * (DelouchWidth / 375.0), 144 * (DelouchWidth / 375.0)) collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.alwaysBounceVertical = NO;
        [_collectionView registerClass:[VipPackageCollectionViewCell class] forCellWithReuseIdentifier:@"VipPackageCollectionViewCell"];
        [self.contentView addSubview:self.collectionView];
    }
    return _collectionView;
}

-(void)setVipInfoArray:(NSArray *)vipInfoArray{
    _vipInfoArray = vipInfoArray;
    [self.collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VipPackageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VipPackageCollectionViewCell" forIndexPath:indexPath];
    VipPackageModel *packageModel = [_vipInfoArray objectAtIndex:indexPath.row];
//    switch (indexPath.row % 2) {
//        case 0:
//            cell.selectStateBOOL = NO;
//            break;
//
//        default:
//            cell.selectStateBOOL = YES;
//            break;
//    }
    if (self.selectedIndexPath == nil) {
        if (indexPath.row == 0) {
            cell.selectStateBOOL = YES;
        }else{
            cell.selectStateBOOL = NO;
       }
    }else{
        if ([indexPath compare:self.selectedIndexPath] == NSOrderedSame) {
            cell.selectStateBOOL = YES;
        }else{
            cell.selectStateBOOL = NO;
        }
    }
        
    
    cell.vipTimeString = [NSString stringWithFormat:@"%@个月",packageModel.package_month];
    cell.vipPriceString = [NSString stringWithFormat:@"¥ %@",packageModel.real_price];
    cell.vipOldPriceString = [NSString stringWithFormat:@"¥ %@",packageModel.package_price];
    //cell.discountAmountString = @"30";
    //cell.notiString = @"新用户首月6元";
    cell.notiString = packageModel.package_name;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _vipInfoArray.count;
}

-(UIImageView *)seeHelpButton{
    if (!_seeHelpButton) {
        _seeHelpButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 344, 19, 26, 30)];
        _seeHelpButton.contentMode = UIViewContentModeCenter;
    }
    return _seeHelpButton;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VipPackageModel *packageModel = [_vipInfoArray objectAtIndex:indexPath.row];
    NSString *real_price = packageModel.real_price;
    self.selectedIndexPath = indexPath;
    [collectionView reloadData];
    //UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeVipPackagePrice" object:@{@"real_price":real_price,@"productId":packageModel.productId}];
    
}

//UILabel *label = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"新用户首月6元", 2, 253, 244, 229, 1, 78, 70, 67, 1, 10, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 5, 5, 79, 16)];
//UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:label.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(5,5)];
//CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//maskLayer.frame = label.bounds;
//maskLayer.path = maskPath.CGPath;
//label.layer.mask = maskLayer;

@end
