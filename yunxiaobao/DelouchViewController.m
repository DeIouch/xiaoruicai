#import "DelouchViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>
#import <CommonCrypto/CommonDigest.h>

#define FileUrl @"/Users/rzjf/Desktop/Model"

@interface DelouchViewController ()<HHRefreshManagerDelegate>

@end

@implementation DelouchViewController

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:YES];
}

-(void)setFreshBOOL:(BOOL)freshBOOL{
    if (freshBOOL) {
        self.refreshManager = [HHRefreshManager refreshWithDelegate:self scrollView:self.tableView type:AnimationTypeNormal];
        self.refreshIndex = 1;
        //  自动刷新，类似于新闻类第一次进入APP
        [self.refreshManager automaticHeaderRefresh];
    }
}

- (void)beginRefreshWithType:(HHRefreshType)type
{
    if (type == HHRefreshTypeHeader) {
        self.refreshIndex = 1;
        [self freshTableView];
    }else{
        self.refreshIndex ++;
        [self freshTableView];
    }
}

-(void)freshTableView{
//    [self urlHeadStr:AppCustomersURL urlStr:UrlAppCustomersList parameters:[NSDictionary dictionaryWithObjectsAndKeys:@"13", @"user_id", [NSString stringWithFormat:@"%ld", self.refreshIndex], @"page", nil] Success:^(NSDictionary *obj) {
//        if (self.refreshIndex == 1) {
//            [self.dataArray removeAllObjects];
//        }
//        for (NSDictionary *dic in obj[@"result"][@"data"][@"page"]) {
//            [self.dataArray addObject:[[AppCustomersListModel alloc]initModelWithDic:dic]];
//        }
//        self.refreshIndex ++;
//        [self.tableView reloadData];
//    }];
}

