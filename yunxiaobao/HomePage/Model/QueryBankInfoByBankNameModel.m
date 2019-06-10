
#import "QueryBankInfoByBankNameModel.h"

@implementation QueryBankInfoByBankNameModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.code = dic[@"code"];

        self.full_name = dic[@"full_name"];

        self.short_name = dic[@"short_name"];

        self.bank_id = [dic[@"id"] stringValue];

        self.text = dic[@"text"];

    }
    return self;
}

@end
