//
//  NoTicketView.m
//  BQ
//
//  Created by Zoe on 13-5-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "NoTicketView.h"
#import <QuartzCore/QuartzCore.h>

//309,400
@implementation NoTicketView

- (id)initWithFrame:(CGRect)frame heightIphone5:(NSInteger)_heightIphone5
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *bgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height)];
        [bgView setBackgroundColor:[UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f]];
        bgView.layer.cornerRadius = 7;
        bgView.layer.masksToBounds = YES;
        [self addSubview:bgView];
        
        UIImageView *paperImageView =[[UIImageView alloc] initWithFrame:CGRectMake(120, 90+_heightIphone5, 68, 78)];
        [paperImageView setImage:[UIImage imageNamed:@"paper"]];
        [bgView addSubview:paperImageView];
        
        UILabel *bigLabel =[[UILabel alloc] initWithFrame:CGRectMake(0,paperImageView.frame.size.height+paperImageView.frame.origin.y+40, bgView.frame.size.width, 20)];
        [bigLabel setFont:[UIFont systemFontOfSize:18]];
        [bigLabel setTextColor:[UIColor colorWithRed:100/255.0f green:100/255.f blue:100/255.0f alpha:1.0f]];
        [bigLabel setTextAlignment:NSTextAlignmentCenter];
        [bigLabel setBackgroundColor:[UIColor clearColor]];
        [bigLabel setText:@"您还未领取排队号码"];
        [bgView addSubview:bigLabel];
        
        UILabel *smallLabel =[[UILabel alloc] initWithFrame:CGRectMake(0,bigLabel.frame.size.height+bigLabel.frame.origin.y+15, bgView.frame.size.width, 15)];
        [smallLabel setFont:[UIFont systemFontOfSize:12]];
        [smallLabel setTextColor:[UIColor colorWithRed:187/255.0f green:187/255.f blue:187/255.0f alpha:1.0f]];
        [smallLabel setTextAlignment:NSTextAlignmentCenter];
        [smallLabel setBackgroundColor:[UIColor clearColor]];
        [smallLabel setText:@"暂时没有相关数据"];
        [bgView addSubview:smallLabel];
        
        UILabel *fingerLabel =[[UILabel alloc] initWithFrame:CGRectMake(0,smallLabel.frame.size.height+smallLabel.frame.origin.y+85+_heightIphone5, bgView.frame.size.width, 15)];
        [fingerLabel setFont:[UIFont systemFontOfSize:12]];
        [fingerLabel setTextColor:[UIColor colorWithRed:187/255.0f green:187/255.f blue:187/255.0f alpha:1.0f]];
        [fingerLabel setTextAlignment:NSTextAlignmentCenter];
        [fingerLabel setBackgroundColor:[UIColor clearColor]];
        [fingerLabel setText:@"点击 开始领票"];
        [bgView addSubview:fingerLabel];

        UIImageView *fingerImageView =[[UIImageView alloc] initWithFrame:CGRectMake(148,fingerLabel.frame.size.height+fingerLabel.frame.origin.y+4, 20, 29)];
        [fingerImageView setImage:[UIImage imageNamed:@"finger"]];
        [bgView addSubview:fingerImageView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
