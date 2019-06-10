
#import "UserAmountDetailsListModel.h"

@implementation UserAmountDetailsListModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.phone = dic[@"phone"];

        self.register_time = dic[@"register_time"];

        self.oem_id = [dic[@"oem_id"] stringValue];

        self.member_id = [dic[@"id"] stringValue];

        self.parent_user_id = [dic[@"parent_user_id"] stringValue];

        self.user_id = [dic[@"user_id"] stringValue];

        self.user_name = dic[@"user_name"];

        self.user_idno = dic[@"user_idno"];

        self.user_real_name = dic[@"user_real_name"];

        self.recommand_level = [dic[@"recommand_level"] stringValue];
        
        self.user_head_img_path = dic[@"user_head_img_path"];
        
        self.package_id = [dic[@"package_id"] stringValue];

    }
    return self;
}

@end
