
#import "OperationalRecordModel.h"

@implementation OperationalRecordModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.card_no = dic[@"card_no"];

        self.deal_type = [dic[@"deal_type"] stringValue];

        self.card_bank = dic[@"card_bank"];

        self.deal_amount = [dic[@"deal_amount"] stringValue];

        self.deal_time = dic[@"deal_time"];

    }
    return self;
}

@end