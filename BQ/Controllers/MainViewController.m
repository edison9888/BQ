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
    
    
    MapViewController *homeVC = [[MapViewController alloc]init];
    homeVC.tabBarItem.title = @"首页";

    
    
    UserViewController *userVC = [[UserViewController alloc]init];
    userVC.tabBarItem.title=@"我的排号";
        
    
    
    SetViewController *setVC = [[SetViewController alloc]init];
    setVC.title=@"设置";
    
    
    self.viewControllers = @[homeVC,userVC,setVC];
    
}
@end
