//
//  Number.h
//  BQ
//
//  Created by Zoe on 13-4-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Number : NSObject


@property(nonatomic,assign) NSInteger numberId;//报号id
@property(nonatomic,strong) NSString *bankName;//银行名称
@property(nonatomic,strong) NSString *bankNumber;//排队号码
@property(nonatomic,strong) NSString *business;//业务类型
@property(nonatomic,strong) NSString *presentNumber;//目前叫号
@property(nonatomic,assign) NSInteger peopleNumber;//人数
@property(nonatomic,strong) NSString *time;//时间

@end
