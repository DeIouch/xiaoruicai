
#import "MywithdrawsModel.h"

@implementation MywithdrawsModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.keyong = [dic[@"keyong"] stringValue];

        self.withdrawalAmount = [dic[@"withdrawalAmount"] stringValue];

        self.zongshouyi = [dic[@"zongshouyi"] stringValue];

        self.balance = [dic[@"balance"] stringValue];

    }
    return self;
}

@end
