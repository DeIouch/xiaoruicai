
#import "AppQueryMealSettingsListModel.h"

@implementation AppQueryMealSettingsListModel

-(instancetype)initModelWithDic:(NSDictionary *)dic{
    if ([super init]){

        self.meal_loan_percent = [dic[@"meal_loan_percent"] stringValue];

        self.update_time = [dic[@"update_time"] stringValue];

        self.package_id = [dic[@"id"] stringValue];

        self.meal_charge_percent = [dic[@"meal_charge_percent"] stringValue];

        self.meal_name = dic[@"meal_name"];

        self.meal_is_control_debt = [dic[@"meal_is_control_debt"] stringValue];

        self.meal_control_debt_percent = [dic[@"meal_control_debt_percent"] stringValue];

        self.user_id = [dic[@"user_id"] stringValue];

        self.meal_plan_type = [dic[@"meal_plan_type"] stringValue];

        self.meal_lift_percent = [dic[@"meal_lift_percent"] stringValue];

    }
    return self;
}

@end
