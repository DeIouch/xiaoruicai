
#import "GetOperatingTitleModel.h"

@implementation GetOperatingTitleModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.date = dic[@"date"];

        self.amount = [dic[@"amount"] stringValue];

        self.operatingList = dic[@"operatingList"];

    }
    return self;
}

@end