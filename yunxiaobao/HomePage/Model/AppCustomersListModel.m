
#import "AppCustomersListModel.h"

@implementation AppCustomersListModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.card_id = [dic[@"id"] stringValue];

        self.cards_num = [dic[@"cards_num"] stringValue];

        self.credit_real_name = dic[@"credit_real_name"];

        self.id_no = dic[@"id_no"];

        self.contact_phone = dic[@"contact_phone"];

        self.user_id = [dic[@"user_id"] stringValue];

        self.sex = [dic[@"sex"] stringValue];

    }
    return self;
}

@end
