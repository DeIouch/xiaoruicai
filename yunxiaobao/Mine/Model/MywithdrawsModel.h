
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MywithdrawsModel : NSObject


@property(nonatomic, copy)NSString *keyong;


@property(nonatomic, copy)NSString *withdrawalAmount;


@property(nonatomic, copy)NSString *zongshouyi;


@property(nonatomic, copy)NSString *balance;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
