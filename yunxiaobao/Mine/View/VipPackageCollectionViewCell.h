//
//  VipPackageCollectionViewCell.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/21.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VipPackageCollectionViewCell : UICollectionViewCell

/**
 提示框
 */
@property(nonatomic, strong)NSString *notiString;

/**
 vip日期
 */
@property(nonatomic, strong)NSString *vipTimeString;

/**
 vip价格
 */
@property(nonatomic, strong)NSString *vipPriceString;

/**
 vip旧价格
 */
@property(nonatomic, strong)NSString *vipOldPriceString;

/**
 优惠金额
 */
@property(nonatomic, strong)NSString *discountAmountString;

/**
 选中状态
 */
@property(nonatomic, assign)BOOL selectStateBOOL;

@end
