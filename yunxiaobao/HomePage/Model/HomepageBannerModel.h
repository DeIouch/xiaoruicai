
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomepageBannerModel : NSObject


@property(nonatomic, copy)NSString *id;


@property(nonatomic, copy)NSString *banner_link_src;


@property(nonatomic, copy)NSString *banner_type;


@property(nonatomic, copy)NSString *banner_img_src;


@property(nonatomic, copy)NSString *banner_is_link;


@property(nonatomic, copy)NSString *oem_id;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END