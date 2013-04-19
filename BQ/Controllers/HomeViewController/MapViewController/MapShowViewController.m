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
@synthesize _map,locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        annotionViews = [NSMutableArray array];
        calloutAnnotationViews = [NSMutableArray array];
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

- (void)showCallOutAnnotationOnMapView:(Bank *)bank{
    CalloutMapAnnotation *calloutMapAnnotion = [[CalloutMapAnnotation alloc] initWithLatitude:bank.lat andLongitude:bank.lon title:bank.title subTitle:bank.subtitle];
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
    
    if (annotionViews.count!=0) {
        [_map removeAnnotations:annotionViews];
    }
    
    for (int i=0; i<self.locationArrs.count; i++) {
        [self showAnnotationOnMapView:[self.locationArrs objectAtIndex:i]];
    }

    [_map addAnnotations:annotionViews];
}


//显示callout==annotationViews
- (void)showCalloutAnnotaionViews{
    
    if (calloutAnnotationViews.count!=0) {
        [_map removeAnnotations:calloutAnnotationViews];
    }
    
    for (int i=0; i<self.locationArrs.count; i++) {
        [self showCallOutAnnotationOnMapView:[self.locationArrs objectAtIndex:i]];
    }
    
    [_map addAnnotations:calloutAnnotationViews];
}

#pragma mark
#pragma mark--MapViewDelegate
/*
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    CustomAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation)
    {
//        static NSString *defaultPinID = @"pin";
//        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
//        if ( pinView == nil )
//            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
//        pinView.pinColor = MKPinAnnotationColorPurple;
//        pinView.canShowCallout = YES;
//        pinView.animatesDrop = YES;
//        
//        UIButton *accessoryView =[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [accessoryView setFrame:CGRectMake(0, 0, 30,30)];
//        pinView.rightCalloutAccessoryView=accessoryView;
        
        
        static NSString *defaultPinID = @"pin";
        pinView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        pinView.delegate = self;
        pinView.pinColor = MKPinAnnotationColorPurple;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
        
        UIButton *annotationViewBg = [UIButton buttonWithType:UIButtonTypeCustom];
        [annotationViewBg setBackgroundColor:[UIColor yellowColor]];
        annotationViewBg.frame = CGRectMake(0, 0, 20, 20);
        [annotationViewBg addTarget:self action:@selector(selectAnnotaionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [pinView.contentView addSubview:annotationViewBg];

//        UIButton *accessoryView =[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [accessoryView setFrame:CGRectMake(0, 0, 30,30)];
//        pinView.rightCalloutAccessoryView=accessoryView;
        
    }
    else
        [mapView.userLocation setTitle:@"I am here"];
    
    return pinView;
    
}*/

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[CalloutMapAnnotation class]]) {
        
        CalloutMapAnnotation *calloutMapAnnotation = annotation;
        
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
            if (!annotationView) {
                annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"];
            
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, annotationView.bounds.size.width, 20)];
                [titleLabel setText:calloutMapAnnotation.title];
                titleLabel.font = [UIFont systemFontOfSize:15];
                [annotationView.contentView addSubview:titleLabel];
                
                UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.frame.size.height, titleLabel.frame.size.width, titleLabel.frame.size.height)];
                [subtitleLabel setText:calloutMapAnnotation.subtitle];
                subtitleLabel.font = [UIFont systemFontOfSize:13];
                [annotationView.contentView addSubview:subtitleLabel];                
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

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	if ([view.annotation isKindOfClass:[MyAnnotation class]]) {

	}
    else{
        
        [_map deselectAnnotation:view.annotation animated:NO];
        NSLog(@"calloutannotion");
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    CalloutMapAnnotation *ann = view.annotation;
    
    if (view.annotation != _map.userLocation ) {
        _homeVC.bank = ann.bank;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


//- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
//    
//    MyAnnotation *ann = view.annotation;
//    
//    if (view.annotation != _map.userLocation ) {
//    
//        _homeVC.bank = ann.bank;
//        [self.navigationController popToRootViewControllerAnimated:YES];
//           
//     }
//
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
