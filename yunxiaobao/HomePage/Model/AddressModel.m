
#import "AddressModel.h"

@implementation AddressModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.street = dic[@"street"];

        self.city = [dic[@"city"] stringValue];

        self.detail_address = dic[@"detail_address"];

        self.consignee = dic[@"consignee"];

        self.district = [dic[@"district"] stringValue];

        self.address_id = [dic[@"id"] stringValue];

        self.user_id = [dic[@"user_id"] stringValue];

        self.default_address = [dic[@"default_address"] stringValue];

        self.telephone = dic[@"telephone"];

        self.province = [dic[@"province"] stringValue];

    }
    return self;
}

@end
