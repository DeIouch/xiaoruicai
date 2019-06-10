
#import "FinancesListModel.h"

@implementation FinancesListModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.meal_name = dic[@"meal_name"];

        self.card_id = [dic[@"card_id"] stringValue];

        self.card_keeping_amount = [dic[@"card_keeping_amount"] stringValue];

        self.amount = [dic[@"amount"] stringValue];

        self.create_time = dic[@"create_time"];

        self.card_position = [dic[@"card_position"] stringValue];

        self.card_usable_amount = [dic[@"card_usable_amount"] stringValue];

        self.user_id = [dic[@"user_id"] stringValue];

        self.type = [dic[@"type"] stringValue];

        self.model_id = [dic[@"id"] stringValue];

        self.is_payed = [dic[@"is_payed"] stringValue];

        self.card_no = dic[@"card_no"];

        self.card_bank = dic[@"card_bank"];

        self.card_pay_base_amount_type = [dic[@"card_pay_base_amount_type"] stringValue];

        self.lifting_amount = [dic[@"lifting_amount"] stringValue];

        self.fee = [dic[@"fee"] stringValue];

        self.gain = [dic[@"gain"] stringValue];

        self.card_pay_type = [dic[@"card_pay_type"] stringValue];

        self.end_time = dic[@"end_time"];

        self.card_pay_base_amount = [dic[@"card_pay_base_amount"] stringValue];

        self.create_time_stamp = [dic[@"create_time_stamp"] stringValue];

        self.begin_time = dic[@"begin_time"];

        self.descriptionStr = dic[@"description"];

    }
    return self;
}

@end
