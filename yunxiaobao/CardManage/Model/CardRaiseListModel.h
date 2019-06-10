
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardRaiseListModel : NSObject


@property(nonatomic, copy)NSString *descriptionStr;


@property(nonatomic, copy)NSString *model_id;


@property(nonatomic, copy)NSString *credit_real_name;


@property(nonatomic, copy)NSString *amount;


@property(nonatomic, copy)NSString *card_no;


@property(nonatomic, copy)NSString *current_end_time_stamp;


@property(nonatomic, copy)NSString *card_id;


@property(nonatomic, copy)NSString *user_id;


@property(nonatomic, copy)NSString *type;


@property(nonatomic, copy)NSString *time;


@property(nonatomic, copy)NSString *card_bank;


@property(nonatomic, copy)NSString *time_stamp;


@property(nonatomic, copy)NSString *card_position;


@property(nonatomic, copy)NSString *current_end_time;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
