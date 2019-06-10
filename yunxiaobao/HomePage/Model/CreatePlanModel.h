
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreatePlanModel : NSObject


@property(nonatomic, copy)NSString *plan_kind;


@property(nonatomic, copy)NSString *credit_real_name;


@property(nonatomic, copy)NSString *card_no;


@property(nonatomic, copy)NSString *plan_amount;


@property(nonatomic, copy)NSString *card_id;


@property(nonatomic, copy)NSString *type_name;


@property(nonatomic, copy)NSString *plan_time;


@property(nonatomic, copy)NSString *pos_method_name;


@property(nonatomic, copy)NSString *card_bank;


@property(nonatomic, copy)NSString *plan_fee;


@property(nonatomic, copy)NSString *card_position;


@property(nonatomic, copy)NSString *plan_time_stamp;


@property(nonatomic, copy)NSString *plan_pos_id;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END