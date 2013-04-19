//
//  CustomAnnotationView.h
//  BQ
//
//  Created by Zoe on 13-4-17.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MyAnnotation.h"


@protocol  CustomAnnotationViewDelegate<NSObject>

- (void)didSelectAnnotationViewDelegate:(MyAnnotation*)ann;

@end

@interface CustomAnnotationView : MKPinAnnotationView

@property(nonatomic,weak) id<CustomAnnotationViewDelegate> delegate;
@property(nonatomic,strong) MyAnnotation *myAnnotaion;
@property (nonatomic,strong) UIView *contentView;

@end
