//
//  MemberVipInfoTableViewCell.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/18.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberVipInfoTableViewCell : UITableViewCell

/**
 用户头像
 */
@property(nonatomic, strong)NSString *userIconString;

/**
 用户昵称
 */
@property(nonatomic, strong)NSString *nickNameString;

/**
 到期时间
 */
@property(nonatomic, strong)NSString *endDateString;

/**
 用户ID
 */
@property(nonatomic, strong)NSString *userNoString;

@end
