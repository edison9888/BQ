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

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier clickVC:(MapShowViewController*)mapShowVC
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _myAnnotaion = annotation;
        self.backgroundColor = [UIColor clearColor];
        
        self.centerOffset = CGPointMake(-50, -45);
        self.frame = CGRectMake(0, 0, 165, 50);
        self.canShowCallout = NO;
        
        self.userInteractionEnabled=YES;

        UIButton *contentViewBg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        contentViewBg.userInteractionEnabled=YES;
        contentViewBg.backgroundColor   = [UIColor clearColor];
        [contentViewBg setBackgroundImage:[UIImage imageNamed:@"notePin"]forState:UIControlStateNormal];
        [contentViewBg addTarget:self action:@selector(turnToGetTicket) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:contentViewBg];
        self.contentView = contentViewBg;

        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 136, 17)];
        [titleLabel setText:_myAnnotaion.title];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor=[UIColor whiteColor];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:titleLabel];
        
        UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.size.height+titleLabel.frame.origin.y, titleLabel.frame.size.width, 14)];
        [subtitleLabel setText:_myAnnotaion.subtitle];
        subtitleLabel.font = [UIFont systemFontOfSize:13];
        [subtitleLabel setBackgroundColor:[UIColor clearColor]];
        subtitleLabel.textColor=[UIColor whiteColor];
        [self.contentView addSubview:subtitleLabel];
        
    }
    return self;
}

- (void)turnToGetTicket{
    if ([self.delegate respondsToSelector:@selector(didSelectAnnotationViewDelegate:)]) {
        [self.delegate didSelectAnnotationViewDelegate:_myAnnotaion];
    }
    
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
