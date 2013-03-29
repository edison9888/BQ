//
//  NSDictionary+helper.h
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (helper)

-(NSString*) stringForKey:(id)key;
-(NSNumber*)numberForKey:(id)key;
- (NSMutableDictionary*) dictionaryForKey:(id)key;
- (NSMutableArray*) arrayForKey:(id)key;
@end
