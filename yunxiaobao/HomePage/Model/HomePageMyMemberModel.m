
#import "HomePageMyMemberModel.h"

@implementation HomePageMyMemberModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.lastday = [dic[@"lastday"] stringValue];

        self.zong = [dic[@"zong"] stringValue];
        
        self.today = [dic[@"today"] stringValue];
        
        self.regular = [dic[@"zongpu"] stringValue];
        
        self.zongvip = [dic[@"zongvip"] stringValue];

    }
    return self;
}

@end
