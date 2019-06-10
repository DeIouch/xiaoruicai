//
//  TodayOperationChooseShopTableViewCell.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TodayOperationChooseShopBlock) (NSInteger index);

@interface TodayOperationChooseShopTableViewCell : UITableViewCell

/**
 商户名称
 */
@property(nonatomic, strong)NSString *shopNameString;

/**
 选择商户
 */
@property(nonatomic, assign)BOOL chooseBOOL;

@property(nonatomic, assign)NSInteger cellIndex;

@property(nonatomic, copy)TodayOperationChooseShopBlock todayOperationChooseShopBlock;

@end
