//
//  UpdateBankCardTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BankCardPositiveBlock) (NSString *ossBankCardPositiveString, NSString *leshuaBankCardPositiveString);

@interface UpdateBankCardTableViewCell : UITableViewCell

///**
// 银行卡正面
// */
//@property(nonatomic, strong)NSString *bankCardPositiveString;

///**
// 银行卡反面
// */
//@property(nonatomic, strong)NSString *bankCardReverseString;
//
///**
// 手持银行卡
// */
//@property(nonatomic, strong)NSString *bankCardPictureString;

/**
 银行卡正面
 */
@property(nonatomic, strong)UIImageView *bankCardPositiveImageView;

///**
// 银行卡反面
// */
//@property(nonatomic, strong)UIImageView *bankCardReverseImageView;
//
///**
// 手持信用卡
// */
//@property(nonatomic, strong)UIImageView *bankCardPictureImageView;

/**
 提交
 */
@property(nonatomic, strong)UIButton *updateCertificateButton;

@property(nonatomic, strong)ACMediaPickerManager *Mgr;

@property(nonatomic, copy)BankCardPositiveBlock bankCardPositiveBlock;

@end

NS_ASSUME_NONNULL_END
