//
//  HomePageMyProfitTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/10.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HomePageSeeMyBenefitsBlock) (NSString *allProfitMoneyString, NSString *recommendProfitMoneyString, NSString *posProfitString);

typedef void(^HomePageMyMemberBlock) (void);

@interface HomePageMyProfitTableViewCell : UITableViewCell

/**
 总收益
 */
@property(nonatomic, strong)UILabel *allProfitLabel;

/**
 推荐奖
 */
@property(nonatomic, strong)UILabel *recommendProfitLabel;

/**
 pos分润
 */
@property(nonatomic, strong)UILabel *posProfitLabel;

/**
 普通会员
 */
@property(nonatomic, strong)UILabel *normalMemberLabel;

/**
 vip会员
 */
@property(nonatomic, strong)UILabel *vipMenberLabel;

/**
 总收益
 */
@property(nonatomic, strong)NSString *allProfitString;

/**
 推荐奖
 */
@property(nonatomic, strong)NSString *recommendProfitString;

/**
 pos分润
 */
@property(nonatomic, strong)NSString *posProfitString;

/**
 普通会员
 */
@property(nonatomic, strong)NSString *normalMemberString;

/**
 vip会员
 */
@property(nonatomic, strong)NSString *vipMenberString;

/**
 个人收益
 */
@property(nonatomic, strong)UIImageView *mybenefitsImageView;

/**
 查看我的所有收益
 */
@property(nonatomic, strong)UIImageView *seeMyAllBenefitsImageView;

/**
 查看我的所有会员
 */
@property(nonatomic, strong)UIImageView *seeMyAllMemberImageView;

/**
 我的会员
 */
@property(nonatomic, strong)UIImageView *myMemberImageView;

@property(nonatomic, copy)HomePageSeeMyBenefitsBlock homePageSeeMyBenefitsBlock;

@property(nonatomic, copy)HomePageMyMemberBlock homePageMyMemberBlock;

@end

NS_ASSUME_NONNULL_END
