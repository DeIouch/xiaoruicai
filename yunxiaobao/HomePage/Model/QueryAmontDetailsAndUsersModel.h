
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QueryAmontDetailsAndUsersModel : NSObject


@property(nonatomic, copy)NSString *amount;


@property(nonatomic, copy)NSString *usable_amount;


@property(nonatomic, copy)NSString *time;


@property(nonatomic, copy)NSString *time_stamp;


@property(nonatomic, copy)NSString *user_id;


@property(nonatomic, copy)NSString *kind;


@property(nonatomic, copy)NSString *descriptionString;


@property(nonatomic, copy)NSString *user_real_name;


@property(nonatomic, copy)NSString *type;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
