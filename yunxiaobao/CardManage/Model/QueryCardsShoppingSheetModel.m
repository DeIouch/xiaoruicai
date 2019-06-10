
#import "QueryCardsShoppingSheetModel.h"

@implementation QueryCardsShoppingSheetModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.money = [dic[@"money"] stringValue];

        self.M = dic[@"M"];

        self.list = dic[@"list"];

        self.time = dic[@"time"];

    }
    return self;
}

@end