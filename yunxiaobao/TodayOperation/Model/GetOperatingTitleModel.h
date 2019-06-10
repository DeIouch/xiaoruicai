
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetOperatingTitleModel : NSObject


@property(nonatomic, copy)NSString *date;


@property(nonatomic, copy)NSString *amount;


@property(nonatomic, strong)NSArray *operatingList;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END