//
//  HomePagePersonalBenefitsDetailTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePagePersonalBenefitsDetailTableViewCell : UITableViewCell

/**
 收益类型
 */
@property(nonatomic, strong)NSString *benefitsTypeString;

/**
 收益时间
 */
@property(nonatomic, strong)NSString *benefitsTimeString;

/**
 收益金额
 */
@property(nonatomic, strong)NSString *benefitsNumberString;

@end

NS_ASSUME_NONNULL_END
