
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FinancesListModel : NSObject


@property(nonatomic, copy)NSString *meal_name;


@property(nonatomic, copy)NSString *card_id;


@property(nonatomic, copy)NSString *card_keeping_amount;


@property(nonatomic, copy)NSString *amount;


@property(nonatomic, copy)NSString *create_time;


@property(nonatomic, copy)NSString *card_position;


@property(nonatomic, copy)NSString *card_usable_amount;


@property(nonatomic, copy)NSString *user_id;


@property(nonatomic, copy)NSString *type;


@property(nonatomic, copy)NSString *model_id;


@property(nonatomic, copy)NSString *is_payed;


@property(nonatomic, copy)NSString *card_no;


@property(nonatomic, copy)NSString *card_bank;


@property(nonatomic, copy)NSString *card_pay_base_amount_type;


@property(nonatomic, copy)NSString *lifting_amount;


@property(nonatomic, copy)NSString *fee;


@property(nonatomic, copy)NSString *gain;


@property(nonatomic, copy)NSString *card_pay_type;


@property(nonatomic, copy)NSString *end_time;


@property(nonatomic, copy)NSString *card_pay_base_amount;


@property(nonatomic, copy)NSString *create_time_stamp;


@property(nonatomic, copy)NSString *begin_time;


@property(nonatomic, copy)NSString *descriptionStr;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
