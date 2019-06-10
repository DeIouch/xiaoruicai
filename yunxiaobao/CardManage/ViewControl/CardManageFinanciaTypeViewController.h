//
//  CardManageFinanciaTypeViewController.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

@interface CardManageFinanciaTypeViewController : DelouchViewController

/**
 账单类型   1、卡付款   2、查看账单
 */
@property(nonatomic, strong)NSString *financiaTypeString;

@property(nonatomic, strong)FinancesListModel *financesListModel;

@end
