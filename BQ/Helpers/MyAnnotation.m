//
//  MyAnnotation.m
//  BQ
//
//  Created by Zoe on 13-4-7.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

//-(id)initWithTitle:(NSString *)title subTitle:(NSString *)subtitle andCoordinate:(CLLocationCoordinate2D)coordinate{
//    self  =[super init];
//    
//    if (self) {
//        _title = title;
//        _subtitle = subtitle;
//        _coordinate = coordinate;
//        _isCallOut=NO;
//    }
//    return self;
//}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate{
    self  =[super init];
    if (self) {
        _coordinate = coordinate;
    }

    return self;
}
@end
