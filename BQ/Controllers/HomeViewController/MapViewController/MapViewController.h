//
//  MapViewController.h
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Bank.h"
#import "PickerView.h"

#import "HomeViewController.h"

@interface MapViewController : UIViewController<MKMapViewDelegate>
{
    NSMutableArray *annotionViews;
    PickerView *pickerViewController;
}

@property(nonatomic,strong) MKMapView * map;
@property(nonatomic,strong) NSMutableArray *locationArrs;
@property(nonatomic,weak) HomeViewController *homeVC;

@end
