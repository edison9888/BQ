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

#define BaseUrlString @"http://192.168.0.200:8080/bank/ver1/"

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



- (void)setAuthorizationHeaderWithToken:(NSString *)token {
    [self setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", token]];
}




-(void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    
    NSMutableDictionary     *result = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString                 *key;
    
    for ( key in parameters ) {
        [result setObject:[parameters objectForKey:key] forKey:[key lowercaseString]];
    }
    
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:result];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self enqueueHTTPRequestOperation:operation];
}



-(void) deletePath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    
    NSMutableDictionary     *result = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString                 *key;
    
    for ( key in parameters ) {
        [result setObject:[parameters objectForKey:key] forKey:[key lowercaseString]];
    }
    
    NSURLRequest *request = [self requestWithMethod:@"DELETE" path:path parameters:result];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self enqueueHTTPRequestOperation:operation];
    
}


@end
