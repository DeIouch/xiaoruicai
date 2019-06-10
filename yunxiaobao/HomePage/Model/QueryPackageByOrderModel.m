
#import "QueryPackageByOrderModel.h"

@implementation QueryPackageByOrderModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.pos_name = dic[@"pos_name"];

        self.order_num = [dic[@"order_num"] stringValue];

        self.pay_time = dic[@"pay_time"];

        self.order_type = [dic[@"order_type"] stringValue];

        self.user_id = [dic[@"user_id"] stringValue];

        self.order_status = dic[@"order_status"];

        self.fixed_amount = [dic[@"fixed_amount"] stringValue];

        self.back_amount = [dic[@"back_amount"] stringValue];

        self.package_name = dic[@"package_name"];

        self.direct_amount = [dic[@"direct_amount"] stringValue];

        self.order_detail = dic[@"order_detail"];

        self.id = [dic[@"id"] stringValue];

        self.phone = dic[@"phone"];

        self.real_price = [dic[@"real_price"] stringValue];

        self.create_time_stamp = [dic[@"create_time_stamp"] stringValue];

        self.pos_id = [dic[@"pos_id"] stringValue];

        self.creat_time = dic[@"creat_time"];

        self.express_no = dic[@"express_no"];

        self.sn_no = dic[@"sn_no"];

        self.oem_id = [dic[@"oem_id"] stringValue];

        self.merchant_bill = dic[@"merchant_bill"];

        self.user_name = dic[@"user_name"];

    }
    return self;
}

@end