//
//  VipPackageModel.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/30.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "VipPackageModel.h"

@implementation VipPackageModel



-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){
        
        self.package_name = dic[@"package_name"];
        
        self.package_month = dic[@"package_month"];
        
        self.package_price = dic[@"package_price"];
        
        self.real_price = dic[@"real_price"];
        
        self.productId = dic[@"id"];
    }
    return self;
}
@end
