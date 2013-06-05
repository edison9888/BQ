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
        
        _nameStr = [dic objectForKey:@""];
        
        _html = [dic objectForKey:@"result"];
        
        _htmlId = [dic objectForKey:@"filled_id"];
    }
    return self;
}


+(void)getPersonalForm:(NSDictionary *)parameters  WithBlock:(void (^)(NSData *data))block{

    [[BQNetClient sharedClient] getPath:@"filledform/getform" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        Form *form = [[Form alloc] initWithItem:responseObject];
        NSData* data = [form.html dataUsingEncoding:NSUTF8StringEncoding];
        
        if (block) {
            block(data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedRecoverySuggestion);
        NSData* data = [error.localizedRecoverySuggestion dataUsingEncoding:NSUTF8StringEncoding];

        if (block) {
            block(data);
        }

    }];
}

+(void)sendPersonalInfo:(NSDictionary *)parameters  WithBlock:(void (^)())block{
    [SVProgressHUD show];
        
    BQNetClient *client = [BQNetClient sharedClient];
    [client postPath:@"filledform/sendformdata" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SVProgressHUD dismissWithSuccess:@"提交成功" afterDelay:1.0f];

        NSDictionary *dic =(NSDictionary *)responseObject;
        
        if (![dic isKindOfClass:[NSString class]]) {
            Form *from = [[Form alloc] initWithItem:dic];
            NSLog(@"from.htmlId%@",from.htmlId);
        }
        
        if (debug) {
            NSLog(@"send%@",dic);
        }
        
       
        if(block)
            block();
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [SVProgressHUD dismissWithError:@"网络异常" afterDelay:0.4f];
//        if(block)
//            block(_html);
        NSLog(@"%@",error.localizedRecoverySuggestion);
    }];
}

@end
