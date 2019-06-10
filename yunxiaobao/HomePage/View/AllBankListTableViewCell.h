//
//  AllBankListTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllBankListTableViewCell : UITableViewCell

/**
 银行icon
 */
@property(nonatomic, strong)NSString *bankIconString;

/**
 银行名称
 */
@property(nonatomic, strong)NSString *bankNameString;

@end

NS_ASSUME_NONNULL_END
