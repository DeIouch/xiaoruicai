
#import "QueryCardsShoppingSheetListModel.h"

@implementation QueryCardsShoppingSheetListModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.list_id = [dic[@"id"] stringValue];

        self.deal_type = [dic[@"deal_type"] stringValue];

        self.deal_desc = dic[@"deal_desc"];

        self.card_usable_amount = [dic[@"card_usable_amount"] stringValue];

        self.card_id = [dic[@"card_id"] stringValue];

        self.card_no = dic[@"card_no"];

        self.deal_merchant_name = dic[@"deal_merchant_name"];

        self.deal_time_stamp = [dic[@"deal_time_stamp"] stringValue];

        self.deal_amount = [dic[@"deal_amount"] stringValue];

        self.user_id = [dic[@"user_id"] stringValue];

        self.card_bank = dic[@"card_bank"];

        self.deal_time = dic[@"deal_time"];

        self.deal_pos_name = dic[@"deal_pos_name"];

        self.card_position = [dic[@"card_position"] stringValue];

        self.deal_type_name = dic[@"deal_type_name"];

    }
    return self;
}

@end
