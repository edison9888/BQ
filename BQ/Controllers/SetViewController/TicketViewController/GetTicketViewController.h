//
//  GetTicketViewController.h
//  BQ
//
//  Created by Zoe on 13-4-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Business.h"
#import "Bank.h"
#import "Number.h"
#import "MyTicketView.h"

@interface GetTicketViewController : UIViewController
{
    @private
    UIImageView *ticketBg;
    Number *number;
    MyTicketView *ticketView;
    UIImageView *ticketBg1;
}

@property(nonatomic,strong) Business *busniess;
@property(nonatomic,strong) Bank *bank;

@end
