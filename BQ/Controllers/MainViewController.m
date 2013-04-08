//
//  MainViewController.m
//  BQ
//
//  Created by zzlmilk on 13-3-25.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "UserViewController.h"
#import "SetViewController.h"


#import "MapViewController.h"


@implementation MainViewController

-(void)viewDidLoad{
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //自定义的tabBar背景
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"customerTabBar"]];
    
//    UIImageView *homeBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beiJing"]];
//    homeBG.frame  = self.view.bounds;
//    homeBG.userInteractionEnabled =YES;
//    [self.view insertSubview:homeBG atIndex:0];

    HomeViewController *homeVC = [[HomeViewController alloc]init];
    homeVC.title = @"首页";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"homeIcon"];
    UINavigationController *navHome = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    
    
    UserViewController *userVC = [[UserViewController alloc]init];
    userVC.title=@"我的排号";
    userVC.tabBarItem.image = [UIImage imageNamed:@"personIcon"];
    UINavigationController *navUser = [[UINavigationController alloc]initWithRootViewController:userVC];
    
    
    SetViewController *setVC = [[SetViewController alloc]init];
    setVC.title=@"设置";
    setVC.tabBarItem.image = [UIImage imageNamed:@"setIcon"];
    UINavigationController *navSet = [[UINavigationController alloc]initWithRootViewController:setVC];
    
    
    self.viewControllers = @[navHome,navUser,navSet];
    
}


@end
