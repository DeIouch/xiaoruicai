#import <UIKit/UIKit.h>
#import <HHRefreshManager.h>
#import <AFNetworking.h>
#import <AVFoundation/AVFoundation.h>
#import "UserInfoModel.h"

//#define DelouchWidth [UIScreen mainScreen].bounds.size.width
//
//#define DelouchHeight [UIScreen mainScreen].bounds.size.height
//
//#define DelouchScreen [UIScreen mainScreen].bounds.size.width/375.0
//
//#define DelouchIphoneX_XS (DelouchWidth == 375.f && DelouchHeight == 812.f ? YES : NO)
//
//#define DelouchIphoneXR_XSMax (DelouchWidth == 414.f && DelouchHeight == 896.f ? YES : NO)
//
//#define DelouchFullScreen (DelouchIphoneX_XS || DelouchIphoneXR_XSMax)
//
//#define DelouchStatusBarHeight (DelouchFullScreen ? 44.f : 20.f)
//
//#define DelouchNavigationBarHeight 44.f
//
//#define DelouchTabbarHeight (DelouchFullScreen ? (49.f+34.f) : 49.f)
//
//#define DelouchTabbarSafeBottomMargin (DelouchFullScreen ? 34.f : 0.f)
//
//#define DelouchStatusBarAndNavigationBarHeight (DelouchFullScreen ? 88.f : 64.f)

//__weak typeof(self) weakSelf = self;


typedef void (^SuccessBlock)(NSDictionary *obj);

typedef void (^DefeatBlock)(NSString *obj);

typedef void (^FaileBlock)(id obj);

typedef enum _Frametype{
    FrameStatusBar = 1,
    FrameHeadView  = 2,
    FrameCellView  = 3,
    FramePopView   = 4,
    FrameFive      = 5,
    FrameNotChange = 6,
} FrameType;

struct DelouchLabelInfo{
    __unsafe_unretained NSString *textString;
    int textAlignType;
    float colorRed;
    float colorGreen;
    float colorBlue;
    CGFloat colorAlpha;
    float backColorRed;
    float backColorGreen;
    float backColorBlue;
    CGFloat backColorAlpha;
    float fontSize;
    BOOL fontChange;
    __unsafe_unretained UIView *backView;
};
typedef struct DelouchLabelInfo DelouchLabelInfo;

/**
 初始化label的属性

 @param textString 文字
 @param textAlignType 文字位置
 @param colorRed 文字颜色red
 @param colorGreen 文字颜色green
 @param colorBlue 文字颜色blue
 @param colorAlpha 文字透明度
 @param backColorRed 背景颜色red
 @param backColorGreen 背景颜色green
 @param backColorBlue 背景颜色blue
 @param backColorAlpha 背景颜色透明度
 @param fontSize 文字大小
 @param fontChange 文字大小是否变化
 @param backView 父视图
 @return label属性结构体
 */
CG_INLINE DelouchLabelInfo
DelouchLabelInfoMake(__unsafe_unretained NSString *textString, int textAlignType, float colorRed, float colorGreen, float colorBlue, CGFloat colorAlpha, float backColorRed, float backColorGreen, float backColorBlue, CGFloat backColorAlpha, float fontSize, BOOL fontChange, __unsafe_unretained UIView *backView)
{
    DelouchLabelInfo info;
    info.textString = textString;
    info.textAlignType = textAlignType;
    info.colorRed = colorRed;
    info.colorGreen = colorGreen;
    info.colorBlue = colorBlue;
    info.colorAlpha = colorAlpha;
    info.backColorRed = backColorRed;
    info.backColorGreen = backColorGreen;
    info.backColorBlue = backColorBlue;
    info.backColorAlpha = backColorAlpha;
    info.fontSize = fontSize;
    info.fontChange = fontChange;
    info.backView = backView;
    return info;
}

struct DelouchViewInfo{
    float backColorRed;
    float backColorGreen;
    float backColorBlue;
    CGFloat backColorAlpha;
    BOOL layerBool;
    float layerSize;
    __unsafe_unretained UIView *backView;
};
typedef struct DelouchViewInfo DelouchViewInfo;

