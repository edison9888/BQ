//
//  MapViewController.m
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MapViewController.h"
#import "Helper.h"
#import "ToolBar.h"

#define TabBarHeight 44

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Helper leftBarButtonItem:self];
    
    self.navigationItem.rightBarButtonItem = [Helper rightBarButtonItem:self];
    
    self.title = @"附近银行";
            
    _map = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height-TabBarHeight-TabBarHeight)];
    _map.showsUserLocation = YES;
    [self.view addSubview:_map];
    
    ToolBar *toolBar = [[ToolBar alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-TabBarHeight-TabBarHeight, self.view.frame.size.width, 44) viewController:self];
    [self.view addSubview:toolBar];
    
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];//创建位置管理器
   // locationManager.delegate=self;//设置代理
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;//指定需要的精度级别
    locationManager.distanceFilter=1000.0f;//设置距离筛选器
    [locationManager startUpdatingLocation];//启动位置管理器
    MKCoordinateRegion theRegion = { {0.0, 0.0 }, { 0.0, 0.0 } };
    theRegion.center=[[locationManager location] coordinate];
   
    [_map setZoomEnabled:YES];
    [_map setScrollEnabled:YES];
    theRegion.span.longitudeDelta = 0.01f;
    theRegion.span.latitudeDelta = 0.01f;
    [_map setRegion:theRegion animated:YES];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}

#pragma mark--
#pragma mark--Navigation-Method
//返回上一层
- (void)backToLastVC{
    [self.navigationController popViewControllerAnimated:YES];
}

//跳转列表
- (void)turnToListVC{
    
//    [self transitionFromViewController:<#(UIViewController *)#> toViewController:<#(UIViewController *)#> duration:<#(NSTimeInterval)#> options:<#(UIViewAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>];

}

#pragma mark--
#pragma mark--ToolBar--Method
//选择地区
-(void)selectAreas{

}

//定位自己
- (void)locationSelf{


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
