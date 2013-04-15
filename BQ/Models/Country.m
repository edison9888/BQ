//
//  Country.m
//  BQ
//
//  Created by Zoe on 13-4-15.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "Country.h"
#import "DBConnection.h"

@implementation Country


- (id)init{

    if (self=[super init]) {
        
        
        
    }
    
    return self;
}


//获得数据库里的Country
- (Country *)initWithItem:(Statement *)statement{
    
    Country *county = [[Country alloc] init];
    county.countyId = [statement getInt32:0];
    county.countryName = [statement getString:1];
      
    return county;
}


@end
