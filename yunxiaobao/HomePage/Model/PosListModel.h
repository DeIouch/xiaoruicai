
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosListModel : NSObject


@property(nonatomic, copy)NSString *pos_is_open;


@property(nonatomic, copy)NSString *pos_method_name;


@property(nonatomic, copy)NSString *pos_name;


@property(nonatomic, copy)NSString *pos_id;


@property(nonatomic, copy)NSString *pos_img;


@property(nonatomic, copy)NSString *pos_tax_fee;


@property(nonatomic, copy)NSString *pos_introduce;


@property(nonatomic, copy)NSString *pos_price;


@property(nonatomic, copy)NSString *pos_is_need_pay;


@property(nonatomic, copy)NSString *pos_number;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
