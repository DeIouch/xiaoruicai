
#import "AppPosModel.h"

@implementation AppPosModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.a_pos_id = [dic[@"a_pos_id"] stringValue];

        self.a_sn = dic[@"a_sn"];

        self.a_type = [dic[@"a_type"] stringValue];

        self.a_user_id = [dic[@"a_user_id"] stringValue];

        self.model_id = [dic[@"id"] stringValue];

        self.pos_name = dic[@"pos_name"];

        self.user_real_name = dic[@"user_real_name"];

    }
    return self;
}

@end
