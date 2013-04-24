//
//  Number.m
//  BQ
//
//  Created by Zoe on 13-4-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "Number.h"
#import "BQNetClient.h"

@implementation Number

- (id)initWithItem:(NSDictionary *)dic{

    if (self=[super init]) {
        
        _beforeCount=[dic objectForKey:@"beforeCount"];
        _myNum=[dic objectForKey:@"myNum"];
        _numDate=[dic objectForKey:@"numDate"];
        _numStatus=[[dic objectForKey:@"numStatus"] intValue];
        _numTag=[dic objectForKey:@"numTag"];
        _presentNumber = [dic objectForKey:@"nowNum"];//目前叫号
        
        _bankId=[dic objectForKey:@"bankId"];
        _bankName=[dic objectForKey:@"bankName"];
        _serviceId=[dic objectForKey:@"serviceId"];
        _serviceName=[dic objectForKey:@"serviceName"];
        _serParentId=[dic objectForKey:@"serParentId"];
        
    }
    return self;
}

//领取票号==生成我的号码
+ (void)getBankNumberInfo:(NSDictionary *)parameters WithBlock:(void (^)(Number *num))block{
    [[BQNetClient sharedClient] getPath:@"number/getNum" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [BQNetClient nsdataTurnToNSDictionary:responseObject];
        
        NSDictionary *numDic = [dic objectForKey:@"NumberInfo"];
        NSLog(@"response%@",numDic);

        Number *num;
        if ([numDic isKindOfClass:[NSDictionary class]]) {
            num = [[Number alloc] initWithItem:numDic];
        }
        
        if (block)
            block(num);

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

//刷新我的排号
+ (void)refreshBankNumbers:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block{

    [[BQNetClient sharedClient]getPath:@"number/getAllNum" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *numArr =[NSMutableArray array];
        NSDictionary *dic = [BQNetClient nsdataTurnToNSDictionary:responseObject];
        
        NSArray *jsonArr = [dic objectForKey:@"NumberInfo"];
        NSLog(@"response%@",dic);
        
        if ([jsonArr isKindOfClass:[NSDictionary class]]) {
            Number *num = [[Number alloc] initWithItem:(NSDictionary *)jsonArr];
            [numArr addObject:num];
        }else{
            for ( int i=0; i<jsonArr.count; i++) {
                
                NSDictionary *bankDic = [jsonArr objectAtIndex:i];
                Number *num = [[Number alloc] initWithItem:bankDic];
                [numArr addObject:num];
            }
        }
        if (block)
            block(numArr);        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];

}

@end
