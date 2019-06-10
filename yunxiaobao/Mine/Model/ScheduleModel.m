
#import "ScheduleModel.h"

@implementation ScheduleModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.amount = [dic[@"amount"] stringValue];

        self.usable_amount = [dic[@"usable_amount"] stringValue];

        self.time = dic[@"time"];

        self.time_stamp = [dic[@"time_stamp"] stringValue];

        self.user_id = [dic[@"user_id"] stringValue];

        self.kind = [dic[@"kind"] stringValue];

        self.descriptionStr = dic[@"description"];

        self.type = [dic[@"type"] stringValue];

    }
    return self;
}

@end
