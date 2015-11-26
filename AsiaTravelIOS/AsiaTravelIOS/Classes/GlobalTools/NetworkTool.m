//
//  NetworkTool.m
//  WebViewPJ
//
//  Created by wangxinxin on 15/11/25.
//  Copyright © 2015年 wangxinxin. All rights reserved.
//

#import "NetworkTool.h"
#import "AFNetworkReachabilityManager+NetworkReachability.h"
@implementation NetworkTool

// 检测网络连接状态
+ (BOOL)networkStatus
{
    if ([AFNetworkReachabilityManager sharedReachabilityManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        return NO;
    } else {
        return YES;
    }
}
@end
