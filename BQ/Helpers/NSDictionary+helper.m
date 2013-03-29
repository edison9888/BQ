//
//  NSDictionary+helper.m
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "NSDictionary+helper.h"

@implementation NSDictionary (helper)
-(NSString *) stringForKey:(id)key{
    id s = [self objectForKey:key];
    if (s ==[NSNull null] || ![s isKindOfClass:[NSString class]]) {
        return nil;
    }
    return s;
}

-(NSNumber *)numberForKey:(id)key{
    id s = [self objectForKey:key];
	if (s == [NSNull null] || ![s isKindOfClass:[NSNumber class]]) {
		return nil;
	}
	return s;
}

-(NSMutableDictionary*)dictionaryForKey:(id)key{
    id s = [self objectForKey:key];
	if (s == [NSNull null] || ![s isKindOfClass:[NSMutableDictionary class]]) {
		return nil;
	}
	return s;
}

- (NSMutableArray*) arrayForKey:(id)key {
	id s = [self objectForKey:key];
	if (s == [NSNull null] || ![s isKindOfClass:[NSMutableArray class]]) {
		return nil;
	}
	return s;
}

@end
