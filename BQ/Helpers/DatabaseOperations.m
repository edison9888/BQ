//
//  DatabaseOperations.m
//  BQ
//
//  Created by Zoe on 13-4-15.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "DatabaseOperations.h"
#import "DBConnection.h"
#import "Country.h"

@implementation DatabaseOperations

//获取城市的ProId字段
+ (NSInteger)selectProIdFromDatabase:(NSString *)cityName{

    NSInteger proId = 0;
    
    static Statement *statement = nil;
    
    if (statement==nil) {
        statement = [DBConnection statementWithQuery:"SELECT pro_id FROM com_province WHERE pro_name = ?"];
    }
    
    [statement bindString:cityName forIndex:1];
    
    int step = [statement step];
    if (step != SQLITE_DONE) {
//		NSLog(@"insert customer error! errorcode =%d ",step);
        proId = [statement getInt32:0];
//        NSLog(@"proId====%d",proId);
        [[NSUserDefaults standardUserDefaults] setInteger:proId forKey:@"ProId"];
    }
    
    [statement reset];
    return proId;
}

//通过proId字段检索二级市区
+ (NSMutableArray *)selectCountryFromDatabase:(NSInteger)proId{

    if (proId==0) {
        proId=10;
    }
    NSMutableArray *mutableArr = [NSMutableArray array];

    static Statement *statement = nil;
    
    if (statement==nil) {
        statement = [DBConnection statementWithQuery:"SELECT * FROM com_county WHERE pro_id = ?"];
    }
    
    [statement bindInt32:proId forIndex:1];
    
    while ([statement step] == SQLITE_ROW) {        
        Country *country = [[Country alloc] init];
        country.countyId= [statement getInt32:0];
        country.countryName = [statement getString:1];
        [mutableArr addObject:country];
    }
    
//    NSLog(@"countys==%@",mutableArr);
    
    [statement reset];    
    
    return mutableArr;

}

@end
