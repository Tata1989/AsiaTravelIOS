//
//  ATTabBarController.m
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import "ATTabBarController.h"
#import "ATNavigationController.h"
#import "ATBaseWebViewVC.h"

@interface ATTabBarController ()<UITabBarControllerDelegate>
{
//    UIButton *button;
    UITabBar *mayTabBar;
    
}
@property (nonatomic, strong) UIButton *button;
@end

@implementation ATTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 初始化所有的子控制器
    
    [self setupAllChildViewControllers];
}

- (void)setupAllChildViewControllers
{
    NSArray *titleArray = @[@"首页", @"订单", @"客服",@"我的"];
    NSArray *urlStrArray =@[@"", @"order.html", @"service.html",@"user.html"];
    
    for (int i = 0; i < titleArray.count; i++) {
         ATBaseWebViewVC *tmpVC = [[ATBaseWebViewVC alloc] init];
        tmpVC.canBack = NO;
        tmpVC.navigationItemTitle = titleArray[i];
        tmpVC.webUrl = [NSString stringWithFormat:@"%@%@",kBaseURL,urlStrArray[i]];
        [self setupChildViewController:tmpVC title:titleArray[i] imageName:@"tabbar_mine_normal"  selectedImageName:@"tabbar_mine_selected"];

    }
    
}
/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    
    [childVc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x666666),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x32b4c2),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    [childVc.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    // 设置选中的图标
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 2.包装一个导航控制器
    ATNavigationController *nav = [[ATNavigationController alloc] initWithRootViewController:childVc];
    if ([title isEqualToString:@"首页"]) {
        nav.navigationBarHidden = YES;
    }
    [self addChildViewController:nav];
    
   
 }
@end
