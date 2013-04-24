//
//  Business.h
//  BQ
//
//  Created by Zoe on 13-4-24.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject



@property(nonatomic,strong) NSString *parentId;//父类id
@property(nonatomic,strong) NSString *serviceId;//业务id
@property(nonatomic,strong) NSString *serviceName;//业务名称
@property(nonatomic,strong) NSString *serviceTag;//业务标识
@property(nonatomic,strong) NSString *startLevel;//开始level

-(id)initWithItem:(NSDictionary *)dic;

//获取父类业务
+ (void)getfatherService:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block;

//根据父类类型获取子类业务
+ (void)getChildService:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block;


@end
