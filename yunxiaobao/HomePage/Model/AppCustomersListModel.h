
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppCustomersListModel : NSObject


@property(nonatomic, copy)NSString *card_id;


@property(nonatomic, copy)NSString *cards_num;


@property(nonatomic, copy)NSString *credit_real_name;


@property(nonatomic, copy)NSString *id_no;


@property(nonatomic, copy)NSString *contact_phone;


@property(nonatomic, copy)NSString *user_id;


@property(nonatomic, copy)NSString *sex;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
