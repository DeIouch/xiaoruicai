//
//  HomePagePersonalBenefitsTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePagePersonalBenefitsTableViewCell : UITableViewCell

/**
 收益总额
 */
@property(nonatomic, strong)NSString *totalBenefitsString;

/**
 收益月份
 */
@property(nonatomic, strong)NSString *benefitsMouthString;

/**
 本月POS分润额
 */
@property(nonatomic, strong)NSString *posBenefitsString;

/**
 本月推荐额
 */
@property(nonatomic, strong)NSString *recommendString;

@end

NS_ASSUME_NONNULL_END
