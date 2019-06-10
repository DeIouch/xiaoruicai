//
//  AddNewAddressTableViewCell.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNewAddressBlock) (void);

@interface AddNewAddressTableViewCell : UITableViewCell

@property(nonatomic, copy)AddNewAddressBlock addNewAddressBlock;

@end

NS_ASSUME_NONNULL_END
