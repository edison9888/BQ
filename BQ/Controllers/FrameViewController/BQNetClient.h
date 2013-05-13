//
//  BQNetClient.h
//  BQ
//
//  Created by Zoe on 13-4-11.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface BQNetClient : AFHTTPClient

+ (BQNetClient *)sharedClient;

+(BQNetClient*) sharedThreadClient;

+(NSString*)sharedBaseURL;
//+(NSDictionary *)nsdataTurnToNSDictionary:(id)responseObject;

@end
