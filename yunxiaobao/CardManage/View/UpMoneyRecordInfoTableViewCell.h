//
//  UpMoneyRecordInfoTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/6/3.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpMoneyRecordInfoTableViewCell : UITableViewCell

/**
 提额类型
 */
@property(nonatomic, strong)NSString *upTypeString;

/**
 提额金额
 */
@property(nonatomic, strong)NSString *upMoneyString;

/**
 时间
 */
@property(nonatomic, strong)NSString *upTimeString;

@end

NS_ASSUME_NONNULL_END
