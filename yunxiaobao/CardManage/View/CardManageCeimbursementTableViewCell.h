//
//  CardManageCeimbursementTableViewCell.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CardManageCeimbursementBlock) (GetOperatingInfoModel *operatingListModel);

@interface CardManageCeimbursementTableViewCell : UITableViewCell

/**
 还款金额
 */
@property(nonatomic, strong)NSString *ceimbursementMoneyString;

/**
 还款类型
 */
@property(nonatomic, strong)NSString *ceimbursementTypeString;

@property(nonatomic, strong)GetOperatingInfoModel *getOperatingInfoModel;

@property(nonatomic, copy)CardManageCeimbursementBlock cardManageCeimbursementBlock;

@end
