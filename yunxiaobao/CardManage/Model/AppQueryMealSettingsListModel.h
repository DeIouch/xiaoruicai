
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppQueryMealSettingsListModel : NSObject


@property(nonatomic, copy)NSString *meal_loan_percent;


@property(nonatomic, copy)NSString *update_time;


@property(nonatomic, copy)NSString *package_id;


@property(nonatomic, copy)NSString *meal_charge_percent;


@property(nonatomic, copy)NSString *meal_name;


@property(nonatomic, copy)NSString *meal_is_control_debt;


@property(nonatomic, copy)NSString *meal_control_debt_percent;


@property(nonatomic, copy)NSString *user_id;


@property(nonatomic, copy)NSString *meal_plan_type;


@property(nonatomic, copy)NSString *meal_lift_percent;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
