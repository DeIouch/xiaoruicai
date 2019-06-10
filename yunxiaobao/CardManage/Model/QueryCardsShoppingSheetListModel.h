
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QueryCardsShoppingSheetListModel : NSObject


@property(nonatomic, copy)NSString *card_id;


@property(nonatomic, copy)NSString *deal_type;


@property(nonatomic, copy)NSString *deal_desc;


@property(nonatomic, copy)NSString *card_usable_amount;


@property(nonatomic, copy)NSString *list_id;


@property(nonatomic, copy)NSString *card_no;


@property(nonatomic, copy)NSString *deal_merchant_name;


@property(nonatomic, copy)NSString *deal_time_stamp;


@property(nonatomic, copy)NSString *deal_amount;


@property(nonatomic, copy)NSString *user_id;


@property(nonatomic, copy)NSString *card_bank;


@property(nonatomic, copy)NSString *deal_time;


@property(nonatomic, copy)NSString *deal_pos_name;


@property(nonatomic, copy)NSString *card_position;


@property(nonatomic, copy)NSString *deal_type_name;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
