
#import "GetOperatingAmountModel.h"

@implementation GetOperatingAmountModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.amount = [dic[@"plan_amount"] stringValue];

        self.fee = [dic[@"plan_fee"] stringValue];

    }
    return self;
}

@end
