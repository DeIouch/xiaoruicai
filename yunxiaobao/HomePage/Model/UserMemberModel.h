
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserMemberModel : NSObject


@property(nonatomic, copy)NSString *vipMember;


@property(nonatomic, copy)NSString *normalMember;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END