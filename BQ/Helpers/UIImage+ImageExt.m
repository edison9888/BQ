//
//  UIImage+ImageExt.m
//  HtmlText
//
//  Created by Zoe on 13-5-23.
//  Copyright (c) 2013年 Zoe. All rights reserved.
//

#import "UIImage+ImageExt.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (ImageExt)

+ (void)beginImageContextWithSize:(CGSize)size
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        if ([[UIScreen mainScreen] scale] == 2.0)
        {
            UIGraphicsBeginImageContextWithOptions(size, YES, 2.0);
        }
        else
        {
            UIGraphicsBeginImageContext(size);
        }
    }
    else
    {
        UIGraphicsBeginImageContext(size);
    }
}

+ (void)endImageContext
{
    UIGraphicsEndImageContext();
}

+ (UIImage*)imageFromView:(UIView*)view
{
    [self beginImageContextWithSize:[view bounds].size];
    BOOL hidden = [view isHidden];
    [view setHidden:NO];
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self endImageContext];
    [view setHidden:hidden];
    return image;
}

@end
