//
//  MyTicketView.m
//  BQ
//
//  Created by Zoe on 13-4-11.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MyTicketView.h"

#define BetweenHeight 8

@implementation MyTicketView

- (id)initWithFrame:(CGRect)frame index:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [bgView setImage:[UIImage imageNamed:@"myTicketBg"]];
        bgView.userInteractionEnabled=YES;
        [self addSubview:bgView];
        
        //过期戳
        stampImageView = [[UIImageView alloc] initWithFrame:CGRectMake(217,10,75,73)];
        [stampImageView setImage:[UIImage imageNamed:@"stamp"]];
        stampImageView.hidden=YES;
        [self addSubview:stampImageView];
        
        bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 27, 100, 20)];
        bankNameLabel.text = @"中国工商银行";
        bankNameLabel.font = [UIFont systemFontOfSize:22];
        bankNameLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        bankNameLabel.backgroundColor = [UIColor clearColor];
        [bankNameLabel sizeToFit];
        [bgView addSubview:bankNameLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(183,bankNameLabel.frame.size.height+bankNameLabel.frame.origin.y , 100, 18)];
        timeLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        timeLabel.font = [UIFont systemFontOfSize:10];
        timeLabel.text = @"2013/3/13  13:14:25";
        timeLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:timeLabel];

        
        UIImageView *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(15, timeLabel.frame.size.height+timeLabel.frame.origin.y, 280, 7)];
        imageView.image = [UIImage imageNamed:@"line"];
        [bgView addSubview:imageView];

        
        UILabel *asideLabel = [[UILabel alloc] initWithFrame:CGRectMake(195,imageView.frame.size.height+imageView.frame.origin.y+BetweenHeight*3, 140, 18)];
        asideLabel.text = @"您的轮候号码";
        asideLabel.font = [UIFont systemFontOfSize:17];
        asideLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        asideLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:asideLabel];
        
        numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, imageView.frame.size.height+imageView.frame.origin.y+BetweenHeight, frame.size.width, 36)];
        numberLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:0 blue:0 alpha:1.0f];
        numberLabel.font = [UIFont systemFontOfSize:36];
        numberLabel.text=@"A007";
        numberLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:numberLabel];
        
        businessLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberLabel.frame.origin.x,numberLabel.frame.origin.y+numberLabel.frame.size.height+BetweenHeight , 140, 16)];
        businessLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        businessLabel.text=@"主办业务：  理财";
        businessLabel.font = [UIFont systemFontOfSize:15];
        businessLabel.backgroundColor = [UIColor clearColor];
        [businessLabel sizeToFit];
        [bgView addSubview:businessLabel];
        
        presentNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(businessLabel.frame.origin.x, businessLabel.frame.size.height+businessLabel.frame.origin.y+BetweenHeight, 140, 16)];
        presentNumberLabel.font = [UIFont systemFontOfSize:15];
        presentNumberLabel.text=@"目前叫号：  A001";
        presentNumberLabel.backgroundColor = [UIColor clearColor];
        [presentNumberLabel sizeToFit];
        [bgView addSubview:presentNumberLabel];
        
        remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(presentNumberLabel.frame.origin.x, presentNumberLabel.frame.origin.y+presentNumberLabel.frame.size.height+BetweenHeight, 250, 16)];
        remindLabel.text = @"您所在的排列前还有5个人";
        remindLabel.font = [UIFont systemFontOfSize:15];
        remindLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        remindLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:remindLabel];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(remindLabel.frame.origin.x, remindLabel.frame.size.height+remindLabel.frame.origin.y+BetweenHeight*4, 300, 12)];
        alertLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        alertLabel.font = [UIFont systemFontOfSize:10];
        alertLabel.text = @"我们会于5个号码前发信息通知您 请确保您的手机网络正常";
        alertLabel.backgroundColor= [UIColor clearColor];
        [bgView addSubview:alertLabel];
        
        UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        infoBtn.frame = CGRectMake(270, 292, 20, 20);
        [infoBtn setBackgroundImage:[UIImage imageNamed:@"morebutton"] forState:UIControlStateNormal];
        //[infoBtn addTarget:self action:@selector(infoClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:infoBtn];
        
        UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        refreshBtn.frame = CGRectMake(270, remindLabel.frame.origin.y, 21.5, 20);
        [refreshBtn setBackgroundImage:[UIImage imageNamed:@"refreshButton"] forState:UIControlStateNormal];
        [refreshBtn addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventTouchUpInside];
        refreshBtn.tag = index;
        [bgView addSubview:refreshBtn];
    }
    return self;
}

//刷新
- (void)refreshClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    if ([self.delegate respondsToSelector:@selector(refreshTicketsDelegate:btnIndex:)]) {
        [self.delegate refreshTicketsDelegate:_number btnIndex:btn.tag];
    }
}

- (void)setNumber:(Number *)number{
    _number=number;
    
    bankNameLabel.text = number.bankName;
    [bankNameLabel sizeToFit];
    
    numberLabel.text = number.bankNumber;
    businessLabel.text = [NSString stringWithFormat:@"主办业务：  %@",number.business];
    presentNumberLabel.text = [NSString stringWithFormat:@"目前叫号：  %@",number.presentNumber];
    remindLabel.text = [NSString stringWithFormat:@"您所在的排列前还有%d个人",number.peopleNumber];
    timeLabel.text = number.time;
    
    if (number.status)
        stampImageView.hidden=NO;
}


@end
