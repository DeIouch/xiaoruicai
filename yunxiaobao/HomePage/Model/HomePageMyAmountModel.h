
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageMyAmountModel : NSObject


@property(nonatomic, copy)NSString *sum_amount1;


@property(nonatomic, copy)NSString *sum_usable_amount;


@property(nonatomic, copy)NSString *sum_amount2;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END