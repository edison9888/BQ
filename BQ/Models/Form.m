//
//  Form.m
//  BQ
//
//  Created by Zoe on 13-5-22.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "Form.h"
#import "BQNetClient.h"
#import "SVProgressHUD.h"

@implementation Form

- (id)initWithItem:(NSDictionary *)dic{
    
    if (self=[super init]) {
    
    }
    return self;
}


+(void)sendPersonalInfo:(NSDictionary *)parameters  WithBlock:(void (^)())block{
    [SVProgressHUD show];
        
    BQNetClient *client = [BQNetClient sharedClient];
    [client getPath:@"bankInfo/getform" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic =(NSDictionary *)responseObject;
        
        NSLog(@"send%@",dic);
       
        if(block)
            block();
        
        [SVProgressHUD dismissWithSuccess:@"提交成功" afterDelay:0.4f];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [SVProgressHUD dismissWithError:@"网络异常" afterDelay:0.4f];
//        if(block)
//            block(_html);
        
        NSLog(@"%@",error.localizedRecoverySuggestion);
    }];
    
}

@end
