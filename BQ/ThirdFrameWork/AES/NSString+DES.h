//
//  NSString+DES.h
//  BQ
//
//  Created by Zoe on 13-5-29.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DES)
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;

@end
