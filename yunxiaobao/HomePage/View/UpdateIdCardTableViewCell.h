//
//  UpdateIdCardTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UpdateIdCardPositiveBlock) (NSString *ossString, NSString *leshuaString);

typedef void(^UpdateIdCardReverseBlock) (NSString *ossString, NSString *leshuaString);

typedef void(^UpdateIdCardPictureBlock) (NSString *ossString, NSString *leshuaString);

@interface UpdateIdCardTableViewCell : UITableViewCell

/**
 身份证正面
 */
@property(nonatomic, strong)NSString *idCardPositiveString;

/**
 身份证反面
 */
@property(nonatomic, strong)NSString *idCardReverseString;

/**
 手持身份证
 */
@property(nonatomic, strong)NSString *idCardPictureString;

/**
 身份证正面
 */
@property(nonatomic, strong)UIImageView *idCardPositiveImageView;

/**
 身份证反面
 */
@property(nonatomic, strong)UIImageView *idCardReverseImageView;

/**
 手持身份证
 */
@property(nonatomic, strong)UIImageView *idCardPictureImageView;

@property(nonatomic, strong)ACMediaPickerManager *Mgr;

@property(nonatomic, copy)UpdateIdCardPositiveBlock updateIdCardPositiveBlock;

@property(nonatomic, copy)UpdateIdCardReverseBlock updateIdCardReverseBlock;

@property(nonatomic, copy)UpdateIdCardPictureBlock updateIdCardPictureBlock;

@end

NS_ASSUME_NONNULL_END
