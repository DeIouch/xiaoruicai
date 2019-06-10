//
//  NotVipView.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/6/1.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NotVipBlock) (void);

@interface NotVipView : UIView

@property(nonatomic, copy)NotVipBlock notVipBlock;

@end

NS_ASSUME_NONNULL_END
