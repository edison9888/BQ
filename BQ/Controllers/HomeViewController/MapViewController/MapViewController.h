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

#import <QuartzCore/QuartzCore.h>


#import "MapListViewController.h"
#import "MapShowViewController.h"
#import "FatherBank.h"
#import "LocationManager.h"
#import "RootViewController.h"

typedef enum {
    TableViewTag,
    MapTag,
} ViewTag;

@interface MapViewController : RootViewController<LocationManagerRoloadDataAddtionToLatAndLogDelegage>
{
    @private
    PickerView *pickerViewController;
    ViewTag viewTag;
        
    LocationManager *locationManager;
}

@property(nonatomic,strong) MapListViewController * mapListVC;
@property(nonatomic,strong) MapShowViewController * mapVC;


@property(nonatomic,weak) HomeViewController *homeVC;

@property(nonatomic,strong) NSMutableArray *locationArrs;//地图显示数据数组 Bank数组

@property(nonatomic,strong) FatherBank *fatherBank;

- (void)getDataFormApi;
@end
