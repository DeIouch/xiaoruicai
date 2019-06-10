
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QueryPackageByOrderModel : NSObject


@property(nonatomic, copy)NSString *pos_name;


@property(nonatomic, copy)NSString *order_num;


@property(nonatomic, copy)NSString *pay_time;


@property(nonatomic, copy)NSString *order_type;


@property(nonatomic, copy)NSString *user_id;


@property(nonatomic, copy)NSString *order_status;


@property(nonatomic, copy)NSString *fixed_amount;


@property(nonatomic, copy)NSString *back_amount;


@property(nonatomic, copy)NSString *package_name;


@property(nonatomic, copy)NSString *direct_amount;


@property(nonatomic, copy)NSString *order_detail;


@property(nonatomic, copy)NSString *id;


@property(nonatomic, copy)NSString *phone;


@property(nonatomic, copy)NSString *real_price;


@property(nonatomic, copy)NSString *create_time_stamp;


@property(nonatomic, copy)NSString *pos_id;


@property(nonatomic, copy)NSString *creat_time;


@property(nonatomic, copy)NSString *express_no;


@property(nonatomic, copy)NSString *sn_no;


@property(nonatomic, copy)NSString *oem_id;


@property(nonatomic, copy)NSString *merchant_bill;


@property(nonatomic, copy)NSString *user_name;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END