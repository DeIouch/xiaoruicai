//
//  VipOverdueView.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/6/2.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^VipOverdueBlock) (void);

@interface VipOverdueView : UIView

@property(nonatomic, copy)VipOverdueBlock vipOverdueBlock;

@end

NS_ASSUME_NONNULL_END
