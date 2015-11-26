//
//  ATBaseWebViewVC.h
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import "ATBaseController.h"

@interface ATBaseWebViewVC : ATBaseController

/**
 *  web url
 */
@property(nonatomic, copy)NSString *webUrl;
/**
 *  页面title
 */
@property(nonatomic, copy)NSString *navigationItemTitle;


@property(nonatomic, assign)BOOL canBack;
@end
