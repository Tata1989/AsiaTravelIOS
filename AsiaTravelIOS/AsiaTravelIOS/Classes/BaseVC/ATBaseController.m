//
//  ATBaseController.m
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import "ATBaseController.h"
#import "NetworkTool.h"

@interface ATBaseController ()

@end

@implementation ATBaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    if ([NetworkTool networkStatus] == NO) {
//        [MBProgressHUD showMessage:@"当前网络不可用 请检查你的网络设置" time:3];
    }

    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([self.navigationController.navigationItem.title isEqualToString:@"首页"] //隐藏首页的导航栏
        && self.navigationController.viewControllers.count == 1) {
        self.navigationController.navigationBarHidden = YES;
    }
    else{
        self.navigationController.navigationBarHidden = NO;
    }
}

#pragma mark --返回按钮--
- (void)setUpNavigationBarLeftBack
{
    UIBarButtonItem *leftButtonItem = [UIBarButtonItem itemWithIcon:@"nav_back" highIcon:@"nav_back" target:self action:@selector(leftbarbuttonAction)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = 10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftButtonItem];
}

- (void)setupNavigationBar:(UINavigationController *)naviController {
    
    naviController.navigationBar.titleTextAttributes = @{
                                                         NSForegroundColorAttributeName : UIColorFromRGB(0xffffff), NSFontAttributeName : [UIFont fontWithName:@"TrebuchetMS-Bold"                                                                                                                size:NAVIGATION_TITLE_FONT_SIZE]
                                                         };

    
    [naviController.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x16364f)] forBarMetrics:UIBarMetricsDefault];
    [naviController.navigationBar setBackgroundColor:UIColorFromRGB(0x16364f)]; // 设置导航栏背景颜色
    
}

- (void)leftbarbuttonAction
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
