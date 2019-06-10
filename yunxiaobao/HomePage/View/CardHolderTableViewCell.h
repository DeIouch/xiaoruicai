//
//  CardHolderTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardHolderCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ImportBillBlock) (AppCustomersListModel *appCustomersListModel);

@interface CardHolderTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

/**
 用户名称
 */
@property(nonatomic, strong)UILabel *userNameLabel;

/**
 手机号码
 */
@property(nonatomic, strong)UILabel *userPhoneLabel;

/**
 银行卡数量
 */
@property(nonatomic, strong)UILabel *cardNumberLabel;

/**
 暂无卡片
 */
@property(nonatomic, strong)UILabel *noCardNumberlabel;

/**
 暂无卡片
 */
@property(nonatomic, strong)UIImageView *noCardImageView;

/**
 导出账单
 */
@property(nonatomic, strong)UIButton *exportBillButton;

/**
 用户名称
 */
@property(nonatomic, strong)NSString *userNameString;

/**
 手机号码
 */
@property(nonatomic, strong)NSString *userPhoneString;

/**
 银行卡数量
 */
@property(nonatomic, strong)NSString *cardNumberString;

@property(nonatomic, strong)UIView *bankPictureView;

@property(nonatomic, strong)AppCustomersListModel *appCustomersListModel;

@property(nonatomic, copy)ImportBillBlock importBillBlock;

@end

NS_ASSUME_NONNULL_END