-(float)baseicFloat{
    if (!_baseicFloat) {
        _baseicFloat = [UIScreen mainScreen].bounds.size.width/375.0;
    }
    return _baseicFloat;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [self.view addSubview:_tableView];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark    返回在导航栏下方的tableview的尺寸
/**
 返回在导航栏下方的tableview的尺寸

 @return frame
 */
-(CGRect)setTableViewNoBarFrame{
    return CGRectMake(0, DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight);
}

#pragma mark    返回沾满整个屏幕的tableview的尺寸
/**
 返回沾满整个屏幕的tableview的尺寸

 @return frame
 */
-(CGRect)setTableViewFullFrame{
    return CGRectMake(0, 0, DelouchWidth, DelouchHeight);
}

#pragma mark    返回没有功能栏的tableview的尺寸
/**
 返回没有功能栏的tableview的尺寸
 
 @return frame
 */
-(CGRect)setTableViewNoTabbarFrame{
    return CGRectMake(0, 0, DelouchWidth, DelouchHeight - DelouchTabbarHeight);
}

#pragma mark    返回没有功能栏和导航栏的tableview的尺寸
/**
 返回没有功能栏和导航栏的tableview的尺寸
 
 @return frame
 */
-(CGRect)setTableViewNoBarTabbarFrame{
    return CGRectMake(0, DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - DelouchTabbarHeight - DelouchStatusBarAndNavigationBarHeight);
}

#pragma mark    跳转页面
/**
 跳转页面

 @param VcStr 要跳转的页面的值
 @param dic 传值的参数
 */
-(void)pushViewControl:(NSString *)VcStr propertyDic:(NSDictionary *__nullable)dic{
    id toCon = [[NSClassFromString(VcStr) alloc]init];
    NSArray *keyArr = [dic allKeys];
    for (int i = 0; i < keyArr.count; i++) {
        NSString *key = [keyArr objectAtIndex:i];
        id value = [dic valueForKey:key];
        //把key的首字母大写
        NSString *firstStr = [key substringWithRange:NSMakeRange(0, 1)].uppercaseString;
        NSString *restStr = [key substringFromIndex:1];
        //生成对应属性的set方法
        NSString *selName = [NSString stringWithFormat:@"set%@%@:", firstStr, restStr];
        SEL method = NSSelectorFromString(selName);
        if ([toCon respondsToSelector:method]) {
            //等价于controller.shuxing = value;
            //如果是数字则在字典中是NSNumber类型,需要把NSNumber类型转为NSInteger或者CGFloat
            if ([value isKindOfClass:[NSNumber class]]) {
                NSString *vale = [(NSNumber *) value stringValue];
                if ([vale containsString:@"."]) {
                    CGFloat val = [vale doubleValue];
                    void (*action)(id, SEL, CGFloat) = (void (*)(id, SEL, CGFloat)) objc_msgSend;
                    action(toCon, method, val);
                }else{
                    NSInteger val = [(NSNumber *) value integerValue];
                    void (*action)(id, SEL, NSInteger) = (void (*)(id, SEL, NSInteger)) objc_msgSend;
                    action(toCon, method, val);
                }
            } else {
                void (*action)(id, SEL, id) = (void (*)(id, SEL, id)) objc_msgSend;
                action(toCon, method, value);
            }
        }
    }
    [self.navigationController pushViewController:(UIViewController *)toCon animated:YES];
}

- (void)setbuttonLayer:(UIButton *)button layerMask:(CGFloat)layerFloat{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(layerFloat * self.baseicFloat, layerFloat * self.baseicFloat)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = button.bounds;
    maskLayer.path = maskPath.CGPath;
    button.layer.mask = maskLayer;
}

-(void)setNotiString:(NSString *)notiString{
    [WKProgressHUD popMessage:notiString inView:self.view duration:1.0 animated:YES];
}

-(UserInfoModel *)userInfoModel{
    if (!_userInfoModel) {
        NSUserDefaults *userInfoDefault = [NSUserDefaults standardUserDefaults];
        _userInfoModel = [[UserInfoModel alloc]initModelWithDic:[userInfoDefault objectForKey:@"userInfo"]];
    }
    return _userInfoModel;
}

/**
 保存用户信息

 @param userDic 用户信息字典
 */
- (void)preservationUserinfo:(NSDictionary *)userDic{
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSUserDefaults *userInfoDefault = [NSUserDefaults standardUserDefaults];
        [userInfoDefault setObject:userDic forKey:@"userInfo"];
        [userInfoDefault synchronize];
//    }];
}

#pragma mark    创建Viewcontrol
/**
 创建Viewcontrol

 @param VcStr 要创建的Vc的类名
 @return vc
 */
-(UIViewController *)createVC:(NSString *)VcStr;{
    return (UIViewController *)[[NSClassFromString(VcStr) alloc]init];
}

-(PhoneAndPwModel *)phoneAndPwModel{
    if (!_phoneAndPwModel) {
        NSUserDefaults *userInfoDefault = [NSUserDefaults standardUserDefaults];
        _phoneAndPwModel = [[PhoneAndPwModel alloc]initWithactivityModelDic:[userInfoDefault objectForKey:@"phoneAndPassWord"]];
    }
    return _phoneAndPwModel;
}

#pragma mark    创建model
/**
 创建model
 
 @param dic 要创建model的dic
 @param nameStr model名称
 */
-(void)getModelType:(NSDictionary *)dic className:(NSString *)nameStr{
    NSArray *array = [dic allKeys];
//    NSString *hFinalPath = [NSString stringWithFormat:@"%@/%@Model.h", FileUrl, nameStr];
    
    NSString *hFinalPath = [NSString stringWithFormat:@"%@/%@Model.h",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],nameStr];
    
//    NSString *mFinalPath = [NSString stringWithFormat:@"%@/%@Model.m", FileUrl, nameStr];
    
    NSString *mFinalPath = [NSString stringWithFormat:@"%@/%@Model.m",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],nameStr];
    
    NSString *hStr = [NSString stringWithFormat:@"\n#import <Foundation/Foundation.h>\n\nNS_ASSUME_NONNULL_BEGIN\n\n@interface %@Model : NSObject\n\n\n",nameStr];
    NSString *mStr = [NSString stringWithFormat:@"\n#import \"%@Model.h\"\n\n@implementation %@Model\n\n-(instancetype)initModelWithDic:(NSDictionary *)dic{\n    if ([super init]){\n\n",nameStr, nameStr];
    for (NSString *str in array) {
        id dicObject = [dic objectForKey:str];
        if ([dicObject isKindOfClass:[NSString class]]) {
            hStr = [hStr stringByAppendingString:[NSString stringWithFormat:@"@property(nonatomic, copy)NSString *%@;\n\n\n",str]];
            mStr = [mStr stringByAppendingString:[NSString stringWithFormat:@"        self.%@ = dic[@\"%@\"];\n\nif (self.%@.length == 0) {\nself.%@ = @"";\n}", str, str, str, str]];
        }else if ([dicObject isKindOfClass:[NSNumber class]]) {
            hStr = [hStr stringByAppendingString:[NSString stringWithFormat:@"@property(nonatomic, copy)NSString *%@;\n\n\n",str]];
            mStr = [mStr stringByAppendingString:[NSString stringWithFormat:@"        self.%@ = [dic[@\"%@\"] stringValue];\n\nif (self.%@.length == 0) {\nself.%@ = @"";\n} ", str, str, str, str]];
        }else if ([dicObject isKindOfClass:[NSDictionary class]]) {
            hStr = [hStr stringByAppendingString:[NSString stringWithFormat:@"@property(nonatomic, strong)NSDictionary *%@;\n\n\n",str]];
            mStr = [mStr stringByAppendingString:[NSString stringWithFormat:@"        self.%@ = dic[@\"%@\"];\n\n", str, str]];
        }else if ([dicObject isKindOfClass:[NSArray class]]) {
            hStr = [hStr stringByAppendingString:[NSString stringWithFormat:@"@property(nonatomic, strong)NSArray *%@;\n\n\n",str]];
            mStr = [mStr stringByAppendingString:[NSString stringWithFormat:@"        self.%@ = dic[@\"%@\"];\n\n", str, str]];
        }else{
            hStr = [hStr stringByAppendingString:[NSString stringWithFormat:@"//%@不知道什么类型\n\n\n", str]];
        }
    }
    hStr = [hStr stringByAppendingString:@"-(instancetype)initModelWithDic:(NSDictionary *)dic;\n\n@end \n\nNS_ASSUME_NONNULL_END"];
    mStr = [mStr stringByAppendingString:@"    }\n    return self;\n}\n\n@end"];
    [hStr writeToFile:hFinalPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [mStr writeToFile:mFinalPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"hFinalPath  ==  %@", hFinalPath);
}

