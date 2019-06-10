
#import "CountTypeMoneyModel.h"

@implementation CountTypeMoneyModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.zhichu = [dic[@"zhichu"] stringValue];

        self.shouru = [dic[@"shouru"] stringValue];

    }
    return self;
}

@end