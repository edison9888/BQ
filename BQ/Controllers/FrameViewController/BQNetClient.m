//
//  BQNetClient.m
//  BQ
//
//  Created by Zoe on 13-4-11.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "BQNetClient.h"

#define BaseUrlString @"http://192.168.1.38:8080/bank/ver1/"

@implementation BQNetClient

+ (BQNetClient *)sharedClient{

    static BQNetClient *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareClient = [[BQNetClient alloc] initWithBaseURL:[NSURL URLWithString:BaseUrlString]];
        _shareClient.parameterEncoding=AFJSONParameterEncoding;
        
        
    });
    
    return _shareClient;
}

+(NSDictionary *)nsdataTurnToNSDictionary:(id)responseObject{

    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
    
    return dic;
    NSLog(@"jsonObjects===%@,error===%@",dic,error);

}

@end