/**
 初始化view的属性

 @param backColorRed 背景颜色red
 @param backColorGreen 背景颜色green
 @param backColorBlue 背景颜色blue
 @param backColorAlpha 背景颜色透明度
 @param layerBool 是否有圆角
 @param layerSize 圆角尺寸
 @param backView 父视图
 @return view属性结构体
 */
CG_INLINE DelouchViewInfo
DelouchViewInfoMake(float backColorRed, float backColorGreen, float backColorBlue, CGFloat backColorAlpha, BOOL layerBool, float layerSize, __unsafe_unretained UIView *backView)
{
    DelouchViewInfo info;
    info.backColorRed = backColorRed;
    info.backColorGreen = backColorGreen;
    info.backColorBlue = backColorBlue;
    info.backColorAlpha = backColorAlpha;
    info.layerBool = layerBool;
    info.layerSize = layerSize;
    info.backView = backView;
    return info;
}

struct DelouchTextFieldInfo{
    __unsafe_unretained NSString *textString;
    __unsafe_unretained NSString *placeholderTextString;
    BOOL isRound;
    BOOL isSecureTextEntry;
    float colorRed;
    float colorGreen;
    float colorBlue;
    CGFloat colorAlpha;
    float borderWidth;
    float fontSize;
    BOOL fontChange;
    __unsafe_unretained UIView *backView;
};
typedef struct DelouchTextFieldInfo DelouchTextFieldInfo;

/**
 初始化textfield的属性

 @param textString 文字
 @param placeholderTextString 占位文字
 @param isRound 是否圆角
 @param isSecureTextEntry 是否是密码输入框
 @param colorRed 字体颜色red
 @param colorGreen 字体颜色green
 @param colorBlue 字体颜色blue
 @param colorAlpha 字体透明度
 @param fontSize 字体大小
 @param fontChange 字体是否变化
 @param backView 父视图
 @return textfield属性结构体
 */
CG_INLINE DelouchTextFieldInfo
DelouchTextFieldInfoMake(__unsafe_unretained NSString *textString, __unsafe_unretained NSString *placeholderTextString, BOOL isRound, BOOL isSecureTextEntry, float colorRed, float colorGreen, float colorBlue, CGFloat colorAlpha, float borderWidth, float fontSize, BOOL fontChange, __unsafe_unretained UIView *backView)
{
    DelouchTextFieldInfo info;
    info.textString = textString;
    info.placeholderTextString = placeholderTextString;
    info.isRound = isRound;
    info.isSecureTextEntry = isSecureTextEntry;
    info.colorRed = colorRed;
    info.colorGreen = colorGreen;
    info.colorBlue = colorBlue;
    info.colorAlpha = colorAlpha;
    info.borderWidth = borderWidth;
    info.fontSize = fontSize;
    info.fontChange = fontChange;
    info.backView = backView;
    return info;
}

struct DelouchImageViewInfo{
    __unsafe_unretained NSString *imageNameString;
    BOOL layerBOOL;
    float layerSize;
    __unsafe_unretained UIView *backView;
};
typedef struct DelouchImageViewInfo DelouchImageViewInfo;

/**
 创建imageview的属性

 @param imageNameString 图片名称
 @param layerBOOL 是否有圆角
 @param layerSize 圆角角度
 @param backView 父视图
 @return imageview属性结构体
 */
CG_INLINE DelouchImageViewInfo
DelouchImageViewInfoMake(__unsafe_unretained NSString *imageNameString,BOOL layerBOOL, float layerSize, __unsafe_unretained UIView *backView)
{
    DelouchImageViewInfo info;
    info.imageNameString = imageNameString;
    info.layerBOOL = layerBOOL;
    info.layerSize = layerSize;
    info.backView = backView;
    return info;
}

struct DelouchTitleButtonInfo{
    __unsafe_unretained NSString *textString;
    int textAlignType;
    float colorRed;
    float colorGreen;
    float colorBlue;
    float colorAlpha;
    float backColorRed;
    float backColorGreen;
    float backColorBlue;
    float backColorAlpha;
    float fontSize;
    BOOL fontChange;
    __unsafe_unretained UIView *backView;
};
typedef struct DelouchTitleButtonInfo DelouchTitleButtonInfo;

