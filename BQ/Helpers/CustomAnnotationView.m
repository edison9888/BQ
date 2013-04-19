//
//  CustomAnnotationView.m
//  BQ
//
//  Created by Zoe on 13-4-17.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "CustomAnnotationView.h"
#import <QuartzCore/QuartzCore.h>
#define  Arror_height 15

@implementation CustomAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        _myAnnotaion = annotation;
        self.backgroundColor = [UIColor blueColor];
        
        self.centerOffset = CGPointMake(-25, -45);
        self.frame = CGRectMake(0, 0, 100, 50);
        self.canShowCallout = NO;

        UIView *contentViewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        contentViewBg.backgroundColor   = [UIColor clearColor];
        [self addSubview:contentViewBg];
        self.contentView = contentViewBg;

        UIButton *annotationViewBg = [UIButton buttonWithType:UIButtonTypeCustom];
        [annotationViewBg setBackgroundColor:[UIColor yellowColor]];
        annotationViewBg.frame = CGRectMake(0, 0, 20, 20);
        [annotationViewBg addTarget:self action:@selector(selectAnnotaionBtn:) forControlEvents:UIControlEventTouchUpInside];
      //  [self.contentView addSubview:annotationViewBg];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, annotationViewBg.frame.size.width, annotationViewBg.frame.size.height/2)];
        titleLabel.text = _myAnnotaion.title;
      //  [annotationViewBg addSubview:titleLabel];
        
        UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, annotationViewBg.frame.size.height/2, annotationViewBg.frame.size.width, annotationViewBg.frame.size.height/2)];
        subtitleLabel.text = _myAnnotaion.subtitle;
      //  [annotationViewBg addSubview:subtitleLabel];
        
           }
    return self;
}

//- (void)selectAnnotaionBtn:(id)sender{
//
//    if ([self.delegate respondsToSelector:@selector(didSelectAnnotationViewDelegate:)]) {
//        [self.delegate didSelectAnnotationViewDelegate:_myAnnotaion];
//    }
//
//}

-(void)drawInContext:(CGContextRef)context
{
	
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
  //  [self getDrawPath:context];
    CGContextFillPath(context);
    
    //    CGContextSetLineWidth(context, 1.0);
    //     CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    //    [self getDrawPath:context];
    //    CGContextStrokePath(context);
    
}
- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
	CGFloat radius = 6.0;
    
	CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect),
    // midy = CGRectGetMidY(rrect),
    maxy = CGRectGetMaxY(rrect)-Arror_height;
    CGContextMoveToPoint(context, midx+Arror_height, maxy);
    CGContextAddLineToPoint(context,midx, maxy+Arror_height);
    CGContextAddLineToPoint(context,midx-Arror_height, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

- (void)drawRect:(CGRect)rect
{
//	[self drawInContext:UIGraphicsGetCurrentContext()];
//    
//    self.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.layer.shadowOpacity = 1.0;
//    //  self.layer.shadowOffset = CGSizeMake(-5.0f, 5.0f);
//    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

@end
