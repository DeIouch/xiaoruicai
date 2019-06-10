
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OperatingListModel : NSObject

/**
 规划商户名称
 */
@property(nonatomic, copy)NSString *plan_merchant_name;

/**
 关联卡片id
 */
@property(nonatomic, copy)NSString *card_id;

/**
 pos机名称
 */
@property(nonatomic, copy)NSString *pos_name;

/**
 数据是否有效:0已过期 1有效 ',
 */
@property(nonatomic, copy)NSString *status;

/**
 计划起效时间戳
 */
@property(nonatomic, copy)NSString *plan_operate_time_stamp;

/**
 规划商户类别
 */
@property(nonatomic, copy)NSString *plan_type_name;

/**
 pos机ID
 */
@property(nonatomic, copy)NSString *plan_pos_id;

/**
 卡片位置
 */
@property(nonatomic, copy)NSString *card_position;

/**
 用户ID
 */
@property(nonatomic, copy)NSString *user_id;

/**
 卡片是否已删除
 */
@property(nonatomic, copy)NSString *card_is_delete;

/**
 规划类型:1还款 2消费 3手动还款 4手动消费
 */
@property(nonatomic, copy)NSString *plan_kind;

/**
 规划状态:0 未操作 1已操作',
 */
@property(nonatomic, copy)NSString *plan_status;

/**
 成本
 */
@property(nonatomic, copy)NSString *plan_fee;

/**
 规划时间戳
 */
@property(nonatomic, copy)NSString *plan_time_stamp;

/**
 id
 */
@property(nonatomic, copy)NSString *plan_id;

/**
 系统规划的金额
 */
@property(nonatomic, copy)NSString *plan_amount;

/**
 卡号
 */
@property(nonatomic, copy)NSString *card_no;

/**
 通道对应代码方法名称
 */
@property(nonatomic, copy)NSString *pos_method_name;

/**
 规划时间
 */
@property(nonatomic, copy)NSString *plan_time;

/**
 银行名称
 */
@property(nonatomic, copy)NSString *card_bank;

/**
 计划起效时间
 */
@property(nonatomic, copy)NSString *plan_operate_time;

/**
 备注说明
 */
@property(nonatomic, copy)NSString *plan_desc;


-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
