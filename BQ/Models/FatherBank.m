//
//  FatherBank.m
//  BQ
//
//  Created by Zoe on 13-4-15.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "FatherBank.h"
#import "BQNetClient.h"
#import "SVProgressHUD.h"

@implementation FatherBank

- (id)initWithItem:(NSDictionary *)dic{
    
    if (self=[super init]) {
        _bankTypeId = [dic objectForKey:@"bankTypeId"];
        _bankTypeName=[dic objectForKey:@"bankTypeName"];
        _parentId = [dic objectForKey:@"parentId"];
    }
    return self;
}


+(void)getAllBankInfo:(NSDictionary *)parameters WithBlock:(void (^)(NSArray *))block{
    NSMutableArray *fatherBanks = [NSMutableArray array];
    [SVProgressHUD show];

    BQNetClient *client = [BQNetClient sharedClient];
    [client getPath:@"bankType/getAllType" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        NSDictionary *dic = responseObject;
        NSArray *jsonArr;
        
        if (![dic isKindOfClass:[NSString class]]) {
            jsonArr =(NSArray *)[dic objectForKey:@"bankType"];
            
            for (int i=0; i<jsonArr.count; i++) {
                FatherBank *bank = [[FatherBank alloc] initWithItem:[jsonArr objectAtIndex:i]];
                [fatherBanks addObject:bank];
            }
        }
                       
        if(block)
            block(fatherBanks);
     
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [SVProgressHUD dismissWithError:@"网络异常" afterDelay:0.4f];
        if(block)
            block(fatherBanks);

            NSLog(@"%@",error.localizedRecoverySuggestion);
    }];

}
@end
