
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QueryBankInfoByBankNameModel : NSObject


@property(nonatomic, copy)NSString *code;


@property(nonatomic, copy)NSString *full_name;


@property(nonatomic, copy)NSString *short_name;


@property(nonatomic, copy)NSString *bank_id;


@property(nonatomic, copy)NSString *text;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
