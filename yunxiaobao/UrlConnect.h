//
//  UrlConnect.h
//  HeartNest
//
//  Created by Mac on 2018/12/3.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SuccessBlock)(NSDictionary *obj);

typedef void (^DefeatBlock)(NSString *obj);

typedef void (^FaileBlock)(id obj);

@interface UrlConnect : NSObject

+ (AFHTTPSessionManager*)defaultNetManager;

+(void)postUrlHeadstr:(NSString *)url parameters:(NSDictionary * _Nullable)ParaDic Success:(SuccessBlock)successBlock defeatBlock:(DefeatBlock)defeatBlock faildBlock:(FaileBlock)faildBlock;

@end

NS_ASSUME_NONNULL_END
