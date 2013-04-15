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


@interface MapShowViewController : UIViewController<MKMapViewDelegate>
{
    @private
    NSMutableArray *annotionViews;
}

@property(nonatomic,strong) NSMutableArray *locationArrs;//地图显示数据数组 Bank数组
@property(nonatomic,weak) HomeViewController *homeVC;
@property(nonatomic,strong)MKMapView *_map;

@property(nonatomic,strong)LocationManager *locationManager;

- (void)showAnnotaionViews;
@end
