//
//  AppDelegate.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/10.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "AppDelegate.h"
#import "UrlConnect.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import <LSLaunchAD.h>

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSUserDefaults *userInfoDefault = [NSUserDefaults standardUserDefaults];
    PhoneAndPwModel *phoneAndPwModel = [[PhoneAndPwModel alloc]initWithactivityModelDic:[userInfoDefault objectForKey:@"phoneAndPassWord"]];
    if (phoneAndPwModel.phoneStr.length == 11) {
        [UrlConnect postUrlHeadstr:UrlFrontLogin parameters:[NSDictionary dictionaryWithObjectsAndKeys:phoneAndPwModel.phoneStr, @"phone", phoneAndPwModel.passwordStr, @"user_pwd", nil] Success:^(NSDictionary * _Nonnull obj) {
            NSUserDefaults *userInfoDefault = [NSUserDefaults standardUserDefaults];
            [userInfoDefault setObject:obj[@"result"] forKey:@"userInfo"];
            [userInfoDefault synchronize];
            MainViewController *VC = [[MainViewController alloc]init];
            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:VC];
            self.window.rootViewController = nvc;
        } defeatBlock:^(NSString * _Nonnull obj) {
            LoginViewController *VC = [[LoginViewController alloc]init];
            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:VC];
            self.window.rootViewController = nvc;
        } faildBlock:^(id  _Nonnull obj) {
            LoginViewController *VC = [[LoginViewController alloc]init];
            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:VC];
            self.window.rootViewController = nvc;
        }];
    }else{
        LoginViewController *VC = [[LoginViewController alloc]init];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:VC];
        self.window.rootViewController = nvc;
    }
    [WXApi registerApp:@"wxd930ea5d5a258f4f"];
    
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [NSThread sleepForTimeInterval:1];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

-(void)onResp:(BaseResp*)resp{
    SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;
    switch (sendResp.errCode) {
            case 0:
                {
                    NSLog(@"分享成功");
                }
            break;
            
            case -2:
                {
                    NSLog(@"取消分享");
                }
            break;
            
        default:
            {
                NSLog(@"分享失败");
            }
            break;
    }
    
    
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"resultDic  ==  %@", [self dictionaryWithJsonString:resultDic[@"result"]]);
            NSDictionary *dic = [self dictionaryWithJsonString:resultDic[@"result"]];
            if ([dic[@"alipay_trade_app_pay_response"][@"msg"] isEqualToString:@"Success"]) {
                NSLog(@"购买成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WxBuyNoti" object:@"success"];
            }else{
                NSLog(@"购买失败");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WxBuyNoti" object:@"error"];
            }
            
        }];
    }
    return YES;
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        return nil;
    }
    return dic;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
