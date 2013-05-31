//
//  Bundle.m
//  BQ
//
//  Created by Zoe on 13-5-31.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "Bundle.h"

@implementation Bundle

+ (NSString *)docoumentRootPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];   // 保存文件的名称
    return filePath;
}

@end
