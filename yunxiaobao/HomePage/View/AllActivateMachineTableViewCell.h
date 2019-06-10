//
//  AllActivateMachineTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllActivateMachineTableViewCell : UITableViewCell

/**
 机器头像
 */
@property(nonatomic, strong)NSString *machineIconString;

/**
 未激活机器SN
 */
@property(nonatomic, strong)NSString *machineActiveNotSNString;

/**
 激活机器SN
 */
@property(nonatomic, strong)NSString *machineActiveSNString;

/**
 机器用户信息
 */
@property(nonatomic, strong)NSString *machineActiveNameString;

/**
 激活类型
 */
@property(nonatomic, strong)NSString *machineActiveTypeString;


@property(nonatomic, strong)AppPosModel *appPosModel;

@end

NS_ASSUME_NONNULL_END