- (NSString *)md5:(NSString *)input{
//    //传入参数,转化成char
//    const char * str = [input UTF8String];
//    //开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
//    unsigned char md[CC_MD5_DIGEST_LENGTH];
//    /*
//     extern unsigned char * CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
//     把str字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了md这个空间中
//     */
//    CC_MD5(str, (int)strlen(str), md);
//    //创建一个可变字符串收集结果
//    NSMutableString * ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
//    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
//        /**
//         X 表示以十六进制形式输入/输出
//         02 表示不足两位，前面补0输出；出过两位不影响
//         printf("%02X", 0x123); //打印出：123
//         printf("%02X", 0x1); //打印出：01
//         */
//        [ret appendFormat:@"%02X",md[i]];
//    }
//
//    //返回一个长度为32的字符串
//    return [ret lowercaseString];
    
    return input;
    
}

/**
 获取当前月份
 
 @return 当前月份字符串
 */
-(NSString *)getCalendar{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    
    return [NSString stringWithFormat:@"%ld-%ld-%ld", comp.year, comp.month, comp.day];
}

/**
 暂停1s后返回上一个页面
 */
-(void)popVC{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(0.5);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}

/**
 保存用户帐号密码
 
 @param phoneStr 用户的手机号码
 @param pwdStr 用户的密码
 */
-(void)preservationPhone:(NSString *)phoneStr pwd:(NSString *)pwdStr{
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSDictionary *userDic = [[NSDictionary alloc]initWithObjectsAndKeys:phoneStr, @"phone", pwdStr, @"password", nil];
        NSUserDefaults *userInfoDefault = [NSUserDefaults standardUserDefaults];
        [userInfoDefault setObject:userDic forKey:@"phoneAndPassWord"];
        [userInfoDefault synchronize];
//    }];
}

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

/**
 时间转时间戳字符串

 @param timeInterval 时间
 @return 时间戳字符串
 */
-(NSString *)timeStringToTimeInterval:(NSString *)timeInterval{
    NSDate *UTCDate = [self UTCDateFromLocalString:timeInterval];
    NSString *timeStamap = [self timeStampFromUTCDate:UTCDate];
    return timeStamap;
}

-(NSString *)timeStampFromUTCDate:(NSDate *)UTCDate{
     NSTimeInterval timeInterval = [UTCDate timeIntervalSince1970];
     // *1000,是精确到毫秒；这里是精确到秒;
     NSString *result = [NSString stringWithFormat:@"%.0f",timeInterval];
     return result;
 }

//将当前时间字符串转为UTCDate
-(NSDate *)UTCDateFromLocalString:(NSString *)localString{
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
     NSDate *date = [dateFormatter dateFromString:localString];
     return date;
}

