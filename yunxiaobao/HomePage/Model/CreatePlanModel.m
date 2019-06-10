
#import "CreatePlanModel.h"

@implementation CreatePlanModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.plan_kind = [dic[@"plan_kind"] stringValue];

        self.credit_real_name = dic[@"credit_real_name"];

        self.card_no = dic[@"card_no"];

        self.plan_amount = [dic[@"plan_amount"] stringValue];

        self.card_id = dic[@"card_id"];

        self.type_name = dic[@"type_name"];

        self.plan_time = dic[@"plan_time"];

        self.pos_method_name = dic[@"pos_method_name"];

        self.card_bank = dic[@"card_bank"];

        self.plan_fee = [dic[@"plan_fee"] stringValue];

        self.card_position = dic[@"card_position"];

        self.plan_time_stamp = [dic[@"plan_time_stamp"] stringValue];

        self.plan_pos_id = dic[@"plan_pos_id"];

    }
    return self;
}

@end