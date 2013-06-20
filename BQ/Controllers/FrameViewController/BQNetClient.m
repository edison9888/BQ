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

#define OutNetUrlString @"http://223.4.32.153:8080/bank/ver3/" //外网
#define BaseUrlString @"http://192.168.0.200:8080/bank/ver3/"  //内网

@implementation BQNetClient

+(BQNetClient *)sharedClient{
    // [SVProgressHUD show];
    static BQNetClient *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareClient = [[BQNetClient alloc]initWithBaseURL:[NSURL URLWithString:OutNetUrlString]];
    });
    return _shareClient;
}

+(BQNetClient *)sharedThreadClient{
    static BQNetClient *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareClient = [[BQNetClient alloc]initWithBaseURL:[NSURL URLWithString:OutNetUrlString]];
    });

    return _shareClient;
}

+(NSURLRequest *)getHtmlUrl{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@bankInfo/getform",OutNetUrlString]];
    
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    
    return request;
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
