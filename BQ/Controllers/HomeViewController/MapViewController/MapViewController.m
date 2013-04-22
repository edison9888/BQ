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
#import "Bank.h"
#import "HomeViewController.h"
#import "DatabaseOperations.h"

#import "AppDelegate.h"
#import "Bank.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapVC,mapListVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Helper leftBarButtonItem:self];
    
    self.navigationItem.rightBarButtonItem = [Helper rightBarButtonItem:self];
    
    self.title = @"附近银行";
    
    //工具条
    ToolBar *toolBar = [[ToolBar alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-TabBarHeight-NavigationHeight, self.view.frame.size.width, TabBarHeight) viewController:self];
    [self.view addSubview:toolBar];
    
    //地图
    self.mapVC = [[MapShowViewController alloc] init];
    self.mapVC.view.frame=CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height-TabBarHeight-TabBarHeight);
    self.mapVC.homeVC=self.homeVC;
//    [self.view addSubview:self.mapVC.view];
    [self addChildViewController:self.mapVC];
    
    //列表
    self.mapListVC = [[MapListViewController alloc] init];
    self.mapListVC.view.frame=self.mapVC.view.frame;
    self.mapListVC.homeVC=self.homeVC;
    [self.view addSubview:self.mapListVC.view];
    [self addChildViewController:self.mapListVC];
 
    //区域PickerVC
    pickerViewController  = [[PickerView alloc] init];
    [self addChildViewController:pickerViewController];
    [pickerViewController.view setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 215+45)];
    //    pickerViewController.pickerArrs=xxx;获取pickerArr刷新数据
    [[self.view superview] addSubview:pickerViewController.view];

    //判断是否联网
    [self isNetWork];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //获得数据
    Bank *bank1 = [[Bank alloc] init];
    bank1.lat = 32.00;
    bank1.lon = 120.00;
    bank1.title = @"招商银行（莘庄）";
    bank1.subtitle = @"莘松路985号";
    
    Bank *bank2 = [[Bank alloc] init];
    bank2.lat = 32.90;
    bank2.lon = 121.00;
    bank2.title = @"招商银行(闵行支行)";
    bank2.subtitle = @"莘建路776号";
    
    Bank *bank3 = [[Bank alloc] init];
    bank3.lat = 31.20;
    bank3.lon = 120.00;
    bank3.title = @"招商银行(沪闵路)";
    bank3.subtitle = @"沪闵路776号";
    
//    根据银行id，经纬度获取银行列表
//    （getBanksByGPS(String，double，double)） 距离当前的距离
//fahterBank.id Lat Log
    
    self.locationArrs = [NSMutableArray arrayWithObjects:bank1,bank2,bank3, nil];
    [self reloadData];
    
    //获取附近银行信息
    [Bank getBanksInfo:nil WithBlock:^(NSArray *arr) {
//        self.locationArrs= [NSMutableArray arrayWithArray:arr];
//        [self reloadData];

    }];

}

