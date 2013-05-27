//
//  Number.h
//  BQ
//
//  Created by Zoe on 13-4-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Number.h"

//票状态
typedef enum {
    waitingStatus,//等待
    dealedStatus,//过期
    outOfTimeStatus,//已处理
}TicketStatus;


@interface Number : NSObject


@property(nonatomic,strong) NSString *numId;
@property(nonatomic,strong) NSString *beforeCount;//等待人数
@property(nonatomic,strong) NSString *myNum;//我的号码
@property(nonatomic,strong) NSString *presentNumber;//目前叫号
@property(nonatomic,strong) NSString *numDate;//时间
@property(nonatomic,assign) NSInteger numStatus;//票的状态 2：未办理  3：正在办理 4：已办理
@property(nonatomic,strong) NSString *numTag;//编号标识 

@property(nonatomic,assign) NSString *bankId;//排号id
@property(nonatomic,strong) NSString *bankName;//银行名称

@property(nonatomic,strong) NSString *serviceId;//业务id
@property(nonatomic,strong) NSString *serviceName;//业务类型
@property(nonatomic,strong) NSString *serParentId;//父类业务id
@property(nonatomic,strong) NSString *bankTypeName;//银行名称
@property(nonatomic,assign) NSInteger isNeedForm;//是否有预填单 1：yes 2：NO
 

//领取票号==生成我的号码
+ (void)getBankNumberInfo:(NSDictionary *)parameters WithBlock:(void (^)(Number*num))block;

//刷新我的排号
+ (void)refreshBankNumbers:(NSDictionary *)parameters WithBlock:(void (^)(NSArray*arr))block;

//选择数据库
+ (NSArray *)selectNumbersInfoFromDatabase;

//无网络情况下，获取numbers(status!=1)
+ (NSArray *)getNumbersFromSqliteWithoutNet;

//删除数据库
+ (void)deleteNumbersFromSqlite;

//不是今天的票，状态改为1：作废
+ (NSArray *)updateNumbersStatusBeforeTodayFromDatabase;

@end
