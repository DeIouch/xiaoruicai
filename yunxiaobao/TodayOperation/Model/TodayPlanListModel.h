
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodayPlanListModel : NSObject


@property(nonatomic, copy)NSString *plan_operate_time_stamp;


@property(nonatomic, copy)NSString *card_bank;


@property(nonatomic, copy)NSString *plan_id;


@property(nonatomic, copy)NSString *plan_count;


@property(nonatomic, copy)NSString *plan_kind;


@property(nonatomic, copy)NSString *credit_real_name;


@property(nonatomic, copy)NSString *plan_amount;


@property(nonatomic, copy)NSString *card_no;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
