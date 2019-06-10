//
//  HomePagePersonalBenefitsViewController.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomePagePersonalBenefitsViewController : DelouchViewController

/**
 收益总额
 */
@property(nonatomic, strong)NSString *totalBenefitsNumberString;

/**
 POS分润总额  1
 */
@property(nonatomic, strong)NSString *posTotalbenefitsNumberString;

/**
 推荐总额   2
 */
@property(nonatomic, strong)NSString *totalRecommendNumberString;

@end

NS_ASSUME_NONNULL_END
