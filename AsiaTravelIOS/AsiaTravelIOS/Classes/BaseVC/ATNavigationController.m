//
//  ATNavigationController.m
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import "ATNavigationController.h"
@implementation ATNavigationController

+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
}

+ (void)setupNavBarTheme
{
    // 1.取出appearance对象
    UINavigationBar *nacBar = [UINavigationBar appearance];
    [nacBar setTintColor:[UIColor blackColor]];
    
    // 2.设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    textAttrs[NSShadowAttributeName] = shadow;
    textAttrs[NSVerticalGlyphFormAttributeName] = @(0);
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [nacBar setTitleTextAttributes:textAttrs];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.exclusiveTouch = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];

}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    
//
    [super popViewControllerAnimated:animated];
    return nil;
}
@end
