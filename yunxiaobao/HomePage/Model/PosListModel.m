
#import "PosListModel.h"

@implementation PosListModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.pos_is_open = [dic[@"pos_is_open"] stringValue];

        self.pos_method_name = dic[@"pos_method_name"];

        self.pos_name = dic[@"pos_name"];

        self.pos_id = [dic[@"id"] stringValue];

        self.pos_img = dic[@"pos_img"];

        self.pos_tax_fee = [dic[@"pos_tax_fee"] stringValue];

        self.pos_introduce = dic[@"pos_introduce"];

        self.pos_price = [dic[@"pos_price"] stringValue];

        self.pos_is_need_pay = [dic[@"pos_is_need_pay"] stringValue];

    }
    return self;
}

-(void)setPos_number:(NSString *)pos_number{
    _pos_number = pos_number;
}

@end
