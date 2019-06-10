
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressModel : NSObject

/**
 街道地址
 */
@property(nonatomic, copy)NSString *street;

/**
 市
 */
@property(nonatomic, copy)NSString *city;

/**
 详细地址全称
 */
@property(nonatomic, copy)NSString *detail_address;

/**
 收货人姓名
 */
@property(nonatomic, copy)NSString *consignee;

/**
 区
 */
@property(nonatomic, copy)NSString *district;

/**
 地址主键
 */
@property(nonatomic, copy)NSString *address_id;

/**
 用户ID
 */
@property(nonatomic, copy)NSString *user_id;

/**
 0为默认的,1不是
 */
@property(nonatomic, copy)NSString *default_address;

/**
 联系电话
 */
@property(nonatomic, copy)NSString *telephone;

/**
 省份，保存是ID
 */
@property(nonatomic, copy)NSString *province;

-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