static int overTimeSec = 10;
//- (AFHTTPSessionManager *)defaultNetManager {
//    static AFHTTPSessionManager *manager;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[AFHTTPSessionManager alloc]init];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    });
//    return manager;
//}

-(void)urlHeadStr:(NSString *)headStr urlStr:(NSString *)urlStr parameters:(NSDictionary *__nullable)ParaDic Success:(SuccessBlock)successBlock{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    // 客户端是否信任非法证书
    securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"URL请求参数  ==  %@%@  %@", headStr, urlStr, ParaDic);
    
    if (!self.refreshManager) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [LSProgressHUD showToView:self.view message:nil];
        }];
    }
    
    NSURLSessionTask *task = [manager POST:[NSString stringWithFormat:@"%@%@?",headStr,urlStr] parameters:ParaDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@  ==  %@", urlStr, dic);
        
        if ([dic[@"code"] intValue] == 1) {
            successBlock(dic);
        }else{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.notiString = dic[@"msg"];
            }];
            
            NSLog(@"%@  ==  errorMessage  ==  %@", urlStr, dic[@"msg"]);
            
        }
        
        if (self.refreshManager) {
            if (self.refreshIndex == 1) {
                [self.refreshManager endRefreshWithType:HHRefreshTypeHeader];
            }else{
                [self.refreshManager endRefreshWithType:HHRefreshTypeFooter];
            }
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [LSProgressHUD hideForView:self.view];
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error  ==    %@==  %@", urlStr, error);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.notiString = @"请求失败，请检查网络连接";
        }];
        
        if (self.refreshManager) {
            if (self.refreshIndex == 1) {
                [self.refreshManager endRefreshWithType:HHRefreshTypeHeader];
            }else{
                [self.refreshManager endRefreshWithType:HHRefreshTypeFooter];
            }
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [LSProgressHUD hideForView:self.view];
        }];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(overTimeSec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [task cancel];
    });
}

