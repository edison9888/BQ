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

#define SpanDelta 0.1

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapVC,mapListVC;

- (id)init
{
    self = [super init];
    if (self) {
        
        _locationArrs=[NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
//    self.navigationItem.leftBarButtonItem = [Helper leftBarButtonItem:self];
    
    self.navigationItem.rightBarButtonItem = [Helper rightBarButtonItem:self];
    
    self.title = _fatherBank.bankTypeName;
    
    locationManager = [[LocationManager alloc] init];
    locationManager.roloadDelegate=self;
    [locationManager startUpdate];
    
    //工具条
    ToolBar *toolBar = [[ToolBar alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-TabBarHeight-NavigationHeight, self.view.frame.size.width, TabBarHeight) viewController:self];
    [self.view addSubview:toolBar];
    
    //地图
    self.mapVC = [[MapShowViewController alloc] init];
    mapVC.view.frame=CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height-TabBarHeight-TabBarHeight);
    self.mapVC.homeVC=self.homeVC;
    self.mapVC.locationManager=locationManager;
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
    [self.view addSubview:pickerViewController.view];
    [self.view bringSubviewToFront:pickerViewController.view];

    //判断是否联网
    //[self isNetWork];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    //调用接口
//    [self getDataFormApi];
   
}

- (void)getDataFormApi{
    NSString *fatherBankId = [NSString stringWithFormat:@"%@",self.fatherBank.bankTypeId];

    NSString *latStr = [NSString stringWithFormat:@"%f",Lat];
    NSString *logStr = [NSString stringWithFormat:@"%f",Log];
    
    if ([[NSString stringWithFormat:@"%f",Lat] isEqualToString:@"0.000000"] && [[NSString stringWithFormat:@"%f",Log] isEqualToString:@"0.000000"]) {
//        latStr=@"31.230000";
//        logStr=@"121.000000";
        NSLog(@"没定位");
        return;
    }

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:fatherBankId,@"id",latStr,@"lat",logStr,@"ing", nil];
    
    //获取附近银行信息
    [Bank getBanksInfo:dic WithBlock:^(NSArray *arr) {
        
        self.locationArrs= [NSMutableArray arrayWithArray:arr];
        [self reloadData];
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

//#pragma mark--
//#pragma mark--Navigation-Method
////返回上一层
//- (void)backToLastVC{
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}

//跳转列表
//此处应使用  把mapviewController和listviewController作为当前控制器的子控制器

- (void)turnToListVC{
    //隐藏pickerView
    [self dismissWithNoAnimate];

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
}

//点击定位自己
- (void)locationSelf{
    //列表界面刷新界面数据，当前定位地区银行    
    if (viewTag==MapTag) {
        CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:self.mapVC._map.userLocation.coordinate.latitude longitude:self.mapVC._map.userLocation.location.coordinate.longitude];
        
        MKCoordinateSpan span ;
        span.latitudeDelta=SpanDelta;
        span.longitudeDelta=SpanDelta;
        MKCoordinateRegion region = {userLocation.coordinate, span};
        [self.mapVC._map setRegion:region];
        
        
        //刷新数据
        [self getDataFormApi];
        
    }else{
        //重新定位获得列表地点  定位回调中调用接口
        [self.mapVC.locationManager startUpdate];
        self.mapVC.locationManager.delegate=self.mapListVC;
    }
}

#pragma mark--
#pragma mark--LocationManagerDelegate
-(void)locationManagerRoloadDataAddtionToLatAndLogDelegage{
    
    [self getDataFormApi];
}

#pragma mark--
#pragma mark--PickerViewButton-dismissbtn--confirmBtn--Method
//区域取消按钮
- (void)dismissPickerView{
    [UIView animateWithDuration:0.3f animations:^{
        [self dismissWithNoAnimate];
    }];
}

//无动画消失 pickerView
- (void)dismissWithNoAnimate{

    [pickerViewController.view setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 215+45)];
    [pickerViewController removeFromParentViewController];

}

//区域确定刷新按钮
- (void)confirmPickerView{
//    NSLog(@"确定刷界面");
    [self dismissPickerView];
    
    //pickview默认状态的county信息获取
    if (!pickerViewController.isSelectPV) {
        pickerViewController.county = [pickerViewController.pickerArrs objectAtIndex:SelectComponent];
    }

    //选择了地区，更改list的地区
    [mapListVC.bankTitleLabel setText:pickerViewController.county.countryName];
    
    //调接口加载数据
    [self accordingToAreaGetData];
}

//调用接口===传pickerViewController.county.countyId 和selectViewController界面的银行id
-(void)accordingToAreaGetData{
    
    NSString *areaIdStr = [NSString stringWithFormat:@"%d",pickerViewController.county.countyId];
    NSString *bankIdStr =_fatherBank.bankTypeId;
    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"100108",@"areaId",@"f7250bc7-9f8d-11e2-b7ab-208984337244",@"bankId", nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:areaIdStr,@"areaId",bankIdStr,@"bankId", nil];

    [Bank selectAreaGetBanksInfo:dic WithBlock:^(NSArray *arr) {
        
        self.locationArrs=(NSMutableArray *)arr;
        [self reloadData];
    }];
}

#pragma mark--
#pragma mark--release memory
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    pickerViewController=nil;    
    locationManager=nil;
    
    mapListVC=nil;
    mapVC=nil;
    _homeVC=nil;
    _locationArrs=nil;//地图显示数
    _fatherBank=nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
