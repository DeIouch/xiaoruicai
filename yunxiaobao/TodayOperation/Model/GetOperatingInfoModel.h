
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetOperatingInfoModel : NSObject


@property(nonatomic, copy)NSString *plan_merchant_name;


@property(nonatomic, copy)NSString *card_id;


@property(nonatomic, copy)NSString *status;


@property(nonatomic, copy)NSString *plan_operate_time_stamp;


@property(nonatomic, copy)NSString *plan_type_name;


@property(nonatomic, copy)NSString *plan_pos_id;


@property(nonatomic, copy)NSString *card_position;


@property(nonatomic, copy)NSString *user_id;


@property(nonatomic, copy)NSString *card_is_delete;


@property(nonatomic, copy)NSString *plan_kind;


@property(nonatomic, copy)NSString *plan_status;


@property(nonatomic, copy)NSString *plan_fee;


@property(nonatomic, copy)NSString *plan_time_stamp;


@property(nonatomic, copy)NSString *plan_id;


@property(nonatomic, copy)NSString *plan_amount;


@property(nonatomic, copy)NSString *card_no;


@property(nonatomic, copy)NSString *credit_real_name;


@property(nonatomic, copy)NSString *plan_time;


@property(nonatomic, copy)NSString *card_bank;


@property(nonatomic, copy)NSString *plan_operate_time;


@property(nonatomic, copy)NSString *plan_desc;


@property(nonatomic, copy)NSString *pos_name;


@property(nonatomic, copy)NSString *pos_method_name;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
