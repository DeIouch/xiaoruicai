
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetOperatingAmountModel : NSObject


@property(nonatomic, copy)NSString *amount;


@property(nonatomic, copy)NSString *fee;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END