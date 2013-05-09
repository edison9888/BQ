//
//  UIImage+UIImageName.m
//  BQ
//
//  Created by Zoe on 13-5-9.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "UIImage+UIImageName.h"

@implementation UIImage(UIImageName)

//+ (UIImage*)imageFromMainBundleFile:(NSString*)aFileName; {
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:aFileName ofType:@"png"];
//    UIImage *myImage = [UIImage imageWithContentsOfFile:path];
//    return myImage;
//}

+ (UIImage *) imageFromMainBundleFile:(NSString *)aFileName
{
	NSString *path = [[NSBundle mainBundle] pathForResource:aFileName ofType:@"png"];
     UIImage *myImage = [UIImage imageWithContentsOfFile:path];
	return myImage;
}
@end
