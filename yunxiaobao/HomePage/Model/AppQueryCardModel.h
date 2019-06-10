
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppQueryCardModel : NSObject

/**
 是否有U盾 1是 2否'
 */
@property(nonatomic, copy)NSString *card_is_u;

/**
 银行卡预留手机号'
 */
@property(nonatomic, copy)NSString *card_phone;

/**
 银行卡保留金额
 */
@property(nonatomic, copy)NSString *card_keeping_amount;

/**
 剩余未还
 */
@property(nonatomic, copy)NSString *card_current_bill_left_return_amount;

/**
 卡片是否已删除:0否 1是'
 */
@property(nonatomic, copy)NSString *card_is_delete;

/**
 所在卡册卡位
 */
@property(nonatomic, copy)NSString *card_position;

/**
 银行卡可用金额
 */
@property(nonatomic, copy)NSString *card_usable_amount;

/**
 交易密码
 */
@property(nonatomic, copy)NSString *card_deal_pwd;

/**
 卡片是否已结算:0 否 1是
 */
@property(nonatomic, copy)NSString *card_is_deal;

/**
 关联用户id
 */
@property(nonatomic, copy)NSString *user_id;

/**
 银行卡临时额度
 */
@property(nonatomic, copy)NSString *card_recent_amount;

/**
 关联客户id
 */
@property(nonatomic, copy)NSString *customer_id;

/**
 卡片是否规划
 */
@property(nonatomic, copy)NSString *card_is_plan;

/**
 卡id
 */
@property(nonatomic, copy)NSString *card_id;

/**
 银行卡初始金额
 */
@property(nonatomic, copy)NSString *card_original_amount;

/**
 收卡日期
 */
@property(nonatomic, copy)NSString *card_add_time;

/**
 银行卡固定额度
 */
@property(nonatomic, copy)NSString *card_fixed_amount;

/**
 信用卡持卡人姓名
 */
@property(nonatomic, copy)NSString *credit_real_name;

/**
 银行卡号
 */
@property(nonatomic, copy)NSString *card_no;

/**
 还款日
 */
@property(nonatomic, copy)NSString *card_bill_return_day;

/**
 收费方式:1 保留金扣取 2 转入
 */
@property(nonatomic, copy)NSString *card_pay_type;

/**
 发卡行
 */
@property(nonatomic, copy)NSString *card_bank;

/**
 账单日，固定每月多少号
 */
@property(nonatomic, copy)NSString *card_bill_day;

/**
 自定义收费金额基数
 */
@property(nonatomic, copy)NSString *card_pay_base_amount;

/**
 收费基数:1总信用额度 2总应还款金额 3自定义金额
 */
@property(nonatomic, copy)NSString *card_pay_base_amount_type;

/**
 本期应还款
 */
@property(nonatomic, copy)NSString *card_current_bill_return_amount;

/**
 临时额度有效期
 */
@property(nonatomic, copy)NSString *card_recent_amount_end_time;

/**
 网银用户名
 */
@property(nonatomic, copy)NSString *card_web_user_name;

/**
 查询密码
 */
@property(nonatomic, copy)NSString *card_query_pwd;

/**
 用户网银密码
 */
@property(nonatomic, copy)NSString *card_web_user_pwd;

-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
