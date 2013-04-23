//
//  CustomAnnotationView.h
//  BQ
//
//  Created by Zoe on 13-4-17.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "CalloutMapAnnotation.h"
@class MapShowViewController;

@protocol  CustomAnnotationViewDelegate<NSObject>

- (void)didSelectAnnotationViewDelegate:(CalloutMapAnnotation *)_index;

@end

@interface CustomAnnotationView : MKPinAnnotationView
{

}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier clickVC:(MapShowViewController*)mapShowVC;

@property(nonatomic,weak) id<CustomAnnotationViewDelegate> delegate;
@property(nonatomic,strong) CalloutMapAnnotation *myAnnotaion;
@property (nonatomic,strong) UIView *contentView;
@end
