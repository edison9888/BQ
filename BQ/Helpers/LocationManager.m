//
//  LocationManager.m
//  BQ
//
//  Created by Zoe on 13-4-8.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "LocationManager.h"
#import "DatabaseOperations.h"

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
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
//            NSString *cityName = placemark.administrativeArea;
 //           NSDictionary *dictionary = placemark.addressDictionary;
 //           NSArray *arr = [dictionary allKeys];
//            for (int i=0; i<arr.count; i++) {
//                NSString *key = [arr objectAtIndex:i];
//                NSLog(@"placemarks---%@---%@",key,[placemark.addressDictionary objectForKey:[NSString stringWithFormat:@"%@",key]]);
//            }
        
        //根据省检索Proid
        [DatabaseOperations selectProIdFromDatabase:[placemark.addressDictionary objectForKey:@"State"]];
        
        //区
        [[NSUserDefaults standardUserDefaults] setValue:[placemark.addressDictionary objectForKey:@"SubLocality"] forKey:@"SubLocality"];
        //经纬度
        [[NSUserDefaults standardUserDefaults] setDouble:placemark.location.coordinate.latitude forKey:@"Lat"];
        [[NSUserDefaults standardUserDefaults] setDouble:placemark.location.coordinate.latitude forKey:@"Log"];

        
        //获取新位置信息
        if ([self.delegate respondsToSelector:@selector(locationReceivedFromLocationManagerDelegate:)]) {
            [self.delegate locationReceivedFromLocationManagerDelegate:[placemark.addressDictionary objectForKey:@"SubLocality"]];
        }

    }];

}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    NSLog(@"更新失败");
    [self stopUpdate];
}



@end
