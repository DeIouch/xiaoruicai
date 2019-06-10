//
//  HomePageMemberManageTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageMemberManageTableViewCell : UITableViewCell

/**
 普通会员
 */
@property(nonatomic, strong)NSString *normalMemberString;

/**
 VIP会员
 */
@property(nonatomic, strong)NSString *vipMemberString;

/**
 收益月份
 */
@property(nonatomic, strong)NSString *memberMouthString;

@end

NS_ASSUME_NONNULL_END
