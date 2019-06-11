//
//  UrlConnect.m
//  HeartNest
//
//  Created by Mac on 2018/12/3.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "UrlConnect.h"
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>

@implementation UrlConnect

static int overTimeSec = 20;
+ (AFHTTPSessionManager*)defaultNetManager {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc]init];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return manager;
}

+(void)postUrlHeadstr:(NSString *)url parameters:(NSDictionary * _Nullable)ParaDic Success:(SuccessBlock)successBlock defeatBlock:(DefeatBlock)defeatBlock faildBlock:(FaileBlock)faildBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [UrlConnect defaultNetManager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSURLSessionTask *task = [manager POST:[NSString stringWithFormat:@"%@%@?",MyinfoIPURL,url] parameters:ParaDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"code"] intValue] == 1) {
                successBlock(dic);
            }else{
                defeatBlock(dic[@"message"]);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            faildBlock(error);
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(overTimeSec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [task cancel];
        });
    });
}

@end
