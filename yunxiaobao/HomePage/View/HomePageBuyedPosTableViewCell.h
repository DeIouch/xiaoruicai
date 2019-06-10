//
//  HomePageBuyedPosTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageBuyedPosTableViewCell : UITableViewCell

/**
 数据源
 */
@property(nonatomic, strong)NSMutableArray *dataArray;

/**
 购买时间
 */
@property(nonatomic, strong)NSString *buyTimeString;

/**
 购买状态
 */
@property(nonatomic, strong)NSString *buyStateString;

/**
 用户名称
 */
@property(nonatomic, strong)NSString *nameString;

/**
 手机号码
 */
@property(nonatomic, strong)NSString *phoneString;

/**
 收货地址
 */
@property(nonatomic, strong)NSString *addressString;

/**
 物流编号
 */
@property(nonatomic, strong)NSString *logisticsNumberString;

@end

NS_ASSUME_NONNULL_END
