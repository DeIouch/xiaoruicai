//
//  ShareView.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/6/1.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ShareWxFriendBlock) (void);

typedef void(^ShareWxCircleBlock) (void);

@interface ShareView : UIView

@property(nonatomic, copy)ShareWxFriendBlock shareWxFriendBlock;

@property(nonatomic, copy)ShareWxCircleBlock shareWxCircleBlock;

@end

NS_ASSUME_NONNULL_END
