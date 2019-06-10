
#import "UserMemberModel.h"

@implementation UserMemberModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.vipMember = [dic[@"vip"] stringValue];

        self.normalMember = [dic[@"putong"] stringValue];

    }
    return self;
}

@end
