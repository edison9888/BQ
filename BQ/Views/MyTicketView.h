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
   getTicket,
   abandonTicket
} TicketType;

@protocol MyTicketViewDelegate <NSObject>

@optional
-(void)refreshTicketsDelegate:(Number *)number btnIndex:(NSInteger)index;//刷新我的票

@end

@interface MyTicketView : UIView<UIGestureRecognizerDelegate>
{
    @private
        UIView *qrView;
        UIImageView *bgView,*qrImageView;//背景
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
        UIImageView *breakPaperImg;
        UIButton *refreshBtn;
    
        NSInteger coverInt;
        NSString *imageFileStr;
}

@property(nonatomic,strong) Number *number;
@property(nonatomic,weak) id<MyTicketViewDelegate> delegate;
@property(nonatomic,assign) TicketType ticketType;
@property(nonatomic,strong) UIImageView *refreshImageView;

- (id)initWithFrame:(CGRect)frame index:(NSInteger)index type:(TicketType)type;

@end
