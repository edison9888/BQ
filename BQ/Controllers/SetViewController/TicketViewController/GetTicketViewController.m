//
//  GetTicketViewController.m
//  BQ
//
//  Created by Zoe on 13-4-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "GetTicketViewController.h"
#import "TicketView.h"
#import "Helper.h"

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


//返回上一层
- (void)backToLastVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Helper leftBarButtonItem:self];

    
    Number *number  = [[Number alloc] init];
    number.bankName = @"中国建设银行";
    number.bankNumber = @"B009";
    number.business = @"贷款";
    number.presentNumber = @"B007";
    number.peopleNumber = 10;
    number.time = @"2013/4/10  17:32";
    
    self.title = @"领取号码";
    self.view.backgroundColor = [UIColor clearColor];

    ticketBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flashTicket"]];
    [ticketBg setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    [self.view insertSubview:ticketBg atIndex:3];
    
    TicketView *ticketView = [[TicketView alloc] initWithFrame:CGRectMake(20,-122, 242,285)];
    ticketView.number = number;
    [self.view insertSubview:ticketView atIndex:2];
        
    UIImageView *ticketBg1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, ticketBg.frame.origin.y+ticketBg.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-TabBarHeight-NavigationHeight-ticketBg.frame.size.height)];
    if (iPhone5)
        [ticketBg1 setImage:[UIImage imageNamed:@"flashTicketIphone5"]];
    else
        [ticketBg1 setImage:[UIImage imageNamed:@"flashTicket1"]];
    
    [self.view insertSubview:ticketBg1 belowSubview:ticketView];
    
    [self animateGetTicket:ticketView];
}

//出票动画
-(void)animateGetTicket:(TicketView *)ticketView{

    double __block originY;
    
    originY=ticketView.frame.origin.y;
    
    [UIView animateWithDuration:0.2f animations:^{
        [ticketView setFrame:CGRectMake(20, originY+20, 242,285)];
        [self.view insertSubview:ticketBg aboveSubview:ticketView];
        
        } completion:^(BOOL finished) {
            
            if (originY<=145-200) {
                
                [self performSelector:@selector(callBack:) withObject:ticketView afterDelay:0.05f];
                
            }else{
                [UIView animateWithDuration:0.3f animations:^{
                    [ticketView setFrame:CGRectMake(20, 179, 242,285)];
                    return ;
                }];
            }
    }];
}

- (void)callBack:(TicketView *)ticketView{
    [self animateGetTicket:ticketView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
