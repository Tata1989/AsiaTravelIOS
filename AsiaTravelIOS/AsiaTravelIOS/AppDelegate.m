//
//  AppDelegate.m
//  AsiaTravelIOS
//
//  Created by wangxinxin on 15/11/26.
//  Copyright © 2015年 asiatravel. All rights reserved.
//

#import "AppDelegate.h"
#import "ATNavigationController.h"
#import "ATTabBarController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>


@interface AppDelegate ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *locationManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //    MainWebView *mainVC = [[MainWebView alloc] init];
    ////    mainVC.webUrl = @"http://cn.asiatravel.net/mobile/";
    //    mainVC.webUrl = @"http://10.2.21.231/frame/index.html";
    //    mainVC.navigationItemTitle = @"亚洲旅游";
    
    //    ATNavigationController *nav = [[ATNavigationController alloc] initWithRootViewController:mainVC];
    
    self.window.rootViewController = [[ATTabBarController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self getLocation];
    
    return YES;
}
/**
 *  获取用户位置
 */
- (void)getLocation
{
 
    if ([CLLocationManager locationServicesEnabled]) {
        if (!_locationManager) {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            _locationManager.distanceFilter = kCLDistanceFilterNone;
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [_locationManager requestAlwaysAuthorization];
            }
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)//6
                [_locationManager requestWhenInUseAuthorization];
            [_locationManager startUpdatingLocation];
        }
    }
}
#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    CLLocation *cloc = [locations lastObject];
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:cloc completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error){
            for (CLPlacemark * placemark in placemarks) {
                
                NSDictionary *dic = [placemark addressDictionary];
                //  Country(国家)  State(城市)  SubLocality(区)
                
                if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"gpsCity"] isEqualToString:[dic objectForKey:@"State"]]) {
                    DDLog(@"城市：%@ 区：%@",[dic objectForKey:@"State"],[dic objectForKey:@"SubLocality"]);
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"State"] forKey:@"gpsCity"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"SubLocality"] forKey:@"gpsSubLocality"];
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
            
            }
        }
        [_locationManager stopUpdatingLocation];
    }];
    
    CGFloat latitude = manager.location.coordinate.latitude;
    NSString *latitudeStr = [NSString stringWithFormat:@"%f",latitude];
    CGFloat longitude = manager.location.coordinate.longitude;
    NSString *longitudeStr = [NSString stringWithFormat:@"%f",longitude];
    
//    [[NSUserDefaults standardUserDefaults] setObject:latitudeStr forKey:@"latitude"];
//    [[NSUserDefaults standardUserDefaults] setObject:longitudeStr forKey:@"longitude"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    DDLog(@"%@--%@",latitudeStr,longitudeStr);
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
