//
//  AppDelegate.h
//  BQ
//
//  Created by zzlmilk on 13-3-25.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    @private
    UINavigationController *navHomeVc;
    UserViewController *userVC;
}
@property (strong, nonatomic) UIWindow *window;

+(BOOL)isNetworkReachable;
+ (id)getAppdelegate;
- (void)setNavigateBarHidden:(BOOL)isHidden;
@end
