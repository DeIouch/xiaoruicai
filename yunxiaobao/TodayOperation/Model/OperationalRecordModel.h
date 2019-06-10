
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OperationalRecordModel : NSObject


@property(nonatomic, copy)NSString *card_no;


@property(nonatomic, copy)NSString *deal_type;


@property(nonatomic, copy)NSString *card_bank;


@property(nonatomic, copy)NSString *deal_amount;


@property(nonatomic, copy)NSString *deal_time;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END