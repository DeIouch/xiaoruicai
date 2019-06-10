//
//  TodayOperationRecordsListTableViewCell.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/17.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayOperationRecordsListTableViewCell : UITableViewCell

/**
 用户头像
 */
@property(nonatomic, strong)NSString *userIconString;

/**
 用户姓名
 */
@property(nonatomic, strong)NSString *userNameString;

/**
 日期
 */
@property(nonatomic, strong)NSString *dateString;

/**
 金额
 */
@property(nonatomic, strong)NSString *moneyString;

/**
 类型
 */
@property(nonatomic, strong)NSString *typeString;

@end
