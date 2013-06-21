//
//  LocationManager.m
//  BQ
//
//  Created by Zoe on 13-4-8.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "LocationManager.h"
#import "DatabaseOperations.h"
#import <CoreLocation/CoreLocation.h>
#import "MapViewController.h"
#import "SVProgressHUD.h"
@implementation LocationManager

- (id)init{

    self = [super init];
    if (self) {
        
        locationManager  = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter=1000;
        locationManager.pausesLocationUpdatesAutomatically=NO;
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
     CLGeocoder *geocoder = [[CLGeocoder alloc]init];
     [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
    
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
//               NSString *cityName = placemark.administrativeArea;
               NSDictionary *dictionary = placemark.addressDictionary;
               NSArray *arr = [dictionary allKeys];
               for (int i=0; i<arr.count; i++) {
                   NSString *key = [arr objectAtIndex:i];
                   if (debug) {
                         NSLog(@"placemarks---%@---%@",key,[placemark.addressDictionary objectForKey:[NSString stringWithFormat:@"%@",key]]);
                   }
                }
    
            //根据省检索Proid
            [DatabaseOperations selectProIdFromDatabase:[placemark.addressDictionary objectForKey:@"State"]];
    
            //区
            [[NSUserDefaults standardUserDefaults] setValue:[placemark.addressDictionary objectForKey:@"SubLocality"] forKey:@"SubLocality"];
            //经纬度
            [[NSUserDefaults standardUserDefaults] setDouble:placemark.region.center.latitude forKey:@"Lat"];
            [[NSUserDefaults standardUserDefaults] setDouble:placemark.region.center.longitude forKey:@"Log"];
    
            if ([self.roloadDelegate respondsToSelector:@selector(locationManagerRoloadDataAddtionToLatAndLogDelegage)]){
                [self.roloadDelegate locationManagerRoloadDataAddtionToLatAndLogDelegage];
            }
         
            //获取新位置信息
            if ([self.delegate respondsToSelector:@selector(locationReceivedFromLocationManagerDelegate:)]) {
                [self.delegate locationReceivedFromLocationManagerDelegate:[placemark.addressDictionary objectForKey:@"SubLocality"]];
            }
    
        }];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"更新失败");
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"firstFailed"] isEqualToString:@"1"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请打开定位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }

    [SVProgressHUD dismissWithError:@"定位失败"];
    [self stopUpdate];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"1"] forKey:@"firstFailed"];

}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex) {
//        NSURL *prefsURL = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
//        
//        if ([[UIApplication sharedApplication] canOpenURL:prefsURL]) {
//            [[UIApplication sharedApplication] openURL:prefsURL];
//        } else {
//            NSLog(@"手动打开定位");
//        }
//    }
//}





@end
