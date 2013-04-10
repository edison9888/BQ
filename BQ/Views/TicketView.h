//
//  TicketView.h
//  BQ
//
//  Created by Zoe on 13-4-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Number.h"

@interface TicketView : UIView
{
    @private
    UILabel *bankNameLabel;//银行名称

    UILabel *numberLabel;//排队号
    UILabel *businessLabel;//业务
    UILabel *presentNumberLabel;//目前叫号
    UILabel *remindLabel;//提示文字
    UILabel *timeLabel;//时间

}

@property(nonatomic,strong) Number *number;
@end
