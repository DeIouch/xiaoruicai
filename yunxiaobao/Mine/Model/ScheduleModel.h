
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleModel : NSObject


@property(nonatomic, copy)NSString *amount;


@property(nonatomic, copy)NSString *usable_amount;


@property(nonatomic, copy)NSString *time;


@property(nonatomic, copy)NSString *time_stamp;


@property(nonatomic, copy)NSString *user_id;


@property(nonatomic, copy)NSString *kind;


@property(nonatomic, copy)NSString *descriptionStr;


@property(nonatomic, copy)NSString *type;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
