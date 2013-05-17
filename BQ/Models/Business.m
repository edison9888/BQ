//
//  Business.m
//  BQ
//
//  Created by Zoe on 13-4-24.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "Business.h"
#import "BQNetClient.h"
#import "SVProgressHUD.h"

@implementation Business

-(id)initWithItem:(NSDictionary *)dic{

    if (self=[super init]) {
        
        
        _parentId = [dic objectForKey:@"parentId"];
        _serviceId = [dic objectForKey:@"serviceId"];
        _serviceName = [dic objectForKey:@"serviceName"];
        _serviceTag = [dic objectForKey:@"serviceTag"];
        _startLevel=[dic objectForKey:@"startLevel"];
        
    }
    return self;
}

//获取父类业务
+ (void)getfatherService:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block{
    [SVProgressHUD show];

    [[BQNetClient sharedClient] getPath:@"service/getList" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSMutableArray *businessArr = [NSMutableArray array];
        
        NSDictionary *dic = responseObject;

        NSArray *jsonArr = [dic objectForKey:@"serviceType"];
        NSLog(@"father===responseObject%@",dic);

        if ([jsonArr isKindOfClass:[NSDictionary class]]) {
            Business *business = [[Business alloc] initWithItem:(NSDictionary *)jsonArr];
            [businessArr addObject:business];
        }else if([jsonArr isKindOfClass:[NSArray class]]){
        
            for ( int i=0; i<jsonArr.count; i++) {
                NSDictionary *bankDic = [jsonArr objectAtIndex:i];
                Business *business = [[Business alloc] initWithItem:bankDic];
                [businessArr addObject:business];
            }        
        }
        
        if (block){
//            NSLog(@"fatherArr%@",businessArr);
            block(businessArr);
        }
        
        [SVProgressHUD dismiss];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedRecoverySuggestion);
    }];
}

//根据父类类型获取子类业务
+ (void)getChildService:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block{
    [SVProgressHUD show];

    [[BQNetClient sharedClient] getPath:@"service/getChildList" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *businessArr = [NSMutableArray array];
        
        NSDictionary *dic = responseObject;

        NSArray *jsonArr = [dic objectForKey:@"serviceType"];
//        NSLog(@"getChildServiceFromDataresponseObject%@",jsonArr);
        
        if ([jsonArr isKindOfClass:[NSDictionary class]]) {
            Business *business = [[Business alloc] initWithItem:(NSDictionary *)jsonArr];
            
            [businessArr addObject:business];
        }else{
            
            for ( int i=0; i<jsonArr.count; i++) {
                NSDictionary *bankDic = [jsonArr objectAtIndex:i];
                Business *business = [[Business alloc] initWithItem:bankDic];
                [businessArr addObject:business];
            }
        }
        
        if (block)
            block(businessArr);
        
        [SVProgressHUD show];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedRecoverySuggestion);
    }];
}


@end
