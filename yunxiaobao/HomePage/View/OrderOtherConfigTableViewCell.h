//
//  OrderOtherConfigTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderOtherConfigTableViewCell : UITableViewCell<UITextFieldDelegate>

/**
 字体数目
 */
@property(nonatomic, strong)UILabel *numberLabel;

/**
 备注
 */
@property(nonatomic, strong)LongContentTextView *textField;

@end

NS_ASSUME_NONNULL_END