/**
 创建文字button的属性

 @param textString 按钮文字
 @param textAlignType 文字位置
 @param colorRed 文字颜色red
 @param colorGreen 文字颜色green
 @param colorBlue 文字颜色blue
 @param colorAlpha 文字颜色透明度
 @param backColorRed 按钮背景颜色red
 @param backColorGreen 按钮背景颜色green
 @param backColorBlue 按钮背景颜色blue
 @param backColorAlpha 按钮背景颜色透明度
 @param fontSize 文字字体
 @param fontChange 文字是否变化
 @param backView 父视图
 @return 文字按钮属性结构体
 */
CG_INLINE DelouchTitleButtonInfo
DelouchTitleButtonInfoMake(__unsafe_unretained NSString *textString, int textAlignType, float colorRed, float colorGreen, float colorBlue, float colorAlpha, float backColorRed, float backColorGreen, float backColorBlue, float backColorAlpha, float fontSize, BOOL fontChange, __unsafe_unretained UIView *backView)
{
    DelouchTitleButtonInfo info;
    info.textString = textString;
    info.textAlignType = textAlignType;
    info.colorRed = colorRed;
    info.colorGreen = colorGreen;
    info.colorBlue = colorBlue;
    info.colorAlpha = colorAlpha;
    info.backColorRed = backColorRed;
    info.backColorGreen = backColorGreen;
    info.backColorBlue = backColorBlue;
    info.backColorAlpha = backColorAlpha;
    info.fontSize = fontSize;
    info.fontChange = fontChange;
    info.backView = backView;
    return info;
}

struct DelouchImageButtonInfo{
    __unsafe_unretained NSString *imageString;
    __unsafe_unretained UIView *backView;
};
typedef struct DelouchImageButtonInfo DelouchImageButtonInfo;

/**
 初始化图片button的属性

 @param imageString 图片名称
 @param backView 父视图
 @return 图片button的结构体
 */
CG_INLINE DelouchImageButtonInfo
DelouchImageButtonInfomake(__unsafe_unretained NSString *imageString, __unsafe_unretained UIView *backView)
{
    DelouchImageButtonInfo info;
    info.imageString = imageString;
    info.backView = backView;
    return info;
}

struct DelouchFrame{
    int frameType;
    float floatX;
    float floatY;
    float floatWidth;
    float floatHeight;
};
typedef struct DelouchFrame DelouchFrame;

/**
 控件的frame
 
 @param frameType frame类型
 @param floatX x轴坐标
 @param floatY y轴坐标
 @param floatWidth 宽
 @param floatHeight 高
 @return frame结构体
 */
CG_INLINE DelouchFrame
DelouchFrameMake(int frameType, float floatX, float floatY, float floatWidth, float floatHeight)
{
    DelouchFrame info;
    info.frameType = frameType;
    info.floatX = floatX;
    info.floatY = floatY;
    info.floatWidth = floatWidth;
    info.floatHeight = floatHeight;
    return info;
}

struct DelouchRightButtonInfo{
    __unsafe_unretained NSString *textString;
    float colorRed;
    float colorGreen;
    float colorBlue;
    float colorAlpha;
    float backColorRed;
    float backColorGreen;
    float backColorBlue;
    float backColorAlpha;
    float fontSize;
};
typedef struct DelouchRightButtonInfo DelouchRightButtonInfo;

/**
 初始化导航栏文字右按钮的属性

 @param textString 按钮文字
 @param colorRed 文字颜色red
 @param colorGreen 文字颜色green
 @param colorBlue 文字颜色blue
 @param colorAlpha 文字颜色透明度
 @param backColorRed 背景颜色red
 @param backColorGreen 背景颜色green
 @param backColorBlue 背景颜色blue
 @param backColorAlpha 背景颜色透明度
 @param fontSize 文字大小
 @return 导航栏文字右按钮属性结构体
 */
CG_INLINE DelouchRightButtonInfo
DelouchRightButtonInfomake(__unsafe_unretained NSString *textString, float colorRed, float colorGreen, float colorBlue, float colorAlpha, float backColorRed, float backColorGreen, float backColorBlue, float backColorAlpha, float fontSize)
{
    DelouchRightButtonInfo info;
    info.textString = textString;
    info.colorRed = colorRed;
    info.colorGreen = colorGreen;
    info.colorBlue = colorBlue;
    info.colorAlpha = colorAlpha;
    info.backColorRed = backColorRed;
    info.backColorGreen = backColorGreen;
    info.backColorBlue = backColorBlue;
    info.backColorAlpha = backColorAlpha;
    info.fontSize = fontSize;
    return info;
}

