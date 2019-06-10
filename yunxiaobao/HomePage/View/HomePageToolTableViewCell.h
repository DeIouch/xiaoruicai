//
//  HomePageToolTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/10.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^HomepageToolBlock)(NSInteger tager);

@interface HomePageToolTableViewCell : UITableViewCell

/**
 持卡人
 */
@property(nonatomic, strong)UIButton *cardHolderButton;

/**
 智能规划
 */
@property(nonatomic, strong)UIButton *intelligentPlanButton;

/**
 购买POS
 */
@property(nonatomic, strong)UIButton *applyPosButton;

/**
 激活机器
 */
@property(nonatomic, strong)UIButton *activateMachButton;

@property(nonatomic, copy)HomepageToolBlock homepageToolBlock;

@end

NS_ASSUME_NONNULL_END
