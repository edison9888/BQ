//
//  MyTicketView.h
//  BQ
//
//  Created by Zoe on 13-4-11.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Number.h"

@protocol MyTicketViewDelegate <NSObject>

-(void)refreshTicketsDelegate:(Number *)number btnIndex:(NSInteger)index;//刷新我的票

@end

@interface MyTicketView : UIView
{
    @private
        UILabel *bankNameLabel;//银行名称
        
        UILabel *numberLabel;//排队号
        UILabel *businessLabel;//业务
        UILabel *presentNumberLabel;//目前叫号
        UILabel *remindLabel;//提示文字
        UILabel *timeLabel;//时间
    
        UIImageView *stampImageView;//是否过期
    
}

@property(nonatomic,strong) Number *number;
@property(nonatomic,weak) id<MyTicketViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame index:(NSInteger)index;
@end
