//
//  Form.h
//  BQ
//
//  Created by Zoe on 13-5-22.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Form : NSObject

@property(nonatomic,strong) NSString *nameStr;
@property(nonatomic,strong) NSString *html;//表单html
@property(nonatomic,strong) NSString *htmlId;//表单id


+(void)getPersonalForm:(NSDictionary *)parameters  WithBlock:(void (^)(NSData *data))block;

+(void)sendPersonalInfo:(NSDictionary *)parameters  WithBlock:(void (^)())block;

@end
