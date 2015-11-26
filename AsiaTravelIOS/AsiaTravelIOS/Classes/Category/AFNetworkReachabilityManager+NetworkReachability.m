//
//  AFNetworkReachabilityManager+NetworkReachability.m
//  WebViewPJ
//
//  Created by wangxinxin on 15/11/25.
//  Copyright © 2015年 wangxinxin. All rights reserved.
//

#import "AFNetworkReachabilityManager+NetworkReachability.h"

@implementation AFNetworkReachabilityManager (NetworkReachability)
+ (instancetype)sharedReachabilityManager{
    static AFNetworkReachabilityManager *_sharedReachabilityManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedReachabilityManager = [self managerForDomain:@"www.baidu.com"];
        [_sharedReachabilityManager startMonitoring];
    });
    
    return _sharedReachabilityManager;
}
@end
