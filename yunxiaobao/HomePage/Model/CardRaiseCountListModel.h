
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardRaiseCountListModel : NSObject


@property(nonatomic, copy)NSString *fixDownAmount;


@property(nonatomic, copy)NSString *card_bank;


@property(nonatomic, copy)NSString *fixUpAmount;


@property(nonatomic, copy)NSString *card_position;


@property(nonatomic, copy)NSString *card_id;


@property(nonatomic, copy)NSString *credit_real_name;


@property(nonatomic, copy)NSString *user_id;


@property(nonatomic, copy)NSString *card_no;


@property(nonatomic, copy)NSString *tempUpAmount;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END