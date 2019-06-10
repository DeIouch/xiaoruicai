//
//  ActivitePosInfoTableViewCell.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/31.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivitePosInfoTableViewCell : UITableViewCell

/**
 信息标题
 */
@property(nonatomic, strong)NSString *titleString;

/**
 标题
 */
@property(nonatomic, strong)UILabel *infoTitleLabel;

/**
 输入框
 */
@property(nonatomic, strong)UITextField *infoTextField;

/**
 信息文本框
 */
@property(nonatomic, strong)UILabel *infoLabel;

/**
 选择按钮
 */
@property(nonatomic, strong)UIImageView *chooseButton;

/**
 地址输入框
 */
@property(nonatomic, strong)UITextField *addressTextField;

/**
 下一步
 */
@property(nonatomic, strong)UIButton *nextButton;

@end
