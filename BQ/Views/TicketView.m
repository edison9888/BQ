//
//  TicketView.m
//  BQ
//
//  Created by Zoe on 13-4-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "TicketView.h"

@implementation TicketView

#define rowledge 7

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 100, 20)];
        bankNameLabel.text = @"中国工商银行";
        bankNameLabel.font = [UIFont systemFontOfSize:15];
        bankNameLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        [bankNameLabel sizeToFit];
        [self addSubview:bankNameLabel];
        
        UILabel *asideLabel = [[UILabel alloc] initWithFrame:CGRectMake(25,bankNameLabel.frame.size.height+bankNameLabel.frame.origin.y+rowledge, 92, 18)];
        asideLabel.text = @"您的轮候号码";
        asideLabel.font = [UIFont systemFontOfSize:16];
        asideLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        [self addSubview:asideLabel];
        
        numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, asideLabel.frame.size.height+asideLabel.frame.origin.y+rowledge, frame.size.width, 30)];
        numberLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:0 blue:0 alpha:1.0f];
        numberLabel.font = [UIFont systemFontOfSize:30];
        numberLabel.text=@"A007";
        numberLabel.backgroundColor = [UIColor clearColor];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numberLabel];
        
        UIImageView *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(25, numberLabel.frame.size.height+numberLabel.frame.origin.y+rowledge, 200, 7)];
        imageView.image = [UIImage imageNamed:@"line"];
        [self addSubview:imageView];
        
        businessLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x,imageView.frame.origin.y+imageView.frame.size.height+rowledge , 140, 12)];
        businessLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        businessLabel.text=@"主办业务：  理财";
        businessLabel.font = [UIFont systemFontOfSize:12];
        [businessLabel sizeToFit];
        [self addSubview:businessLabel];
        
        presentNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(businessLabel.frame.origin.x, businessLabel.frame.size.height+businessLabel.frame.origin.y+rowledge, 140, 12)];
        presentNumberLabel.font = [UIFont systemFontOfSize:12];
        presentNumberLabel.text=@"目前叫号：  A001";
        [presentNumberLabel sizeToFit];
        [self addSubview:presentNumberLabel];
        
        remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(presentNumberLabel.frame.origin.x, presentNumberLabel.frame.origin.y+presentNumberLabel.frame.size.height+rowledge, 150, 12)];
        remindLabel.text = @"您所在的排列前还有5个人";
        remindLabel.font = [UIFont systemFontOfSize:12];
        remindLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        [self addSubview:remindLabel];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(remindLabel.frame.origin.x, remindLabel.frame.size.height+remindLabel.frame.origin.y+rowledge, 202, 18)];
        alertLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        alertLabel.font = [UIFont systemFontOfSize:7];
        alertLabel.text = @"我们会于5个号码前发信息通知您 请确保您的手机网络正常";
        [self addSubview:alertLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(alertLabel.frame.origin.x,alertLabel.frame.size.height+alertLabel.frame.origin.y+rowledge , 100, 18)];
        timeLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        timeLabel.font = [UIFont systemFontOfSize:8];
        timeLabel.text = @"2013/3/13  13:14:25";
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        
        UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        infoBtn.frame = CGRectMake(210, 213, 20, 20);
        [infoBtn setBackgroundImage:[UIImage imageNamed:@"morebutton"] forState:UIControlStateNormal];
//        [infoBtn addTarget:self action:@selector(infoClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:infoBtn];
    }
    return self;
}

- (void)setNumber:(Number *)number{

    bankNameLabel.text = number.bankName;
    [bankNameLabel sizeToFit];
    
    numberLabel.text = number.bankNumber;
    businessLabel.text = [NSString stringWithFormat:@"主办业务：  %@",number.business];
    presentNumberLabel.text = [NSString stringWithFormat:@"目前叫号：  %@",number.presentNumber];
    remindLabel.text = [NSString stringWithFormat:@"您所在的排列前还有%d个人",number.peopleNumber];
    timeLabel.text = number.time;
    
}

@end
