//
//  GetTicketViewController.m
//  BQ
//
//  Created by Zoe on 13-4-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "GetTicketViewController.h"
#import "TicketView.h"

@interface GetTicketViewController ()

@end

@implementation GetTicketViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Number *number  = [[Number alloc] init];
    number.bankName = @"中国建设银行";
    number.bankNumber = @"B009";
    number.business = @"贷款";
    number.presentNumber = @"B007";
    number.peopleNumber = 10;
    number.time = @"2013/4/10  17:32";
    
    self.title = @"领取号码";
    self.view.backgroundColor = [UIColor clearColor];
    
//    [self nailImageView];
    
    UIImageView *ticketBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ticket"]];
    [ticketBg setFrame:CGRectMake(32, 50, 255, 266)];
    [self.view addSubview:ticketBg];

    TicketView *ticketView = [[TicketView alloc] initWithFrame:CGRectMake(0, 0, ticketBg.frame.size.width, ticketBg.frame.size.height)];
    ticketView.number = number;
    [ticketBg addSubview:ticketView];

}

//图钉
- (void)nailImageView{
    
    CGFloat x,y;
    for (int i=0;i<4; i++) {
        if (i==0||i==2)
            x=17;
        else
            x=292;
        
        if (i==0||i==1)
            y=15;
        else
            y=337;
    }

    UIImageView *nailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nail"]];
    nailImageView.frame = CGRectMake(x, y, 19, 18);
    [self.view addSubview:nailImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
