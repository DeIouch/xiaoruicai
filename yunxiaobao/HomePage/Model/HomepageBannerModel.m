
#import "HomepageBannerModel.h"

@implementation HomepageBannerModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.id = [dic[@"id"] stringValue];

        self.banner_link_src = dic[@"banner_link_src"];

        self.banner_type = [dic[@"banner_type"] stringValue];

        self.banner_img_src = dic[@"banner_img_src"];

        self.banner_is_link = [dic[@"banner_is_link"] stringValue];

        self.oem_id = [dic[@"oem_id"] stringValue];

    }
    return self;
}

@end