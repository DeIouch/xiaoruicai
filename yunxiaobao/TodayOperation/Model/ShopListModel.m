
#import "ShopListModel.h"

@implementation ShopListModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.isSelected = [dic[@"isSelected"] stringValue];

        self.fCity = dic[@"fCity"];

        self.fMccCode = dic[@"fMccCode"];

        self.fMerchantName = dic[@"fMerchantName"];

        self.fCupsId = dic[@"fCupsId"];

        self.expiredDate = dic[@"expiredDate"];

    }
    return self;
}

@end