//-(void)getUrlHeadstr:(NSString *)url parameters:(NSDictionary *__nullable)ParaDic refreshManager:(HHRefreshManager *__nullable)refreshManager refreshWithType:(HHRefreshType)type Success:(SuccessBlock)successBlock{
//    AFHTTPSessionManager *manager = [self defaultNetManager];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    securityPolicy.allowInvalidCertificates = YES;
//    securityPolicy.validatesDomainName = NO;
//    manager.securityPolicy = securityPolicy;
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSURLSessionTask *task = [manager GET:[NSString stringWithFormat:@"%@%@?",IPURL,url] parameters:ParaDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        if ([dic[@"code"] intValue] == 1) {
//            successBlock(dic);
//        }else{
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                self.notiString = dic[@"msg"];
//            }];
//        }
//        if (refreshManager) {
//            [refreshManager endRefreshWithType:type];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (refreshManager) {
//            [refreshManager endRefreshWithType:type];
//        }
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            self.notiString = @"请求失败，请检查网络连接";
//        }];
//    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(overTimeSec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [task cancel];
//    });
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

-(void)createUI{
    
}

#pragma mark    左按钮点击事件，一般是返回上一个页面
/**
 左按钮点击事件，一般是返回上一个页面
 */
-(void)leftSelect{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark    创建图片右按钮
/**
 创建图片右按钮

 @param rightImageString 图片名称
 */
-(void)setRightImageString:(NSString *)rightImageString{
    [self.headview.rightButton setImage:[UIImage imageNamed:rightImageString] forState:UIControlStateNormal];
    [self.headview.rightButton addTarget:self action:@selector(rightSelect) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark    右按钮点击事件
/**
 右按钮点击事件
 */
-(void)rightSelect{
    
}

-(void)onClick:(id)obj{
    
}

/**
 设置页面标题

 @param titleString 标题字符串
 */
-(void)setTitleString:(NSString *)titleString{
    self.headview.titleLabel.text = titleString;
}

-(void)setInfoDic:(DelouchRightButtonInfo)infoDic{
    [self.headview.rightButton setTitle:infoDic.textString forState:UIControlStateNormal];
    [self.headview.rightButton setTitleColor:[UIColor colorWithRed:infoDic.colorRed / 255.0 green:infoDic.colorGreen / 255.0 blue:infoDic.colorBlue / 255.0 alpha:1] forState:UIControlStateNormal];
    if (infoDic.backColorAlpha != 2) {
        self.headview.rightButton.backgroundColor = [UIColor colorWithRed:infoDic.backColorRed / 255.0 green:infoDic.backColorGreen / 255.0 blue:infoDic.backColorBlue / 255.0 alpha:1];
    }
    self.headview.rightButton.titleLabel.font = [UIFont systemFontOfSize:infoDic.fontSize];
    [self.headview.rightButton addTarget:self action:@selector(rightSelect) forControlEvents:UIControlEventTouchUpInside];
}

/**
 页面头视图

 @return 页面头视图
 */
-(NaviHeadView *)headview{
    if (!_headview) {
        _headview = [[NaviHeadView alloc]init];
        [self.view addSubview:_headview];
        [_headview.leftButton addTarget:self action:@selector(leftSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headview;
}

@end

@implementation NaviHeadView : UIView

-(UIView *)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, DelouchWidth, DelouchStatusBarAndNavigationBarHeight);
        self.backgroundColor = [UIColor whiteColor];
        _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(5, DelouchStatusBarHeight, 44, 44)];
        [_leftButton setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
        [self addSubview:_leftButton];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(DelouchWidth * 0.25, DelouchStatusBarHeight, DelouchWidth * 0.5, 44)];
//        _titleLabel.font = [UIFont systemFontOfSize:17];
        
//        PingFangSC-Semibold
//        _titleLabel.font = [UIFont systemFontOfSize:17 weight:6];
        
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
        
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        _lineView = [[DelouchView alloc]initView:DelouchViewInfoMake(240, 240, 240, 1, NO, 0, self) setFrame:DelouchFrameMake(FrameNotChange, 0, DelouchStatusBarAndNavigationBarHeight - 1, DelouchWidth, 1)];
    }
    return self;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/375.0 * 365) - 64, DelouchStatusBarHeight, 64, 44)];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}

@end

@implementation DelouchLabel : UILabel

-(UILabel *)initLabel:(DelouchLabelInfo)infoDic setFrame:(DelouchFrame)delouchFrame{
    if (self = [super init]) {
        self.infoDic = infoDic;
        float baseicFloat = [UIScreen mainScreen].bounds.size.width/375.0;
        self.text = infoDic.textString;
        if (infoDic.fontChange) {
            self.font = [UIFont systemFontOfSize:infoDic.fontSize * baseicFloat];
        }else{
            self.font = [UIFont systemFontOfSize:infoDic.fontSize];
        }
        self.textColor = [UIColor colorWithRed:infoDic.colorRed/255.0 green:infoDic.colorGreen/255.0 blue:infoDic.colorBlue/255.0 alpha:infoDic.colorAlpha];
        if (infoDic.backColorAlpha != 2) {
            self.backgroundColor = [UIColor colorWithRed:infoDic.backColorRed/255.0 green:infoDic.backColorGreen/255.0 blue:infoDic.backColorBlue/255.0 alpha:infoDic.backColorAlpha];
        }
        switch (delouchFrame.frameType) {
            case FrameStatusBar:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, (delouchFrame.floatY - 64) * baseicFloat + DelouchStatusBarAndNavigationBarHeight, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FrameHeadView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, (delouchFrame.floatY - 20) + DelouchStatusBarHeight, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight);
                break;
                
            case FrameCellView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, delouchFrame.floatY * baseicFloat, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FramePopView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, DelouchHeight - (delouchFrame.floatY * baseicFloat) - DelouchTabbarSafeBottomMargin, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat + DelouchTabbarSafeBottomMargin);
                break;
                
            case FrameFive:
                self.frame = CGRectMake(0, delouchFrame.floatY, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FrameNotChange:
                self.frame = CGRectMake((int)delouchFrame.floatX, delouchFrame.floatY, delouchFrame.floatWidth, delouchFrame.floatHeight);
                break;
                
            default:
                
                break;
        }
        
        switch (infoDic.textAlignType) {
            case 1:
                self.textAlignment = NSTextAlignmentLeft;
                break;
                
            case 2:
                self.textAlignment = NSTextAlignmentCenter;
                break;
                
            case 3:
                self.textAlignment = NSTextAlignmentRight;
                break;
                
            default:
                break;
        }
        [infoDic.backView addSubview:self];
    }
    return self;
}

@end

@implementation DelouchView : UIView

