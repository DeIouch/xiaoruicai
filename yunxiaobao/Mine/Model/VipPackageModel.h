//
//  VipPackageModel.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/30.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipPackageModel : NSObject

@property(nonatomic, copy) NSString * package_month;
@property(nonatomic, copy) NSString * package_price;
@property(nonatomic, copy) NSString * real_price;
@property(nonatomic, copy) NSString * package_name;
@property(nonatomic, copy) NSString * productId;

-(instancetype)initModelWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
