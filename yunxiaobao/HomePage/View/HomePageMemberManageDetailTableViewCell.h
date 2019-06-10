//
//  HomePageMemberManageDetailTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageMemberManageDetailTableViewCell : UITableViewCell

/**
 会员头像
 */
@property(nonatomic, strong)NSString *memberIconString;

/**
 会员姓名
 */
@property(nonatomic, strong)NSString *membernameString;

/**
 时间
 */
@property(nonatomic, strong)NSString *timeString;

/**
 拨打电话
 */
@property(nonatomic, strong)NSString *phoneString;

/**
 会员类型
 */
@property(nonatomic, strong)NSString *memberTypeString;

@property(nonatomic, strong)UserAmountDetailsListModel *userAmountDetailsListModel;

@end

NS_ASSUME_NONNULL_END
