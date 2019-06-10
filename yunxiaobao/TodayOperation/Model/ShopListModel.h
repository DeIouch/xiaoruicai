
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopListModel : NSObject


@property(nonatomic, copy)NSString *isSelected;


@property(nonatomic, copy)NSString *fCity;


@property(nonatomic, copy)NSString *fMccCode;


@property(nonatomic, copy)NSString *fMerchantName;


@property(nonatomic, copy)NSString *fCupsId;


@property(nonatomic, copy)NSString *expiredDate;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END