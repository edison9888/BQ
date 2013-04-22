//
//  AppDelegate.h
//  BQ
//
//  Created by zzlmilk on 13-3-25.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navHomeVc;
}
@property (strong, nonatomic) UIWindow *window;

+(BOOL)isNetworkReachable;
+ (id)getAppdelegate;
- (void)setNavigateBarHidden:(BOOL)isHidden;
@end
