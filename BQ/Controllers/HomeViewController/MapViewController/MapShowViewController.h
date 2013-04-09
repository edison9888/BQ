//
//  MapShowViewController.h
//  BQ
//
//  Created by Zoe on 13-4-9.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

#import "HomeViewController.h"

#import "Bank.h"

#define NavigationHeight 44
#define TabBarHeight 49

@interface MapShowViewController : UIViewController<MKMapViewDelegate>
{
    @private
    NSMutableArray *annotionViews;
    LocationManager *locationManager;
}

@property(nonatomic,strong) NSMutableArray *locationArrs;//地图显示数据数组 Bank数组
@property(nonatomic,weak) HomeViewController *homeVC;
@property(nonatomic,strong)MKMapView *_map;

- (void)showAnnotaionViews;
@end
