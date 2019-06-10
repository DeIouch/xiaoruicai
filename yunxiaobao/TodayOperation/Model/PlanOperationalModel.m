
#import "PlanOperationalModel.h"

@implementation PlanOperationalModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.plan_merchant_name = dic[@"plan_merchant_name"];

        self.card_id = [dic[@"card_id"] stringValue];

        self.status = [dic[@"status"] stringValue];

        self.plan_operate_time_stamp = [dic[@"plan_operate_time_stamp"] stringValue];

        self.plan_type_name = dic[@"plan_type_name"];

        self.plan_pos_id = dic[@"plan_pos_id"];

        self.card_position = [dic[@"card_position"] stringValue];

        self.user_id = [dic[@"user_id"] stringValue];

        self.card_is_delete = [dic[@"card_is_delete"] stringValue];

        self.plan_kind = [dic[@"plan_kind"] stringValue];

        self.plan_status = [dic[@"plan_status"] stringValue];

        self.plan_fee = [dic[@"plan_fee"] stringValue];

        self.plan_time_stamp = [dic[@"plan_time_stamp"] stringValue];

        self.plan_id = [dic[@"id"] stringValue];

        self.plan_amount = [dic[@"plan_amount"] stringValue];

        self.card_no = dic[@"card_no"];

        self.credit_real_name = dic[@"credit_real_name"];

        self.plan_time = dic[@"plan_time"];

        self.card_bank = dic[@"card_bank"];

        self.plan_operate_time = dic[@"plan_operate_time"];

        self.plan_desc = dic[@"plan_desc"];

    }
    return self;
}

@end
