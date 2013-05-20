//
//  GetTicketViewController.m
//  BQ
//
//  Created by Zoe on 13-4-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "GetTicketViewController.h"
#import "Helper.h"
#import "TicketSoundEffect.h"

#import <AVFoundation/AVFoundation.h>

@interface GetTicketViewController ()

@end

@implementation GetTicketViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

//返回上一层
- (void)backToLastVC{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Helper leftBarButtonItem:self];
    
    self.title = @"领取号码";
    self.view.backgroundColor = [UIColor clearColor];

    ticketBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flashTicket"]];
    [ticketBg setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    [self.view insertSubview:ticketBg atIndex:3];
    
    
    ticketBg1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, ticketBg.frame.origin.y+ticketBg.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-NavigationHeight-ticketBg.frame.size.height)];
    if (iPhone5)
        [ticketBg1 setImage:[UIImage imageNamed:@"flashTicketIphone5"]];
    else
        [ticketBg1 setImage:[UIImage imageNamed:@"flashTicket1"]];
    
    
    //领票
    [self getTicketFromNet];
    
}

- (void)getTicketFromNet{
    
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:_bank.bankId,@"bankId",_busniess.serviceId,@"serviceId", nil];
    
    [Number getBankNumberInfo:dic WithBlock:^(Number *num) {
        
        //生成票号
        ticketView= [self createMyTicket:num];
        //动画
        [self animateGetTicket:ticketView];
        //声音
        [TicketSoundEffect playTicketSound];
        
        [self.view insertSubview:ticketBg1 belowSubview:ticketView];

    }];
}

- (MyTicketView *)createMyTicket:(Number *)num{

    MyTicketView *_ticketView = [[MyTicketView alloc] initWithFrame:CGRectMake(26,-182, 290,342) index:0 type:getTicket];
    _ticketView.ticketType=getTicket;
    _ticketView.number = num;
    [self.view insertSubview:_ticketView atIndex:2];
    
    return _ticketView;
}

#pragma mark--
#pragma mark--AnimateTicket
//出票动画
-(void)animateGetTicket:(MyTicketView *)_ticketView{
//    NSLog(@"NSDate%@",[NSDate date]);
    double __block originY;
    
    originY=_ticketView.frame.origin.y;
    
    [UIView animateWithDuration:0.2f animations:^{
        [_ticketView setFrame:CGRectMake(_ticketView.frame.origin.x, originY+20, _ticketView.frame.size.width,_ticketView.frame.size.height)];
        [self.view insertSubview:ticketBg aboveSubview:_ticketView];
       
        
        } completion:^(BOOL finished) {
            
            if (originY<=145-200) {
                
                [self performSelector:@selector(callBack:) withObject:ticketView afterDelay:0.04f];
                
            }else{
                [UIView animateWithDuration:0.2f animations:^{
                    [_ticketView setFrame:CGRectMake(_ticketView.frame.origin.x, 57, _ticketView.frame.size.width,_ticketView.frame.size.height)];
                    return ;
                } completion:^(BOOL finished) {
//                    NSLog(@"NSDate%@",[NSDate date]);
                    //0.5f 返回首页
                    [self performSelector:@selector(backToLastVC) withObject:ticketView afterDelay:0.5f];
                }];
            }
    }];
}

- (void)callBack:(MyTicketView *)_ticketView{
    [self animateGetTicket:_ticketView];
}

#pragma mark--
#pragma mark--release memory
- (void)viewDidUnload
{
  [super viewDidUnload];
    
    ticketBg=nil;
    ticketView=nil;
    ticketBg1=nil;
    _bank=nil;
    _busniess=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && self.view.window == nil) {
        self.view = nil;
    }

}

@end
