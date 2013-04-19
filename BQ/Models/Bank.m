//
//  Bank.m
//  BQ
//
//  Created by Zoe on 13-4-15.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "Bank.h"
#import "BQNetClient.h"

@implementation Bank

- (id)initWithItem:(NSDictionary *)dic{
    
    if (self=[super init]) {
//        _bankTypeId = [dic objectForKey:@"bankTypeId"];
//        _bankTypeName=[dic objectForKey:@"bankTypeName"];
//        _parentId = [dic objectForKey:@"parentId"];
        
        
    }
    return self;
}



+ (void)getBanksInfo:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block{
    
    [[BQNetClient sharedClient] getPath:@"/bankInfo/getList/f7250bc7-9f8d-11e2-b7ab-208984337244/200/198" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = [BQNetClient nsdataTurnToNSDictionary:responseObject];
        
        NSLog(@"response%@",dic);
        
        
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error.userInfo);
    }];
}

//根据区域或定位筛选银行
+ (void)selectAreaGetBanksInfo:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block{
    [[BQNetClient sharedClient] getPath:@"/bankInfo/getBank/3063219c-a28c-11e2-b03a-208984337244" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [BQNetClient nsdataTurnToNSDictionary:responseObject];
        
        NSLog(@"response%@",dic);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

@end
