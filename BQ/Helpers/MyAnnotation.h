//
//  MyAnnotation.h
//  BQ
//
//  Created by Zoe on 13-4-7.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Bank.h"

@interface MyAnnotation : NSObject<MKAnnotation>


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic,strong) Bank *bank;

- (id)initWithTitle:(NSString *)title subTitle:(NSString *)subtitle andCoordinate:(CLLocationCoordinate2D)coordinate;


@end
