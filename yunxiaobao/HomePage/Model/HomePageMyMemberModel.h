
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageMyMemberModel : NSObject


@property(nonatomic, copy)NSString *lastday;


@property(nonatomic, copy)NSString *zong;


@property(nonatomic, copy)NSString *today;


@property(nonatomic, copy)NSString *regular;


@property(nonatomic, copy)NSString *zongvip;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
