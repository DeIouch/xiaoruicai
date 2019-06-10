//
//  ApplyPosTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ApplyPosAddBlock) (PosListModel *model,NSInteger cellIndex, float price, NSString *posNumber);

typedef void(^ApplyPosReductionBlock) (PosListModel *model,NSInteger cellIndex, float price, NSString *posNumber);

@interface ApplyPosTableViewCell : UITableViewCell

/**
 pos机图片
 */
@property(nonatomic, strong)NSString *posIconString;

/**
 pos机名称
 */
@property(nonatomic, strong)NSString *posNameString;

/**
 pos机介绍
 */
@property(nonatomic, strong)NSString *posInstructionsString;

/**
 pos机价格
 */
@property(nonatomic, strong)NSString *posPriceString;

/**
 pos机数量
 */
@property(nonatomic, strong)NSString *posNumberString;

@property(nonatomic, assign)NSInteger cellIndex;

@property(nonatomic, strong)PosListModel *posListModel;

@property(nonatomic, strong)ApplyPosAddBlock applyPosAddBlock;

@property(nonatomic, strong)ApplyPosReductionBlock applyPosReductionBlock;

@end

NS_ASSUME_NONNULL_END