-(UIView *)initView:(DelouchViewInfo)infoDic setFrame:(DelouchFrame)delouchFrame{
    if (self = [super init]) {
        self.infoDic = infoDic;
        float baseicFloat = [UIScreen mainScreen].bounds.size.width/375.0;
        self.backgroundColor = [UIColor colorWithRed:infoDic.backColorRed / 255.0 green:infoDic.backColorGreen / 255.0 blue:infoDic.backColorBlue / 255.0 alpha:infoDic.backColorAlpha];
        switch (delouchFrame.frameType) {
            case FrameStatusBar:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, (delouchFrame.floatY - 64) * baseicFloat + DelouchStatusBarAndNavigationBarHeight, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FrameHeadView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, (delouchFrame.floatY - 20) + DelouchStatusBarHeight, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight);
                break;
                
            case FrameCellView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, delouchFrame.floatY * baseicFloat, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FramePopView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, DelouchHeight - (delouchFrame.floatY * baseicFloat) - DelouchTabbarSafeBottomMargin, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat + DelouchTabbarSafeBottomMargin);
                break;
                
            case FrameFive:
                self.frame = CGRectMake(0, delouchFrame.floatY, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FrameNotChange:
                self.frame = CGRectMake(delouchFrame.floatX, delouchFrame.floatY, delouchFrame.floatWidth, delouchFrame.floatHeight);
                break;
                
            default:
                
                break;
        }
        if (infoDic.layerBool) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(infoDic.layerSize * baseicFloat, infoDic.layerSize * baseicFloat)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
            maskLayer.frame = self.bounds;
            maskLayer.path = maskPath.CGPath;
            self.layer.mask = maskLayer;
        }
        self.userInteractionEnabled = YES;
        [infoDic.backView addSubview:self];
    }
    return self;
}

@end

@implementation DelouchTextField : UITextField

-(UITextField *)initTextField:(DelouchTextFieldInfo)infoDic setFrame:(DelouchFrame)delouchFrame{
    if (self = [super init]) {
        self.infoDic = infoDic;
        float baseicFloat = [UIScreen mainScreen].bounds.size.width/375.0;
        self.text = infoDic.textString;
        self.placeholder = infoDic.placeholderTextString;
        self.secureTextEntry = infoDic.isSecureTextEntry;
        if (infoDic.isRound) {
            self.borderStyle = UITextBorderStyleRoundedRect;
            self.layer.borderWidth = baseicFloat;
            self.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.85].CGColor;
            self.clipsToBounds = true;
        }
        switch (delouchFrame.frameType) {
            case FrameStatusBar:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, (delouchFrame.floatY - 64) * baseicFloat + DelouchStatusBarAndNavigationBarHeight, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FrameHeadView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, (delouchFrame.floatY - 20) + DelouchStatusBarHeight, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight);
                break;
                
            case FrameCellView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, delouchFrame.floatY * baseicFloat, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FramePopView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, DelouchHeight - (delouchFrame.floatY * baseicFloat) - DelouchTabbarSafeBottomMargin, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat + DelouchTabbarSafeBottomMargin);
                break;
                
            case FrameFive:
                self.frame = CGRectMake(0, delouchFrame.floatY, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FrameNotChange:
                self.frame = CGRectMake((int)delouchFrame.floatX, delouchFrame.floatY, delouchFrame.floatWidth, delouchFrame.floatHeight);
                break;
                
            default:
                
                break;
        }
        if (infoDic.fontChange) {
            self.font = [UIFont systemFontOfSize:infoDic.fontSize * baseicFloat - 1];
        }else{
            self.font = [UIFont systemFontOfSize:infoDic.fontSize];
        }
        self.textColor = [UIColor colorWithRed:infoDic.colorRed / 255.0 green:infoDic.colorGreen / 255.0 blue:infoDic.colorBlue / 255.0 alpha:infoDic.colorAlpha];
        [infoDic.backView addSubview:self];
    }
    return self;
}

@end


@implementation DelouchImageView : UIImageView

