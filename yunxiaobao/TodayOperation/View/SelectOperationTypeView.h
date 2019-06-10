//
//  SelectOperationTypeView.h
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/21.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectOperationTypeView;

@protocol SelectOperationTypeDelegate <NSObject>

- (void)didSelectTypeAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SelectOperationTypeView : UIView

@property(nonatomic, strong)NSMutableArray *typeArray;

@property(nonatomic, weak)id<SelectOperationTypeDelegate>delegate;

@property(nonatomic, strong)NSString *titleString;

@end
