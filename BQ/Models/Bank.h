//
//  Bank.h
//  BQ
//
//  Created by Zoe on 13-4-7.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bank : NSObject


@property(nonatomic,assign) double lat;
@property(nonatomic,assign) double lon;

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *subtitle;
@end
