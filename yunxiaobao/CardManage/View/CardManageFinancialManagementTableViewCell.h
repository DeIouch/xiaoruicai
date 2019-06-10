//
//  CardManageFinancialManagementTableViewCell.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SeeFinanciaBlock) (FinancesListModel *financesModel);

typedef void(^GoCollectionBlock) (FinancesListModel *financesModel);

@interface CardManageFinancialManagementTableViewCell : UITableViewCell

/**
 账单日期
 */
@property(nonatomic, strong)NSString *financiaDateString;

/**
 账单类型
 */
@property(nonatomic, strong)NSString *financiaTypeString;

@property(nonatomic, strong)FinancesListModel *financesListModel;

@property(nonatomic, copy)SeeFinanciaBlock seeFinanciaBlock;

@property(nonatomic, copy)GoCollectionBlock goCollectionBlock;

@end
