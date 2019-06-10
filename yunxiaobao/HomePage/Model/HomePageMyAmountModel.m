
#import "HomePageMyAmountModel.h"

@implementation HomePageMyAmountModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.sum_amount1 = [NSString stringWithFormat:@"%0.2f", [[dic[@"sum_amount2"] stringValue] floatValue]];

        self.sum_usable_amount = [NSString stringWithFormat:@"%0.2f", [[dic[@"sum_usable_amount"] stringValue] floatValue]];

        self.sum_amount2 = [NSString stringWithFormat:@"%0.2f", [[dic[@"sum_amount1"] stringValue] floatValue]];

    }
    return self;
}

@end
