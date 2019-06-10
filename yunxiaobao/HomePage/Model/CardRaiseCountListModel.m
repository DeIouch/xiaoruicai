
#import "CardRaiseCountListModel.h"

@implementation CardRaiseCountListModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.fixDownAmount = dic[@"fixDownAmount"];

        self.card_bank = dic[@"card_bank"];

        self.fixUpAmount = dic[@"fixUpAmount"];

        self.card_position = dic[@"card_position"];

        self.card_id = [dic[@"card_id"] stringValue];

        self.credit_real_name = dic[@"credit_real_name"];

        self.user_id = [dic[@"user_id"] stringValue];

        self.card_no = dic[@"card_no"];

        self.tempUpAmount = dic[@"tempUpAmount"];

    }
    return self;
}

@end