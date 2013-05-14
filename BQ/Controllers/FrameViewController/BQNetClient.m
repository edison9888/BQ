//
//  BQNetClient.m
//  BQ
//
//  Created by Zoe on 13-4-11.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "BQNetClient.h"
#import "AFJSONRequestOperation.h"
#import "SVProgressHUD.h"

#define BaseUrlString @"http://192.168.1.200:8080/bank/ver1/"

@implementation BQNetClient

+(BQNetClient *)sharedClient{
    // [SVProgressHUD show];
    static BQNetClient *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareClient = [[BQNetClient alloc]initWithBaseURL:[NSURL URLWithString:BaseUrlString]];
    });
    return _shareClient;
}

+(BQNetClient *)sharedThreadClient{
    static BQNetClient *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareClient = [[BQNetClient alloc]initWithBaseURL:[NSURL URLWithString:BaseUrlString]];
    });

    return _shareClient;
}




-(id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if(!self){
        return nil;
    }
        
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
    [self setDefaultHeader:@"Accept" value:@"application/json"];

    return self;
}







@end
