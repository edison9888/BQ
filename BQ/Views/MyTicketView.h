//
//  MyTicketView.h
//  BQ
//
//  Created by Zoe on 13-4-11.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Number.h"


typedef enum {
   myTicket,
   getTicket
} TicketType;

@protocol MyTicketViewDelegate <NSObject>

-(void)refreshTicketsDelegate:(Number *)number btnIndex:(NSInteger)index;//刷新我的票

@end

@interface MyTicketView : UIView
{
    @private
        UILabel *bankNameLabel;//银行名称
        UILabel *asideLabel;
        UILabel *numberLabel;//排队号
        UILabel *businessLabel;//业务
        UILabel *presentNumberLabel;//目前叫号
        UILabel *remindLabel;//提示文字
        UILabel *appendLabel;//字符串拼接
        UILabel *timeLabel;//时间
        UILabel *numLabel;
        UIImageView *stampImageView;//是否过期
    
}

@property(nonatomic,strong) Number *number;
@property(nonatomic,weak) id<MyTicketViewDelegate> delegate;
@property(nonatomic,assign) TicketType ticketType;
- (id)initWithFrame:(CGRect)frame index:(NSInteger)index type:(TicketType)type;

@end
