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
        
        _address = [dic objectForKey:@"address"];
        _bankArea = [dic objectForKey:@"bankArea"];
        _bankCity=[dic objectForKey:@"bankCity"];
        _bankId= [dic objectForKey:@"bankId"];
        _bankName=[dic objectForKey:@"bankName"];
        _bankProvince=[dic objectForKey:@"bankProvince"];
        _bankTypeId=[dic objectForKey:@"bankTypeId"];
        _distance=[[dic objectForKey:@"distince"] floatValue];
        _lat=[[dic objectForKey:@"latitude"] doubleValue];
        _lon=[[dic objectForKey:@"longitude"] doubleValue];
        _phoneStr=[dic objectForKey:@"phone"];
        _bankTypeName=[dic objectForKey:@"bankTypeName"];
    }
    return self;
}

+ (void)getBanksInfo:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block{
    
    [[BQNetClient sharedClient] getPath:@"bankInfo/getList" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSMutableArray *bankArr = [NSMutableArray array];
        
            NSDictionary *dic = responseObject;

            NSArray *jsonArr = [dic objectForKey:@"bankInfo"];
        
        if ([jsonArr isKindOfClass:[NSDictionary class]]) {
            Bank *bank = [[Bank alloc] initWithItem:(NSDictionary *)jsonArr];
            [bankArr addObject:bank];
            
        }else if([jsonArr isKindOfClass:[NSArray class]]){
            for ( int i=0; i<jsonArr.count; i++) {
                
                NSDictionary *bankDic = [jsonArr objectAtIndex:i];
                Bank *bank = [[Bank alloc] initWithItem:bankDic];
                [bankArr addObject:bank];
            }
        }
//            NSLog(@"response%@",dic);
        if (block)
            block(bankArr);        
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error.localizedRecoverySuggestion);
    }];
}

//根据区域或定位筛选银行
+ (void)selectAreaGetBanksInfo:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block{
    
    [[BQNetClient sharedClient] getPath:@"bankInfo/getByArea" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *bankArr =[NSMutableArray array];

        NSDictionary *dic = responseObject;

        NSArray *jsonArr = [dic objectForKey:@"bankInfo"];
        
        if ([jsonArr isKindOfClass:[NSDictionary class]]) {
            Bank *bank = [[Bank alloc] initWithItem:(NSDictionary *)jsonArr];
            [bankArr addObject:bank];
        }else if([jsonArr isKindOfClass:[NSArray class]]){
            for ( int i=0; i<jsonArr.count; i++) {
                
                NSDictionary *bankDic = [jsonArr objectAtIndex:i];
                Bank *bank = [[Bank alloc] initWithItem:bankDic];
                [bankArr addObject:bank];
            }
        }

        if (block)
            block(bankArr);
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error.localizedRecoverySuggestion);
    }];
}

@end
