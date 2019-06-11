//
//  CardManageInfoViewController.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardManageInfoViewController : DelouchViewController

/**
 银行名称
 */
@property(nonatomic, strong)NSString *bankNameString;

/**
 卡片信息model
 */
@property(nonatomic, strong)NeedToPlanModel *cardListModel;

@end

NS_ASSUME_NONNULL_END
