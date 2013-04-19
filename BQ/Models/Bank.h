//
//  Bank.h
//  BQ
//
//  Created by Zoe on 13-4-15.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bank : NSObject


@property(nonatomic,assign) double lat;
@property(nonatomic,assign) double lon;

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *subtitle;

//根据当前经纬度获取附近银行
+ (void)getBanksInfo:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block;
//根据区域或定位筛选银行
+ (void)selectAreaGetBanksInfo:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block;

@end
