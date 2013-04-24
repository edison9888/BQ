//
//  GetTicketViewController.m
//  BQ
//
//  Created by Zoe on 13-4-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "GetTicketViewController.h"
#import "Helper.h"

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
    
//    Number *number  = [[Number alloc] init];
//    number.bankName = @"中国建设银行";
//    number.bankNumber = @"B009";
//    number.business = @"贷款";
//    number.presentNumber = @"B007";
//    number.peopleNumber = 10;
//    number.time = @"2013/4/10  17:32";
    
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
    
    [self.view insertSubview:ticketBg1 atIndex:-10];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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

        [self.view insertSubview:ticketBg1 atIndex:-10];

    }];
    
}

- (MyTicketView *)createMyTicket:(Number *)num{

    MyTicketView *_ticketView = [[MyTicketView alloc] initWithFrame:CGRectMake(16,-182, 290,342) index:0 type:getTicket];
    _ticketView.ticketType=getTicket;
    _ticketView.number = num;
    [self.view insertSubview:_ticketView atIndex:2];
    
    return _ticketView;
}

#pragma mark--
#pragma mark--AnimateTicket
//出票动画
-(void)animateGetTicket:(MyTicketView *)_ticketView{

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
                    [self backToLastVC];
                }];
            }
    }];
}

- (void)callBack:(MyTicketView *)_ticketView{
    [self animateGetTicket:_ticketView];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
