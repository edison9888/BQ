//
//  DatabaseOperations.h
//  BQ
//
//  Created by Zoe on 13-4-15.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseOperations : NSObject


//====城市操作===//
+ (NSInteger)selectProIdFromDatabase:(NSString *)cityName;//获取城市的ProId字段

+ (NSMutableArray *)selectCountryFromDatabase:(NSInteger)proId;//通过proId字段检索二级市区




@end
