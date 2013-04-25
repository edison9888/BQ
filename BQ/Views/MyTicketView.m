//
//  MyTicketView.m
//  BQ
//
//  Created by Zoe on 13-4-11.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MyTicketView.h"

#define BetweenHeight 12

@implementation MyTicketView

- (id)initWithFrame:(CGRect)frame index:(NSInteger)index type:(TicketType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 342)];
        if (type==myTicket) {
            [bgView setImage:[UIImage imageNamed:@"myTicketBg"]];
        }else
            [bgView setImage:[UIImage imageNamed:@"ticket@2x"]];

        bgView.userInteractionEnabled=YES;
        [self addSubview:bgView];
        
        //过期戳
        stampImageView = [[UIImageView alloc] initWithFrame:CGRectMake(140,10,157,157)];
        [stampImageView setImage:[UIImage imageNamed:@"stamp"]];
        stampImageView.hidden=YES;
        [self addSubview:stampImageView];
        
        bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(48, 9, 194, 30)];
        bankNameLabel.text = @"您还未选择银行";
        bankNameLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:22];
        bankNameLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        bankNameLabel.backgroundColor = [UIColor clearColor];
        [bankNameLabel setTextAlignment:NSTextAlignmentCenter];
        [bgView addSubview:bankNameLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(104,40, 80, 12)];
        timeLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        timeLabel.font=[UIFont fontWithName:@"Helvetica" size:10];
        timeLabel.text = @"2013/3/13  13:14";
        timeLabel.backgroundColor = [UIColor clearColor];
        [timeLabel setTextAlignment:NSTextAlignmentCenter];
        [timeLabel setLineBreakMode:NSLineBreakByClipping];
        [bgView addSubview:timeLabel];
        
//        UIImageView *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(15, timeLabel.frame.size.height+timeLabel.frame.origin.y, 280, 7)];
//        imageView.image = [UIImage imageNamed:@"line"];
//        [bgView addSubview:imageView];

        asideLabel = [[UILabel alloc] initWithFrame:CGRectMake(23,98, 140, 18)];
        asideLabel.text = @"我的号码";
        asideLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
        asideLabel.textColor = [UIColor colorWithRed:25.0f/255 green:135.0f/255 blue:130.0f/255 alpha:1.0f];
        asideLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:asideLabel];
        
        numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(asideLabel.frame.size.width+asideLabel.frame.origin.x, asideLabel.frame.origin.y-5, 130, 25)];
        numberLabel.textColor = [UIColor colorWithRed:25.0f/255 green:135.0f/255 blue:130.0f/255 alpha:1.0f];
        numberLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:30];
        numberLabel.text=@"A000";
        numberLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:numberLabel];
        
        UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(asideLabel.frame.origin.x,numberLabel.frame.origin.y+numberLabel.frame.size.height+BetweenHeight*3 ,80, 16)];
        pointLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        pointLabel.text=@"主办业务   ";
        pointLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
        pointLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:pointLabel];
        
        businessLabel = [[UILabel alloc] initWithFrame:CGRectMake(pointLabel.frame.origin.x+pointLabel.frame.size.width,pointLabel.frame.origin.y-3 , 200, 19)];
        businessLabel.textColor = [UIColor colorWithRed:65.0f/255 green:75.0f/255 blue:85.0f/255 alpha:1.0f];
        businessLabel.text=@"";
        businessLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:18];
        businessLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:businessLabel];

        
        UILabel *preNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(asideLabel.frame.origin.x, pointLabel.frame.size.height+pointLabel.frame.origin.y+BetweenHeight, 80, 16)];
        preNumberLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
        preNumberLabel.text=@"目前叫号   ";
        preNumberLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        preNumberLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:preNumberLabel];
        
        presentNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(preNumberLabel.frame.origin.x+preNumberLabel.frame.size.width, preNumberLabel.frame.origin.y-3, 200, 18)];
        presentNumberLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
        presentNumberLabel.text=@"";
        presentNumberLabel.backgroundColor = [UIColor clearColor];
        presentNumberLabel.textColor = [UIColor colorWithRed:65.0f/255 green:75.0f/255 blue:85.0f/255 alpha:1.0f];
        [bgView addSubview:presentNumberLabel];

        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(asideLabel.frame.origin.x, preNumberLabel.frame.origin.y+preNumberLabel.frame.size.height+BetweenHeight, 155, 18)];
        numLabel.text = @"您所在的排列前还有";
        numLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
        numLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        numLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:numLabel];
        
        remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(numLabel.frame.origin.x+numLabel.frame.size.width, numLabel.frame.origin.y-4, 250, 18)];
        remindLabel.text = @"0";
        remindLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:23];
        remindLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        remindLabel.backgroundColor = [UIColor clearColor];
        [remindLabel sizeToFit];
        [bgView addSubview:remindLabel];
        

        appendLabel = [[UILabel alloc] initWithFrame:CGRectMake(remindLabel.frame.origin.x+remindLabel.frame.size.width, numLabel.frame.origin.y, 50, 18)];
        appendLabel.text = @"个人";
        appendLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
        appendLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        appendLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:appendLabel];
        
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(numLabel.frame.origin.x, numLabel.frame.size.height+numLabel.frame.origin.y+BetweenHeight*2, 160, 30)];
        alertLabel.textColor = [UIColor colorWithRed:107.0f/255 green:107.0f/255 blue:107.0f/255 alpha:1.0f];
        alertLabel.font=[UIFont fontWithName:@"Helvetica" size:10];
        alertLabel.text = @"我们会于5个号码前发信息通知您请确保您的手机网络正常";
        alertLabel.backgroundColor= [UIColor clearColor];
        alertLabel.numberOfLines=0;
        [bgView addSubview:alertLabel];
                
        UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        refreshBtn.frame = CGRectMake(240,bankNameLabel.frame.origin.y+5, 54/2, 54/2);
        [refreshBtn setBackgroundImage:[UIImage imageNamed:@"refreshButton"] forState:UIControlStateNormal];
        [refreshBtn addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventTouchUpInside];
        refreshBtn.tag = index;
        [bgView addSubview:refreshBtn];
        
//        UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        infoBtn.frame = CGRectMake(refreshBtn.frame.origin.x-5, alertLabel.frame.origin.y+alertLabel.frame.size.height+45, 108/2, 73/2);
//        [infoBtn setBackgroundImage:[UIImage imageNamed:@"morebutton"] forState:UIControlStateNormal];
//        //[infoBtn addTarget:self action:@selector(infoClick:) forControlEvents:UIControlEventTouchUpInside];
//        [bgView addSubview:infoBtn];
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
    
    bankNameLabel.text = number.bankTypeName;
    
    numberLabel.text = number.myNum;
    businessLabel.text = [NSString stringWithFormat:@"%@",number.serviceName];
    presentNumberLabel.text = [NSString stringWithFormat:@"%@",number.presentNumber];
    
    if (number.beforeCount!=0) {
        
        remindLabel.text = number.beforeCount;
        [remindLabel sizeToFit];
        [remindLabel setTextColor:[UIColor colorWithRed:233/255.0f green:100/255.0f blue:163/255.0f alpha:1.0f]];
        appendLabel.frame = CGRectMake(remindLabel.frame.origin.x+remindLabel.frame.size.width+5,numLabel.frame.origin.y,appendLabel.frame.size.width, appendLabel.frame.size.height);
        
    }
    timeLabel.text = number.numDate;
    
    if (number.numStatus==1)
        stampImageView.hidden=NO;
    
    [asideLabel setTextColor:[UIColor whiteColor]];
    [numberLabel setTextColor:[UIColor whiteColor]];
}


@end
