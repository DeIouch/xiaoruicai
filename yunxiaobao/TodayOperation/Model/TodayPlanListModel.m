
#import "TodayPlanListModel.h"

@implementation TodayPlanListModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.plan_operate_time_stamp = [dic[@"plan_operate_time_stamp"] stringValue];

        self.card_bank = dic[@"card_bank"];

        self.plan_id = [dic[@"id"] stringValue];

        self.plan_count = [dic[@"plan_count"] stringValue];

        self.plan_kind = [dic[@"plan_kind"] stringValue];

        self.credit_real_name = dic[@"credit_real_name"];

        self.plan_amount = [dic[@"plan_amount"] stringValue];

        self.card_no = dic[@"card_no"];

    }
    return self;
}

@end
