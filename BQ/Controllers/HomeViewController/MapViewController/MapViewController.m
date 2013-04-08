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
#import "MyAnnotation.h"
#import "Bank.h"
#import "HomeViewController.h"

#define TabBarHeight 44

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        annotionViews = [NSMutableArray array];
        

       //        self.locationArrs = [NSMutableArray arrayWithObjects:@[@"31.00",@"120.00"],@[@"32.00",@"121.00"],@[@"32.00",@"121.00"],@[@"31.90",@"121.90"],@[@"31.50",@"121.00"],@[@"32.50",@"121.90"],@[@"32.50",@"121.50"],@[@"31.50",@"121.00"], nil];
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
    _map.delegate=self;
    [self.view addSubview:_map];
    
    ToolBar *toolBar = [[ToolBar alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-TabBarHeight-TabBarHeight, self.view.frame.size.width, 44) viewController:self];
    [self.view addSubview:toolBar];
    
 
    pickerViewController  = [[PickerView alloc] init];
    [self addChildViewController:pickerViewController];
    [pickerViewController.view setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 215+45)];
//    pickerViewController.pickerArrs=xxx;获取pickerArr刷新数据
    [self.view addSubview:pickerViewController.view];
    
//    CLLocationManager *locationManager = [[CLLocationManager alloc] init];//创建位置管理器
//   // locationManager.delegate=self;//设置代理
//    locationManager.desiredAccuracy=kCLLocationAccuracyBest;//指定需要的精度级别
//    locationManager.distanceFilter=1000.0f;//设置距离筛选器
//    [locationManager startUpdatingLocation];//启动位置管理器
//    MKCoordinateRegion theRegion = { {0.0, 0.0 }, { 0.0, 0.0 } };
//    theRegion.center=[[locationManager location] coordinate];
//   
//    [_map setZoomEnabled:YES];
//    [_map setScrollEnabled:YES];
//    theRegion.span.longitudeDelta = 0.01f;
//    theRegion.span.latitudeDelta = 0.01f;
//    [_map setRegion:theRegion animated:YES];
 

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
    
    
    self.locationArrs = [NSMutableArray arrayWithObjects:bank1,bank2,bank3, nil];
    
    [self showAnnotaionViews];

}

#pragma mark--
#pragma mark--位置信息
//annotaion坐标
- (void)getAnnotationLocation:(Bank*)bank{
    MKCoordinateSpan span ;
    span.latitudeDelta=0.5;
    span.longitudeDelta=0.5;
    
	CLLocation *location = [[CLLocation alloc] initWithLatitude:bank.lat longitude:bank.lon];
    MKCoordinateRegion region = {location.coordinate, span};
    [_map setRegion:region];

}

//显示annotationView
- (void)showAnnotationOnMapView:(Bank*)bank{
    
    MyAnnotation *ann = [[MyAnnotation alloc] initWithTitle:bank.title subTitle:bank.subtitle andCoordinate:CLLocationCoordinate2DMake(bank.lat, bank.lon)];
    [self getAnnotationLocation:bank];
    ann.bank = bank;
    [annotionViews addObject:ann];
}

//显示annotationViews
- (void)showAnnotaionViews{

    for (int i=0; i<self.locationArrs.count; i++) {
        [self showAnnotationOnMapView:[self.locationArrs objectAtIndex:i]];
    }
    [_map addAnnotations:annotionViews];
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
    [self addChildViewController:pickerViewController];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [pickerViewController.view setFrame:CGRectMake(0, self.view.frame.size.height-215, self.view.bounds.size.width, 215)];
    [UIView commitAnimations];
}

//定位自己
- (void)locationSelf{
    
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:_map.userLocation.coordinate.latitude longitude:_map.userLocation.location.coordinate.longitude];
    
    MKCoordinateSpan span ;
    span.latitudeDelta=0.5;
    span.longitudeDelta=0.5;
    MKCoordinateRegion region = {userLocation.coordinate, span};
    [_map setRegion:region];

}

#pragma mark--
#pragma mark--PickerViewButton-dismissbtn--confirmBtn--Method
- (void)dismissPickerView{
    [UIView animateWithDuration:0.3f animations:^{
        [pickerViewController.view setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 215+45)];
        
        [pickerViewController removeFromParentViewController];

    }];

}

- (void)confirmPickerView{
    
    NSLog(@"确定刷界面");
    [self dismissPickerView];
    
    [_map removeAnnotations:annotionViews];
    
    //pickerViewController.cityId 传个接口获取当前银行信息
    
//    self.locationArrs = [NSMutableArray arrayWithObjects:bank1,bank2,bank3, nil];
//    
//    [self showAnnotaionViews];


}


#pragma mark
#pragma mark--MapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{

    MKPinAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation)
    {
        static NSString *defaultPinID = @"pin";
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        pinView.pinColor = MKPinAnnotationColorPurple;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
        
        UIButton *accessoryView =[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [accessoryView setFrame:CGRectMake(0, 0, 20,20)];
        pinView.rightCalloutAccessoryView=accessoryView;
    }
    else
        [mapView.userLocation setTitle:@"I am here"];
    
    return pinView;
    
}


- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
    MyAnnotation *ann = view.annotation;
    
    if (view.annotation != _map.userLocation) {
        
        _homeVC.bankNameLabel.text = ann.bank.title;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