-(UIImageView *)initImageView:(DelouchImageViewInfo)infoDic setFrame:(DelouchFrame)delouchFrame{
    if (self = [super init]) {
        self.infoDic = infoDic;
        float baseicFloat = [UIScreen mainScreen].bounds.size.width/375.0;
        switch (delouchFrame.frameType) {
            case FrameStatusBar:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, (delouchFrame.floatY - 64) * baseicFloat + DelouchStatusBarAndNavigationBarHeight, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FrameHeadView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, (delouchFrame.floatY - 20) + DelouchStatusBarHeight, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight);
                break;
                
            case FrameCellView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, delouchFrame.floatY * baseicFloat, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FramePopView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, DelouchHeight - (delouchFrame.floatY * baseicFloat) - DelouchTabbarSafeBottomMargin, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat + DelouchTabbarSafeBottomMargin);
                break;
                
            case FrameFive:
                self.frame = CGRectMake(0, delouchFrame.floatY, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FrameNotChange:
                self.frame = CGRectMake((int)delouchFrame.floatX, delouchFrame.floatY, delouchFrame.floatWidth, delouchFrame.floatHeight);
                break;
                
            default:
                
                break;
        }
        if (infoDic.imageNameString.length > 0) {
            self.image = [UIImage imageNamed:infoDic.imageNameString];
            
        }
//        self.contentMode = UIViewContentModeCenter;
        self.userInteractionEnabled = YES;
        if (infoDic.layerBOOL) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(infoDic.layerSize * baseicFloat, infoDic.layerSize * baseicFloat)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
            maskLayer.frame = self.bounds;
            maskLayer.path = maskPath.CGPath;
            self.layer.mask = maskLayer;
        }
        [infoDic.backView addSubview:self];
    }
    return self;
}

@end


@implementation DelouchTitleButton : UIButton

-(UIButton *)initButton:(DelouchTitleButtonInfo)infoDic setFrame:(DelouchFrame)delouchFrame{
    if (self = [super init]) {
        self.infoDic = infoDic;
        float baseicFloat = [UIScreen mainScreen].bounds.size.width/375.0;
        [self setTitle:infoDic.textString forState:UIControlStateNormal];
        if (infoDic.backColorAlpha != 2) {
            self.backgroundColor = [UIColor colorWithRed:infoDic.backColorRed / 255.0 green:infoDic.backColorGreen / 255.0 blue:infoDic.backColorBlue / 255.0 alpha:infoDic.backColorAlpha];
        }
        [self setTitleColor:[UIColor colorWithRed:infoDic.colorRed / 255.0 green:infoDic.colorGreen / 255.0 blue:infoDic.colorBlue / 255.0 alpha:infoDic.colorAlpha] forState:UIControlStateNormal];
        switch (delouchFrame.frameType) {
            case FrameStatusBar:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, (delouchFrame.floatY - 64) * baseicFloat + DelouchStatusBarAndNavigationBarHeight, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FrameHeadView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, (delouchFrame.floatY - 20) + DelouchStatusBarHeight, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight);
                break;
                
            case FrameCellView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, delouchFrame.floatY * baseicFloat, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FramePopView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, DelouchHeight - (delouchFrame.floatY * baseicFloat) - DelouchTabbarSafeBottomMargin, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat + DelouchTabbarSafeBottomMargin);
                break;
                
            case FrameFive:
                self.frame = CGRectMake(0, delouchFrame.floatY, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FrameNotChange:
                self.frame = CGRectMake((int)delouchFrame.floatX, delouchFrame.floatY, delouchFrame.floatWidth, delouchFrame.floatHeight);
                break;
                
            default:
                
                break;
        }
        
        switch (infoDic.textAlignType) {
            case 1:
                self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                break;
                
            case 2:
                self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                break;
                
            case 3:
                self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                break;
                
            default:
                break;
        }
        if (infoDic.fontChange) {
            self.titleLabel.font = [UIFont systemFontOfSize:infoDic.fontSize * baseicFloat - 1];
        }else{
            self.titleLabel.font = [UIFont systemFontOfSize:infoDic.fontSize];
        }
        [infoDic.backView addSubview:self];
    }
    return self;
}

@end

@implementation DelouchImageButton : UIButton

-(UIButton *)initButton:(DelouchImageButtonInfo)infoDic setFrame:(DelouchFrame)delouchFrame{
    if (self = [super init]) {
        self.infoDic = infoDic;
        float baseicFloat = [UIScreen mainScreen].bounds.size.width/375.0;
        [self setImage:[UIImage imageNamed:infoDic.imageString] forState:UIControlStateNormal];
        
        switch (delouchFrame.frameType) {
            case FrameStatusBar:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, (delouchFrame.floatY - 64) * baseicFloat + DelouchStatusBarAndNavigationBarHeight, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FrameHeadView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, (delouchFrame.floatY - 20) + DelouchStatusBarHeight, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight);
                break;
                
            case FrameCellView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, delouchFrame.floatY * baseicFloat, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FramePopView:
                self.frame = CGRectMake(delouchFrame.floatX * baseicFloat, DelouchHeight - (delouchFrame.floatY * baseicFloat) - DelouchTabbarSafeBottomMargin, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat + DelouchTabbarSafeBottomMargin);
                break;
                
            case FrameFive:
                self.frame = CGRectMake(0, delouchFrame.floatY, delouchFrame.floatWidth * baseicFloat, delouchFrame.floatHeight * baseicFloat);
                break;
                
            case FrameNotChange:
                self.frame = CGRectMake((int)delouchFrame.floatX, delouchFrame.floatY, delouchFrame.floatWidth, delouchFrame.floatHeight);
                break;
                
            default:
                
                break;
        }
        [infoDic.backView addSubview:self];
    }
    return self;
}

