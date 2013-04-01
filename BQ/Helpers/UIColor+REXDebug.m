//
//  UIColor+REXDebug.m
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "UIColor+REXDebug.h"

@implementation UIColor (REXDebug)
+(UIColor *) randomColor{
    CGFloat red = (arc4random()%255/255.0);
    CGFloat green = (arc4random()%255/255.0);
    CGFloat blue = (arc4random()%255/255.0);
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
@end
