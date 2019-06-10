
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QueryCardsShoppingSheetModel : NSObject


@property(nonatomic, copy)NSString *money;


@property(nonatomic, copy)NSString *M;


@property(nonatomic, strong)NSArray *list;


@property(nonatomic, copy)NSString *time;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END