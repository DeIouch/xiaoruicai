//
//  HomePageBuyedPosListShopTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageBuyedPosListShopTableViewCell : UITableViewCell

/**
 pos机图片
 */
@property(nonatomic, strong)NSString *posIconString;

/**
 pos机名称
 */
@property(nonatomic, strong)NSString *posNameString;

/**
 pos机价格
 */
@property(nonatomic, strong)NSString *posPriceString;

/**
 pos机数量
 */
@property(nonatomic, strong)NSString *posNumberString;


@end

NS_ASSUME_NONNULL_END
