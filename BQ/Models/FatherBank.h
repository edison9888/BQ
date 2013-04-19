//
//  FatherBank.h
//  BQ
//
//  Created by Zoe on 13-4-15.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FatherBank : NSObject

@property(nonatomic,strong) NSString *bankTypeId;
@property(nonatomic,strong) NSString *bankTypeName;
@property(nonatomic,strong) NSString *parentId;

- (id)initWithItem:(id)dic;

+ (void)getAllBankInfo:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block;

@end