@class DelouchView;
@class DelouchLabel;
@class DelouchImageView;
@class DelouchTextField;
@class DelouchImageButton;
@class DelouchTitleButton;
@class NaviHeadView;
@class DelouchLibrary;
@class PhoneAndPwModel;
@interface DelouchViewController : UIViewController

@property(nonatomic, strong)UITableView *tableView;

/**
 头视图
 */
@property(nonatomic, strong)NaviHeadView *headview;

/**
 数据源
 */
@property(nonatomic, strong)NSMutableArray *dataArray;

/**
 提示信息
 */
@property(nonatomic, strong)NSString *notiString;

/**
 百分比
 */
@property(nonatomic, assign)float baseicFloat;

/**
 页面标题
 */
@property(nonatomic, strong)NSString *titleString;

/**
 帐号密码
 */
@property(nonatomic, strong)PhoneAndPwModel *phoneAndPwModel;

/**
 用户信息
 */
@property(nonatomic, strong)UserInfoModel *userInfoModel;

@property(nonatomic, strong)HHRefreshManager *refreshManager;

@property(nonatomic, assign)NSInteger refreshIndex;

@property(nonatomic, assign)BOOL freshBOOL;

/**
 保存用户信息
 
 @param userDic 用户信息字典
 */
- (void)preservationUserinfo:(NSDictionary *)userDic;

/**
 转化时间戳

 @param timeString 时间戳
 @return 日期
 */
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

/**
 获取当前月份

 @return 当前月份字符串
 */
-(NSString *)getCalendar;

/**
 右按钮为图片时
 */
@property(nonatomic, strong)NSString *rightImageString;

/**
 暂停1s后返回上一个页面
 */
-(void)popVC;

/**
 刷新tableview
 */
-(void)freshTableView;

/**
 文字右按钮属性结构体
 */
@property(nonatomic, assign)DelouchRightButtonInfo infoDic;

/**
 MD5加密

 @param input 要加密的字符串
 @return 加密后的字符串
 */
- (NSString *)md5:(NSString *)input;

#pragma mark    返回在导航栏下方的tableview的尺寸
/**
 返回在导航栏下方的tableview的尺寸
 
 @return frame
 */
-(CGRect)setTableViewNoBarFrame;

#pragma mark    返回沾满整个屏幕的tableview的尺寸
/**
 返回沾满整个屏幕的tableview的尺寸
 
 @return frame
 */
-(CGRect)setTableViewFullFrame;

#pragma mark    给按钮设置圆角
/**
 给按钮设置圆角

 @param button 按钮
 @param layerFloat 圆角角度
 */
- (void)setbuttonLayer:(UIButton *)button layerMask:(CGFloat)layerFloat;

/**
 时间转时间戳字符串
 
 @param timeInterval 时间
 @return 时间戳字符串
 */
-(NSString *)timeStringToTimeInterval:(NSString *)timeInterval;

#pragma mark    返回没有功能栏的tableview的尺寸
/**
 返回没有功能栏的tableview的尺寸
 
 @return frame
 */
-(CGRect)setTableViewNoTabbarFrame;

#pragma mark    返回没有功能栏和导航栏的tableview的尺寸
/**
 返回没有功能栏和导航栏的tableview的尺寸
 
 @return frame
 */
-(CGRect)setTableViewNoBarTabbarFrame;

/**
 导航栏左按钮点击事件
 */
-(void)leftSelect;

/**
 创建UI
 */
-(void)createUI;

/**
 导航栏右按钮点击事件
 */
-(void)rightSelect;

/**
 保存用户帐号密码

 @param phoneStr 用户的手机号码
 @param pwdStr 用户的密码
 */
-(void)preservationPhone:(NSString *)phoneStr pwd:(NSString *)pwdStr;

/**
 VC点击事件

 @param obj 点击通知
 */
-(void)onClick:(NSNotification *)obj;


- (void)urlHeadStr:(NSString *)headStr urlStr:(NSString *)urlStr parameters:(NSDictionary *__nullable)ParaDic Success:(SuccessBlock)successBlock;

//- (void)getUrlHeadstr:(NSString *)url parameters:(NSDictionary *__nullable)ParaDic refreshManager:(HHRefreshManager *__nullable)refreshManager refreshWithType:(HHRefreshType)type Success:(SuccessBlock)successBlock;


