//
//  ConfigTools.h
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//
#import <UIKit/UIKit.h>

//*************************************实用工具  *********************************
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define kWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;//block 弱化self
#define DegreesToRadians(x) (M_PI*(x)/180.0)//角度->弧度

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock) (id failureCode);
typedef void (^NetWorkBlock)(BOOL netConnetState);

#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
/*
 用来判断 字典的值 是否为null
 如果是null  则 返回@“”，
 否则 返回 原来的值
 */
#define KISNullValue(array,i,key) ([[[array objectAtIndex:i] allKeys] containsObject:key] && [[array objectAtIndex:i] objectForKey:key] != (NSString*)[NSNull null] ? [[array objectAtIndex:i] objectForKey:key] : @"")

#define KISDictionaryNullValue(dict,key) ([dict objectForKey:key] == (NSString*)[NSNull null] ? @"" : [dict objectForKey:key])

#define KISDictionaryHaveKey(dict,key) [[dict allKeys] containsObject:key] && ([dict objectForKey:key] != (NSString*)[NSNull null]) ? [dict objectForKey:key] : @""


#define MFDB @"mf.db"

//*************************************网络请求宏定义*********************************
#define kBaseURL        @"http://10.2.21.231:8080/"
#define kBaseFrameURL   @"http://10.2.21.231/frame"

//*************************************通知宏定义*********************************

//*************************************枚举的宏定义*********************************




//************************************颜色 工具********************************************
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ColorA(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromAlphaRGB(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

//*************************************屏幕尺寸和系统版本*********************************
#define iPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define kScreenIphone6    (([[UIScreen mainScreen] bounds].size.width)>=375)

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define iPhone5Padding ( ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON ) ?88:0)

#define IOS6 ([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending)

#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)

#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)

#define IOS7_OR_Later_VIEW_OFFSET (IOS7_OR_LATER?64:0)

#define iOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0 ? YES : NO)

#define NLSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)

//*************************************导航设置相关*********************************

#define SEGMENTCOLOR HEXCOLOR(0x3ea50cff)

#define PRICE_COLOR HEXCOLOR(0xff3e1fff)

#define BAR_ITEM_COLOR  HEXCOLOR(0xf7e463ff)

#define NAVIGATION_TITLE_FONT_SIZE  17
#define NAVIGATION_ITEM_FONT_SIZE   16
#define SEGMENT_ITEM_FONT_SIZE      14


#define kStatusBarHeight    20
#define kNavBarHeight       64
#define kTabarHeight        49




