//
//  LocationManager.m
//  BQ
//
//  Created by Zoe on 13-4-8.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

- (id)init{

    self = [super init];
    if (self) {
        
        locationManager  = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter=1000;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
    }
    return self;
}

- (void)startUpdate{
    [locationManager startUpdatingLocation];
}

- (void)stopUpdate{
    [locationManager stopUpdatingLocation];

}

#pragma mark--
#pragma mark--LocationManagerDelegate
//获得位置信息
-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation fromLocation: (CLLocation *)oldLocation
{
    NSTimeInterval howRecent = [newLocation.timestamp timeIntervalSinceNow];
    if(howRecent < -10) return; //离上次更新的时间少于10秒
        if(newLocation.horizontalAccuracy > 100) return; //精度> 100米
    //经度和纬度
    double lat = newLocation.coordinate.latitude;
    double lon = newLocation.coordinate.longitude;
    
    NSLog(@"%f,%f",lat,lon);
    
    //获取新位置信息
    if ([self.delegate respondsToSelector:@selector(locationReceivedFromLocationManagerDelegate:)]) {
        [self.delegate locationReceivedFromLocationManagerDelegate:newLocation];
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"placemarks%@",placemarks);
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    NSLog(@"locations%@",locations);
    
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    NSLog(@"更新失败");
    [self stopUpdate];
}

////获得方向信息（比如往南走）
//-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
//{
//    //获得方向
//    CLLocationDirection heading = newHeading .trueHeading;
//}


@end
