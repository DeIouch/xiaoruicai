
#import "AppQueryCardModel.h"

@implementation AppQueryCardModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.card_is_u = [dic[@"card_is_u"] stringValue];

        self.card_phone = dic[@"card_phone"];

        self.card_keeping_amount = [dic[@"card_keeping_amount"] stringValue];

        self.card_current_bill_left_return_amount = [dic[@"card_current_bill_left_return_amount"] stringValue];

        self.card_is_delete = [dic[@"card_is_delete"] stringValue];

        self.card_position = [dic[@"card_position"] stringValue];

        self.card_usable_amount = [dic[@"card_usable_amount"] stringValue];

        self.card_deal_pwd = dic[@"card_deal_pwd"];

        self.card_is_deal = [dic[@"card_is_deal"] stringValue];

        self.user_id = [dic[@"user_id"] stringValue];

        self.card_recent_amount = [dic[@"card_recent_amount"] stringValue];

        self.customer_id = [dic[@"customer_id"] stringValue];

        self.card_is_plan = [dic[@"card_is_plan"] stringValue];

        self.card_id = [dic[@"id"] stringValue];

        self.card_original_amount = [dic[@"card_original_amount"] stringValue];

        self.card_add_time = dic[@"card_add_time"];

        self.card_fixed_amount = [dic[@"card_fixed_amount"] stringValue];

        self.credit_real_name = dic[@"credit_real_name"];

        self.card_no = dic[@"card_no"];

        self.card_bill_return_day = [dic[@"card_bill_return_day"] stringValue];

        self.card_pay_type = [dic[@"card_pay_type"] stringValue];

        self.card_bank = dic[@"card_bank"];

        self.card_bill_day = [dic[@"card_bill_day"] stringValue];

        self.card_pay_base_amount = [dic[@"card_pay_base_amount"] stringValue];

        self.card_pay_base_amount_type = [dic[@"card_pay_base_amount_type"] stringValue];

        self.card_current_bill_return_amount = [dic[@"card_current_bill_return_amount"] stringValue];

        self.card_recent_amount_end_time = dic[@"card_recent_amount_end_time"];

        self.card_web_user_name = dic[@"card_web_user_name"];

        self.card_query_pwd = dic[@"card_query_pwd"];

        self.card_web_user_pwd = dic[@"card_web_user_pwd"];

    }
    return self;
}

@end
