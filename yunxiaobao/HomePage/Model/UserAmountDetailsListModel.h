
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserAmountDetailsListModel : NSObject


@property(nonatomic, copy)NSString *phone;


@property(nonatomic, copy)NSString *register_time;


@property(nonatomic, copy)NSString *oem_id;


@property(nonatomic, copy)NSString *member_id;


@property(nonatomic, copy)NSString *parent_user_id;


@property(nonatomic, copy)NSString *user_id;


@property(nonatomic, copy)NSString *user_name;


@property(nonatomic, copy)NSString *user_idno;


@property(nonatomic, copy)NSString *user_real_name;


@property(nonatomic, copy)NSString *recommand_level;


@property(nonatomic, copy)NSString *user_head_img_path;


@property(nonatomic, copy)NSString *package_id;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
