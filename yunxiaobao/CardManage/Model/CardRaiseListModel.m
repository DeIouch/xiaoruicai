
#import "CardRaiseListModel.h"

@implementation CardRaiseListModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.descriptionStr = dic[@"description"];

        self.model_id = [dic[@"id"] stringValue];

        self.credit_real_name = dic[@"credit_real_name"];

        self.amount = [dic[@"amount"] stringValue];

        self.card_no = dic[@"card_no"];

        self.current_end_time_stamp = [dic[@"current_end_time_stamp"] stringValue];

        self.card_id = [dic[@"card_id"] stringValue];

        self.user_id = [dic[@"user_id"] stringValue];

        self.type = [dic[@"type"] stringValue];

        self.time = dic[@"time"];

        self.card_bank = dic[@"card_bank"];

        self.time_stamp = [dic[@"time_stamp"] stringValue];

        self.card_position = [dic[@"card_position"] stringValue];

        self.current_end_time = dic[@"current_end_time"];

    }
    return self;
}

@end
