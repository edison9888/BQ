//
//  MapShowViewController.m
//  BQ
//
//  Created by Zoe on 13-4-9.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MapShowViewController.h"

@interface MapShowViewController ()

@end

@implementation MapShowViewController
@synthesize _map;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        annotionViews = [NSMutableArray array];
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

    
    locationManager = [[LocationManager alloc] init];
    //    locationManager.delegate=self;
    [locationManager startUpdate];
    
       
    [self showAnnotaionViews];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [locationManager stopUpdate];
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
    [_map removeAnnotations:annotionViews];
    
    for (int i=0; i<self.locationArrs.count; i++) {
        [self showAnnotationOnMapView:[self.locationArrs objectAtIndex:i]];
    }
    [_map addAnnotations:annotionViews];
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
