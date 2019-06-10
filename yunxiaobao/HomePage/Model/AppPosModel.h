
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppPosModel : NSObject


@property(nonatomic, copy)NSString *a_pos_id;


@property(nonatomic, copy)NSString *a_sn;


@property(nonatomic, copy)NSString *a_type;


@property(nonatomic, copy)NSString *a_user_id;


@property(nonatomic, copy)NSString *model_id;


@property(nonatomic, copy)NSString *pos_name;


@property(nonatomic, copy)NSString *user_real_name;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