/**
 创建Viewcontrol

 @param VcStr 要创建的VC的类名
 @return vc
 */
-(UIViewController *)createVC:(NSString *)VcStr;

/**
 创建model

 @param dic 要创建model的dic
 @param nameStr model名称
 */
-(void)getModelType:(NSDictionary *)dic className:(NSString *)nameStr;

#pragma mark    页面跳转
/**
 页面跳转

 @param VcStr 要跳转的页面
 @param dic 要传的参数
 */
-(void)pushViewControl:(NSString *)VcStr propertyDic:(NSDictionary *__nullable)dic;

@end

@interface NaviHeadView : UIView

/**
 左按钮
 */
@property(nonatomic, strong, nullable)UIButton *leftButton;

/**
 标题
 */
@property(nonatomic, strong, nullable)UILabel *titleLabel;

/**
 右标题
 */
@property(nonatomic, strong,nullable)UIButton *rightButton;

/**
 下划线
 */
@property(nonatomic, strong, nullable)UIView *lineView;

/**
 分割线
 */
@property(nonatomic, strong, nullable)UIImageView *lineImageView;

@end

#import "DelouchViewController.h"

@interface DelouchLabel : UILabel

@property(nonatomic, assign)DelouchLabelInfo infoDic;

-(UILabel *__nullable)initLabel:(DelouchLabelInfo)infoDic setFrame:(DelouchFrame)delouchFrame;

@end

#import "DelouchViewController.h"

@interface DelouchView : UIView

@property(nonatomic, assign)DelouchViewInfo infoDic;

-(UIView *__nullable)initView:(DelouchViewInfo)infoDic setFrame:(DelouchFrame)delouchFrame;

@end

@interface DelouchTextField : UITextField

@property(nonatomic, assign)DelouchTextFieldInfo infoDic;

-(UITextField *__nullable)initTextField:(DelouchTextFieldInfo)infoDic setFrame:(DelouchFrame)delouchFrame;

@end

#import "DelouchViewController.h"
@interface DelouchTitleButton : UIButton

@property(nonatomic, assign)DelouchTitleButtonInfo infoDic;

-(UIButton *__nullable)initButton:(DelouchTitleButtonInfo)infoDic setFrame:(DelouchFrame)delouchFrame;

@end

@interface DelouchImageButton : UIButton

@property(nonatomic, assign)DelouchImageButtonInfo infoDic;

-(UIButton *__nullable)initButton:(DelouchImageButtonInfo)infoDic setFrame:(DelouchFrame)delouchFrame;

@end

@interface DelouchImageView : UIImageView

@property(nonatomic, assign)DelouchImageViewInfo infoDic;

-(UIImageView *__nullable)initImageView:(DelouchImageViewInfo)infoDic setFrame:(DelouchFrame)delouchFrame;

@end


@interface PhoneAndPwModel : NSObject


@property(nonatomic, copy)NSString *__nullable phoneStr;


@property(nonatomic, copy)NSString *__nullable passwordStr;


-(instancetype __nullable)initWithactivityModelDic:(NSDictionary *__nullable)dic;

@end


#import <Foundation/Foundation.h>
@interface DelouchLibrary : NSObject

/**
 获取单行文字的尺寸

 @param text 文字
 @param fontSize 字体大小
 @return 尺寸
 */
+(CGSize)sizeWithText:(NSString *__nullable)text withFont:(CGFloat)fontSize;

/**
 设置按钮圆角

 @param button 要设置的按钮
 @param layerFloat 圆角角度
 */
+ (void)setbuttonLayer:(UIButton *__nullable)button layerMask:(CGFloat)layerFloat;

#pragma mark    页面跳转
/**
 页面跳转
 
 @param VcStr 要跳转的页面
 @param dic 要传的参数
 */
+(void)pushViewControl:(NSString *__nullable)VcStr propertyDic:(NSDictionary *__nullable)dic;

+(void)setMoneyLabel:(UILabel *__nullable)moneyLabel moneyText:(NSString *__nullable)moneyText bigFont:(CGFloat)bigFont smallFont:(CGFloat)smallFont;

+(void)setDicBoldFont:(UILabel *)label font:(CGFloat)fontSize;

@end