@end

@implementation PhoneAndPwModel

-(instancetype)initWithactivityModelDic:(NSDictionary*)dic{
    if ([super init]) {
        _phoneStr = dic[@"phone"];
        _passwordStr = dic[@"password"];
    }
    return self;
}

@end

@implementation DelouchLibrary

+(CGSize)sizeWithText:(NSString *__nullable)text withFont:(CGFloat)fontSize{
    return [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize * (DelouchWidth / 375.0)]}];
}

+ (void)setbuttonLayer:(UIButton *__nullable)button layerMask:(CGFloat)layerFloat{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(layerFloat * (DelouchWidth / 375.0), layerFloat * (DelouchWidth / 375.0))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = button.bounds;
    maskLayer.path = maskPath.CGPath;
    button.layer.mask = maskLayer;
}

#pragma mark    跳转页面
/**
 跳转页面
 
 @param VcStr 要跳转的页面的值
 @param dic 传值的参数
 */
+(void)pushViewControl:(NSString *)VcStr propertyDic:(NSDictionary *__nullable)dic{
    id toCon = [[NSClassFromString(VcStr) alloc]init];
    NSArray *keyArr = [dic allKeys];
    for (int i = 0; i < keyArr.count; i++) {
        NSString *key = [keyArr objectAtIndex:i];
        id value = [dic valueForKey:key];
        //把key的首字母大写
        NSString *firstStr = [key substringWithRange:NSMakeRange(0, 1)].uppercaseString;
        NSString *restStr = [key substringFromIndex:1];
        //生成对应属性的set方法
        NSString *selName = [NSString stringWithFormat:@"set%@%@:", firstStr, restStr];
        SEL method = NSSelectorFromString(selName);
        if ([toCon respondsToSelector:method]) {
            //等价于controller.shuxing = value;
            //如果是数字则在字典中是NSNumber类型,需要把NSNumber类型转为NSInteger或者CGFloat
            if ([value isKindOfClass:[NSNumber class]]) {
                NSString *vale = [(NSNumber *) value stringValue];
                if ([vale containsString:@"."]) {
                    CGFloat val = [vale doubleValue];
                    void (*action)(id, SEL, CGFloat) = (void (*)(id, SEL, CGFloat)) objc_msgSend;
                    action(toCon, method, val);
                }else{
                    NSInteger val = [(NSNumber *) value integerValue];
                    void (*action)(id, SEL, NSInteger) = (void (*)(id, SEL, NSInteger)) objc_msgSend;
                    action(toCon, method, val);
                }
            } else {
                void (*action)(id, SEL, id) = (void (*)(id, SEL, id)) objc_msgSend;
                action(toCon, method, value);
            }
        }
    }
    [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:(UIViewController *)toCon animated:YES];
}

+(void)setMoneyLabel:(UILabel *)moneyLabel moneyText:(NSString *__nullable)moneyText bigFont:(CGFloat)bigFont smallFont:(CGFloat)smallFont{
    if (moneyText.length == 0) {
        moneyText = @"0";
    }
    moneyLabel.font = [UIFont fontWithName:@"ZapfDingbatsITC" size:bigFont * (DelouchWidth / 375.0)];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[moneyText doubleValue]]];
    
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:formattedNumberString];
    
    [abs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallFont * (DelouchWidth / 375.0)] range:NSMakeRange(formattedNumberString.length - 3, 3)];
    
    moneyLabel.attributedText = abs;
}

- (NSString *)getMoneyStringWithMoneyNumber:(double)money{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:money]];
    return formattedNumberString;
}

+(void)setDicBoldFont:(UILabel *)label font:(CGFloat)fontSize{
    label.font = [UIFont fontWithName:@"ZapfDingbatsITC" size:fontSize * (DelouchWidth / 375.0)];
}

@end
