//
//  NSString+Base64.h
//  BQ
//
//  Created by Zoe on 13-5-29.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+(NSString *)encode:(NSData *)data;
+(NSData *)decode:(NSString *)data;
+(int)char2Int:(char)c;

@end