//判断是否联网
- (void)isNetWork{
    if (![AppDelegate isNetworkReachable]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"网络异常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
}

#pragma mark--
#pragma mark--ReloadData---MapVC///MapListVC
-(void)reloadData{

    
    if (viewTag==TableViewTag) {
        self.mapListVC.locationArrs=_locationArrs;
        [self.mapListVC.tableView reloadData];

    }else{
        self.mapVC.locationArrs=_locationArrs;
        [self.mapVC showAnnotaionViews];
        [self.mapVC showCalloutAnnotaionViews];
    }
}

#pragma mark--
#pragma mark--Navigation-Method
//返回上一层
- (void)backToLastVC{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//跳转列表
- (void)turnToListVC{
    //此处应使用  把mapviewController和listviewController作为当前控制器的子控制器
    
    UIViewController *fromVC,*toVC;
    UIViewAnimationOptions options;
    
    if (viewTag==MapTag) {
        viewTag=TableViewTag;
        
        options = UIViewAnimationOptionTransitionFlipFromLeft;
        
        fromVC = mapVC;
        toVC = mapListVC;
        
        self.navigationItem.rightBarButtonItem = [Helper rightBarButtonItem:self];
        
    }else{
        viewTag=MapTag;

        options = UIViewAnimationOptionTransitionFlipFromRight;

        fromVC = mapListVC;
        toVC = mapVC;
        
        self.navigationItem.rightBarButtonItem = [Helper rightBarButtonItemListIcon:self];
    }
    //翻转动画
    [self transitionFromViewController:fromVC toViewController:toVC duration:0.4f options:options animations:nil completion:nil];
//    //加载数据
    [self reloadData];
   
}

#pragma mark--
#pragma mark--ToolBar--Method
//点击地区
-(void)selectAreas{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [self addChildViewController:pickerViewController];
    [self.view addSubview:pickerViewController.view];
    [self.view bringSubviewToFront:pickerViewController.view];
    [pickerViewController.view setFrame:CGRectMake(0, self.view.frame.size.height-215, self.view.bounds.size.width, 215)];
    [UIView commitAnimations];
    
    //刷新地图数据
    //列表界面刷新界面数据，当前定位地区银行
    //    •	根据区域id和银行id获取所有分行列表
    //    getBanksByArea(areaId,bankTypeId)
    //    self.locationArrs数据相应时更改
    //调用接口===传pickerViewController.county.countyId 和selectViewController界面的银行id
}

//点击定位自己
- (void)locationSelf{
    //刷新地图数据
    //列表界面刷新界面数据，当前定位地区银行
    
    //获取附近银行信息
    [Bank getBanksInfo:nil WithBlock:^(NSArray *arr) {
        //        self.locationArrs= [NSMutableArray arrayWithArray:arr];
        //        [self reloadData];
        
    }];
    
    if (viewTag==MapTag) {
        CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:self.mapVC._map.userLocation.coordinate.latitude longitude:self.mapVC._map.userLocation.location.coordinate.longitude];
        
        MKCoordinateSpan span ;
        span.latitudeDelta=0.5;
        span.longitudeDelta=0.5;
        MKCoordinateRegion region = {userLocation.coordinate, span};
        [self.mapVC._map setRegion:region];
    }else{
        //重新定位获得列表地点
        [self.mapVC.locationManager startUpdate];
        self.mapVC.locationManager.delegate=self.mapListVC;
    }
  
}

#pragma mark--
#pragma mark--PickerViewButton-dismissbtn--confirmBtn--Method
//区域取消按钮
- (void)dismissPickerView{
    [UIView animateWithDuration:0.3f animations:^{
        [pickerViewController.view setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 215+45)];
        
        [pickerViewController removeFromParentViewController];

    }];

}

//区域确定刷新按钮
- (void)confirmPickerView{
    
    NSLog(@"确定刷界面");
    [self dismissPickerView];
        
    //pickerViewController.cityId 传个接口获取当前银行信息
    //===========刷新界面假数据================
    Bank *bank1 = [[Bank alloc] init];
    bank1.lat = 32.00;
    bank1.lon = 120.00;
    bank1.title = @"工商银行（莘庄）";
    bank1.subtitle = @"莘松路985号";
    
    Bank *bank2 = [[Bank alloc] init];
    bank2.lat = 32.90;
    bank2.lon = 121.00;
    bank2.title = @"工商银行(闵行支行)";
    bank2.subtitle = @"莘建路776号";
    
    Bank *bank3 = [[Bank alloc] init];
    bank3.lat = 31.20;
    bank3.lon = 120.00;
    bank3.title = @"工商银行(沪闵路)";
    bank3.subtitle = @"沪闵路776号";
    
    //调接口
    //传county_id获取  self.locationArrs
    self.locationArrs=[NSMutableArray arrayWithObjects:bank1,bank2,bank3, nil];    
    
    
    //选择了地区，更改list的地区
    [mapListVC.bankTitleLabel setText:pickerViewController.county.countryName];
    
    //重新加载数据
    [self reloadData];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
