//
//  BQNetClient.m
//  BQ
//
//  Created by Zoe on 13-4-11.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "BQNetClient.h"

#define BaseUrlString @"198.162.1.1"

@implementation BQNetClient

- (BQNetClient *)sharedClient{

    static BQNetClient *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareClient = [[BQNetClient alloc]initWithBaseURL:[NSURL URLWithString:BaseUrlString]];
    });
    return _shareClient;
    
}



@end
