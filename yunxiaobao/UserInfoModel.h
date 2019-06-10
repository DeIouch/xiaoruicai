
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject

/**
 注册时间戳
 */
@property(nonatomic, copy)NSString *register_time_stamp;

/**
 身份证
 */
@property(nonatomic, copy)NSString *user_idno;

/**
 用户注册来源
 */
@property(nonatomic, copy)NSString *register_source;

/**
 真实姓名
 */
@property(nonatomic, copy)NSString *user_real_name;

/**
 用户级别:0个人版 1中介版 2试用版
 */
@property(nonatomic, copy)NSString *user_level;

/**
 是否享受固定返佣 0否 1是
 */
@property(nonatomic, copy)NSString *is_fixed_back;

/**
 用户token
 */
@property(nonatomic, copy)NSString *user_token;

/**
 账户有效期结束时间
 */
@property(nonatomic, copy)NSString *user_usable_end_time;

/**
 注册时间
 */
@property(nonatomic, copy)NSString *register_time;

/**
 账户有效期开始时间 如果为永久使用或者代理商
 */
@property(nonatomic, copy)NSString *user_usable_begin_time;

/**
 用户id
 */
@property(nonatomic, copy)NSString *user_id;

/**
 注册时间戳
 */
@property(nonatomic, copy)NSString *is_login;

/**
 是否登录
 */
@property(nonatomic, copy)NSString *token;

/**
 账户有效期开始时间戳
 */
@property(nonatomic, copy)NSString *user_usable_begin_time_stamp;

/**
 上级推荐人关联用户id
 */
@property(nonatomic, copy)NSString *parent_user_id;

/**
 密码
 */
@property(nonatomic, copy)NSString *user_pwd;

/**
 账户有效期结束时间戳
 */
@property(nonatomic, copy)NSString *user_usable_end_time_stamp;

/**
 支付宝账号
 */
@property(nonatomic, copy)NSString *alipay_account;

/**
 支付宝姓名
 */
@property(nonatomic, copy)NSString *alipay_name;

/**
 电话号码
 */
@property(nonatomic, copy)NSString *phone;

/**
 账户是否已过期 0否 1是
 */
@property(nonatomic, copy)NSString *is_outer;

/**
 用户分享二维码地址
 */
@property(nonatomic, copy)NSString *user_share_qr_code;

/**
 关联O单项目id
 */
@property(nonatomic, copy)NSString *oem_id;

/**
 用户头像
 */
@property(nonatomic, copy)NSString *user_head_img_path;

/**
 登录用户名
 */
@property(nonatomic, copy)NSString *user_name;

/**
 用户商户号
 */
@property(nonatomic, copy)NSString *customer_no;

-(instancetype)initModelWithDic:(NSDictionary *)dic;

@end 

NS_ASSUME_NONNULL_END
