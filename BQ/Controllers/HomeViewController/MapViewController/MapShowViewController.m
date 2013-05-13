//
//  MapShowViewController.m
//  BQ
//
//  Created by Zoe on 13-4-9.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MapShowViewController.h"
#define SpanDelta 0.1

@interface MapShowViewController ()

@end

@implementation MapShowViewController
@synthesize locationManager;
@synthesize _map;


- (id)init
{
    self = [super init];
    if (self) {
        annotionViews = [NSMutableArray array];
        calloutAnnotationViews = [NSMutableArray array];
        locationArr =[NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _map = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height-TabBarHeight-NavigationHeight)];
    _map.showsUserLocation = YES;
    _map.delegate=self;
    [self.view addSubview:_map];

    //    locationManager.delegate=self;
    [locationManager startUpdate];
}

- (void)setViewFrame{
    self.view.frame=CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height-TabBarHeight-TabBarHeight);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

#pragma mark--
#pragma mark--位置信息
//annotaion坐标
- (void)getAnnotationLocation:(Bank*)bank{
    MKCoordinateSpan span ;
    span.latitudeDelta=SpanDelta;
    span.longitudeDelta=SpanDelta;
    
    CLLocation *location;
    if((bank.lat >= -90) && (bank.lat <= 90) && (bank.lon >= -180) && (bank.lon <= 180)){
        location = [[CLLocation alloc] initWithLatitude:bank.lat longitude:bank.lon];
        MKCoordinateRegion region = {location.coordinate, span};
        [_map setRegion:region];
    }
    else{
        NSLog(@"invalid region");
        return;
    }
    
    [locationArr addObject:location];
}

- (void)showCallOutAnnotationOnMapView:(Bank *)bank{
    CalloutMapAnnotation *calloutMapAnnotion = [[CalloutMapAnnotation alloc] initWithLatitude:bank.lat andLongitude:bank.lon title:bank.bankName subTitle:bank.address];
    [self getAnnotationLocation:bank];
    calloutMapAnnotion.bank =bank;
    [calloutAnnotationViews addObject:calloutMapAnnotion];
}

//显示annotationView
- (void)showAnnotationOnMapView:(Bank*)bank{
    
    MyAnnotation *ann = [[MyAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(bank.lat, bank.lon)];
    [self getAnnotationLocation:bank];
    ann.bank = bank;
    [annotionViews addObject:ann];
}

//显示annotationViews
- (void)showAnnotaionViews{
//    for (UIView * view in [_map subviews]) {
//        if ([view isKindOfClass:[MKAnnotationView class]] ){
//            [view removeFromSuperview];
//        }
//    }
    
    if (annotionViews.count!=0) {
        [_map removeAnnotations:annotionViews];
        [annotionViews removeAllObjects];
    }
    
    for (int i=0; i<self.locationArrs.count; i++) {
        [self showAnnotationOnMapView:[self.locationArrs objectAtIndex:i]];
    }

    [_map addAnnotations:annotionViews];
}


//显示callout==annotationViews
- (void)showCalloutAnnotaionViews{
//    for (UIView * view in [_map subviews]) {
//        if ([view isKindOfClass:[CustomAnnotationView class]]){
//            [view removeFromSuperview];
//        }
//    }
    
    if (calloutAnnotationViews.count!=0) {
        [_map removeAnnotations:calloutAnnotationViews];
        [calloutAnnotationViews removeAllObjects];
    }
    
    for (int i=0; i<self.locationArrs.count; i++) {
        [self showCallOutAnnotationOnMapView:[self.locationArrs objectAtIndex:i]];
    }
    
    [_map addAnnotations:calloutAnnotationViews];
    
    //地图居中显示
    [self center_map];
}

//地图居中显示
-(void)center_map
{    
    MKCoordinateRegion region;
    
    CLLocationDegrees maxLat = -90;
    CLLocationDegrees maxLon = -180;
    CLLocationDegrees minLat = 90;
    CLLocationDegrees minLon = 180;
    for (int idx = 0; idx < locationArr.count; idx++) {
        CLLocation* currentLocation = [locationArr objectAtIndex:idx];
        if (currentLocation.coordinate.latitude > maxLat) {
            maxLat = currentLocation.coordinate.latitude;
        }
        if (currentLocation.coordinate.latitude < minLat) {
            minLat = currentLocation.coordinate.latitude;
        }
        if (currentLocation.coordinate.longitude > maxLon) {
            maxLon = currentLocation.coordinate.longitude;
        }
        if (currentLocation.coordinate.longitude < minLon) {
            minLon = currentLocation.coordinate.longitude;
        }
        region.center.latitude = (maxLat + minLat) / 2;
        region.center.longitude = (maxLon + minLon) / 2;
        region.span.latitudeDelta = maxLat - minLat;
        region.span.longitudeDelta = maxLon - minLon;
        
        [_map setRegion:region animated:YES];
    }
}

#pragma mark
#pragma mark--MapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[CalloutMapAnnotation class]]) {
        
        CalloutMapAnnotation *calloutMapAnnotation = annotation;
        
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
            if (!annotationView) {
                annotationView = [[CustomAnnotationView alloc] initWithAnnotation:calloutMapAnnotation reuseIdentifier:@"CalloutView" clickVC:self];
                annotationView.delegate=self;
            }
        
            return annotationView;

        }else if ([annotation isKindOfClass:[MyAnnotation class]]) {
            
            MKPinAnnotationView *annotationView =(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
            
            if (!annotationView) {
                annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                               reuseIdentifier:@"CustomAnnotation"];
                annotationView.canShowCallout = NO;
                annotationView.animatesDrop=NO;
            }
            return annotationView;

        }
    return nil;
}

-(void)didSelectAnnotationViewDelegate:(CalloutMapAnnotation *)callAnn{
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.bank =callAnn.bank;
    [self.navigationController pushViewController:homeVC animated:YES];

}

#pragma mark--
#pragma mark--release memory
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    annotionViews=nil;
    calloutAnnotationViews=nil;
    locationArr=nil;

    _homeVC=nil;
    _map=nil;
    locationManager=nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
