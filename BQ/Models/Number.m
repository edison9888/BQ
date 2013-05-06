//
//  Number.m
//  BQ
//
//  Created by Zoe on 13-4-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "Number.h"
#import "BQNetClient.h"
#import "DBConnection.h"

@implementation Number

- (id)initWithItem:(NSDictionary *)dic{

    if (self=[super init]) {
        
        _numId = [dic objectForKey:@"numId"];
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
        
        _bankTypeName=[dic objectForKey:@"bankTypeName"];
    }
    return self;
}

//领取票号==生成我的号码
+ (void)getBankNumberInfo:(NSDictionary *)parameters WithBlock:(void (^)(Number *num))block{
    [[BQNetClient sharedClient] getPath:@"number/getNum" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = responseObject;

        NSDictionary *numDic = [dic objectForKey:@"numberInfo"];
//        NSLog(@"response%@",numDic);

        Number *num;
        if ([numDic isKindOfClass:[NSDictionary class]]) {
            num = [[Number alloc] initWithItem:numDic];
            [num insertDB];
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
        NSDictionary *dic = responseObject;

        NSArray *jsonArr = [dic objectForKey:@"numberInfo"];
        
//        NSLog(@"response%@",dic);
        if ([jsonArr isKindOfClass:[NSDictionary class]]) {
            Number *num = [[Number alloc] initWithItem:(NSDictionary *)jsonArr];
            if (![num.numId isEqualToString:@"0"]) {
                [numArr addObject:num];
            }
        }else if([jsonArr isKindOfClass:[NSArray class]]){
            for ( int i=0; i<jsonArr.count; i++) {
                
                NSDictionary *bankDic = [jsonArr objectAtIndex:i];
                Number *num = [[Number alloc] initWithItem:bankDic];
                if (![num.numId isEqualToString:@"0"]) {
                    [numArr addObject:num];
                }
            }
        }
        
        if (block)            
            block(numArr);        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
        
        
        
    }];

}



- (void)insertDB{
    static Statement *stmt = nil;
    if (stmt == nil) {
        stmt = [DBConnection statementWithQuery:"INSERT INTO Numbers (num_id,my_num,num_date,num_status,before_count,now_num,bank_id,bank_name,service_id,service_name,service_parentid,banktype_name) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"];
    }
    
    [stmt bindString:_numId forIndex:1];
    [stmt bindString:_myNum forIndex:2];
    [stmt bindString:_numDate forIndex:3];
    [stmt bindInt32:_numStatus forIndex:4];
    [stmt bindString:_beforeCount forIndex:5];
    [stmt bindString:_presentNumber forIndex:6];
    [stmt bindString:_bankId forIndex:7];
    [stmt bindString:_bankName forIndex:8];
    [stmt bindString:_serviceId forIndex:9];
    [stmt bindString:_serviceName forIndex:10];
    [stmt bindString:_serParentId forIndex:11];
    [stmt bindString:_bankTypeName forIndex:12];
    
    int step = [stmt step];
    if (step != SQLITE_DONE) {
		NSLog(@"insert error errorcode =%d ",step);
    }
    [stmt reset];    
}


//通过获取今天的票id
+ (NSArray *)selectNumbersInfoFromDatabase{

    NSMutableArray *mutableArr = [NSMutableArray array];
    
    static Statement *statement = nil;
    
    if (statement==nil) {
//        statement = [DBConnection statementWithQuery:"SELECT * FROM Numbers where num_date >= date('NOW')"];
        statement = [DBConnection statementWithQuery:"SELECT * FROM Numbers"];
    }
    
    while ([statement step] == SQLITE_ROW) {
        NSString *numId;
        if ([statement getInt32:4]!=1) {
            numId = [statement getString:1];
            [mutableArr addObject:numId];
        }
    }
    
    [statement reset];
    return mutableArr;
}


//无网络情况下，获取numbers(status!=1)
+ (NSArray *)getNumbersFromSqliteWithoutNet{
    NSMutableArray *mutableArr = [NSMutableArray array];
    static Statement *statement = nil;
    if (statement==nil) {
        statement = [DBConnection statementWithQuery:"SELECT * FROM Numbers"];
    }
    
    while ([statement step] == SQLITE_ROW) {
        if ([statement getInt32:4]!=1) {
            Number *num = [[Number alloc] init];
            num.numId = [statement getString:1];
            num.myNum=[statement getString:2];
            num.numDate=[statement getString:3];
            num.numStatus=[statement getInt32:4];
            num.beforeCount=[statement getString:5];
            num.presentNumber =[statement getString:6];
            num.bankId =[statement getString:7];
            num.bankName=[statement getString:8];
            num.serviceId=[statement getString:9];
            num.serviceName=[statement getString:10];
            num.serParentId=[statement getString:11];
            num.bankTypeName=[statement getString:12];
            [mutableArr addObject:num];
        }
    }
    
    [statement reset];
    return mutableArr;
}

//不是今天的票，状态改为1：作废
+ (NSArray *)updateNumbersStatusBeforeTodayFromDatabase{
    
    NSMutableArray *mutableArr = [NSMutableArray array];
    
    static Statement *statement = nil;
    
    if (statement==nil) { 

        statement = [DBConnection statementWithQuery:"UPDATE Numbers SET num_status= 1"];
    }
    
    while ([statement step] == SQLITE_ROW) {
        NSLog(@"成功修改状态");
    }
    
    [statement reset];
    return mutableArr;
}

+ (void)deleteNumbersFromSqlite{

    static Statement *statement = nil;
    
    if (statement==nil) {
        statement = [DBConnection statementWithQuery:"DELETE FROM Numbers"];
    }
    
    int step = [statement step];
    if (step != SQLITE_DONE) {
		NSLog(@"insert error errorcode =%d ",step);
    }
    [statement reset];
}
@end
