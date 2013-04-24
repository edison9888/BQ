//
//  LocationManager.h
//  BQ
//
//  Created by Zoe on 13-4-8.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol LocationManagerDelegate <NSObject>

- (void)locationReceivedFromLocationManagerDelegate:(NSString *)SubLocalityName;

@end

@protocol LocationManagerRoloadDataAddtionToLatAndLogDelegage <NSObject>

- (void)locationManagerRoloadDataAddtionToLatAndLogDelegage;

@end


@interface LocationManager : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property(nonatomic,weak) id<LocationManagerDelegate> delegate;
@property(nonatomic,weak) id<LocationManagerRoloadDataAddtionToLatAndLogDelegage> roloadDelegate;
- (void)startUpdate;

- (void)stopUpdate;

@end
