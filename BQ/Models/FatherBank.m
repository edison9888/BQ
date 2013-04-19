//
//  FatherBank.m
//  BQ
//
//  Created by Zoe on 13-4-15.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "FatherBank.h"
#import "BQNetClient.h"

@implementation FatherBank

- (id)initWithItem:(NSDictionary *)dic{
    
    if (self=[super init]) {
//        _bankTypeId = [dic objectForKey:@"bankTypeId"];
//        _bankTypeName=[dic objectForKey:@"bankTypeName"];
//        _parentId = [dic objectForKey:@"parentId"];
    }
    return self;
}


+(void)getAllBankInfo:(NSDictionary *)parameters WithBlock:(void (^)(NSArray *))block{

    BQNetClient *client = [BQNetClient sharedClient];
    [client getPath:@"bankType/getAllType" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       NSDictionary *dic= [BQNetClient nsdataTurnToNSDictionary:responseObject];
        NSArray *jsonArr = [NSArray arrayWithObject:dic];
        NSMutableArray *fatherBanks = [NSMutableArray array];
        
        for (int i=0; i<jsonArr.count; i++) {
            FatherBank *bank = [[FatherBank alloc] initWithItem:[jsonArr objectAtIndex:i]];
            [fatherBanks addObject:bank];
        }
        
        if(block)
            block(fatherBanks);
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error.userInfo);
    }];

}
@end
