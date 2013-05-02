//
//  AppDelegate.m
//  BQ
//
//  Created by zzlmilk on 13-3-25.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "DBConnection.h"

#import <SystemConfiguration/SCNetworkReachability.h>
#import <netinet/in.h>

#define isNetingWork 0

@implementation AppDelegate

//自定以导航栏
//适用于 ios 5.0+
//-(void)customerNavigation{
//    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBarQ@2x"] forBarMetrics:UIBarMetricsDefault];
//    
//    
//}

//判断是否连网
+(BOOL)isNetworkReachable{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (id)getAppdelegate{
   return [UIApplication sharedApplication].delegate;
}

- (void)setNavigateBarHidden:(BOOL)isHidden{
    
    navHomeVc.navigationBarHidden=isHidden;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [DBConnection createEditableCopyOfDatabaseIfNeeded:NO];
    [DBConnection getSharedDatabase];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //背景图
    UIImageView *myhomeBG = [[UIImageView alloc]initWithFrame:self.window.bounds];
    if (iPhone5) {
        [myhomeBG setImage:[UIImage imageNamed:@"bigBack5"]];
    }else{
        [myhomeBG setImage:[UIImage imageNamed:@"bigBack4"]];
    }
    myhomeBG.userInteractionEnabled =YES;
    [self.window addSubview:myhomeBG];

    userVC = [[UserViewController alloc]init];
    navHomeVc = [[UINavigationController alloc] initWithRootViewController:userVC];
    navHomeVc.navigationBarHidden=YES;
    [self.window setRootViewController:navHomeVc];
    [self.window makeKeyAndVisible];
    
    userVC.isNetWork = [[self class] isNetworkReachable];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    userVC.isNetWork = [[self class] isNetworkReachable];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
