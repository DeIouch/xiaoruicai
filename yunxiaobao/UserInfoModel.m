
#import "UserInfoModel.h"

@implementation UserInfoModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.register_time_stamp = [dic[@"register_time_stamp"] stringValue];

        self.user_idno = dic[@"user_idno"];

        self.register_source = [dic[@"register_source"] stringValue];

        self.user_real_name = dic[@"user_real_name"];

        self.user_level = [dic[@"user_level"] stringValue];

        self.is_fixed_back = [dic[@"is_fixed_back"] stringValue];

        self.user_token = dic[@"user_token"];

        self.user_usable_end_time = dic[@"user_usable_end_time"];

        self.register_time = dic[@"register_time"];

        self.user_usable_begin_time = dic[@"user_usable_begin_time"];

        self.user_id = [dic[@"id"] stringValue];

        self.is_login = [dic[@"is_login"] stringValue];

        self.token = dic[@"token"];

        self.user_usable_begin_time_stamp = [dic[@"user_usable_begin_time_stamp"] stringValue];

        self.parent_user_id = [dic[@"parent_user_id"] stringValue];

        self.user_pwd = dic[@"user_pwd"];

        self.user_usable_end_time_stamp = [dic[@"user_usable_end_time_stamp"] stringValue];

        self.phone = dic[@"phone"];

        self.is_outer = [dic[@"is_outer"] stringValue];

        self.user_share_qr_code = dic[@"user_share_qr_code"];

        self.oem_id = [dic[@"oem_id"] stringValue];

        self.user_head_img_path = dic[@"user_head_img_path"];

        self.user_name = dic[@"user_name"];
        
        self.alipay_account = dic[@"alipay_account"];
        
        self.alipay_name = dic[@"alipay_name"];
        
        self.customer_no = dic[@"customer_no"];

    }
    return self;
}

@end
