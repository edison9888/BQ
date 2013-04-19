//
//  UserViewController.m
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "UserViewController.h"
#import "SelectBankViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

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

    //背景图
    UIImageView *homeBG = [[UIImageView alloc]initWithFrame:self.view.bounds];
    if (iPhone5) {
        [homeBG setImage:[UIImage imageNamed:@"bigBack5"]];
    }else{
        [homeBG setImage:[UIImage imageNamed:@"bigBack4"]];
    }
    homeBG.userInteractionEnabled =YES;
    [self.view addSubview:homeBG];

    
    self.title = @"我的号码";
    
    Number *number  = [[Number alloc] init];
    number.bankName = @"中国建设银行";
    number.bankNumber = @"B009";
    number.business = @"贷款";
    number.presentNumber = @"B007";
    number.peopleNumber = 19;
    number.time = @"2013/4/10  17:32";
    number.status=1;
    
    Number *number1  = [[Number alloc] init];
    number1.bankName = @"中国工商银行";
    number1.bankNumber = @"A009";
    number1.business = @"贷款";
    number1.presentNumber = @"A007";
    number1.peopleNumber = 11;
    number1.time = @"2013/4/10  17:32";
    number1.status=2;
    
    Number *number2  = [[Number alloc] init];
    number2.bankName = @"中信银行";
    number2.bankNumber = @"A009";
    number2.business = @"贷款";
    number2.presentNumber = @"A007";
    number2.peopleNumber = 11;
    number2.time = @"2013/4/10  17:32";
    number2.status=0;
    
    UIButton *selectBankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBankButton addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchUpInside];
    [selectBankButton setImage:[UIImage imageNamed:@"mapBtn"] forState:UIControlStateNormal];
    [selectBankButton setFrame:CGRectMake(self.view.bounds.size.width/2-111/2,self.view.bounds.size.height-100, 111, 63)];
    [self.view addSubview:selectBankButton];
    
    //此处调用接口获取数据
    self.numberArr = [NSMutableArray arrayWithObjects:number,number1,number2,nil];

    scrollView =[[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.bounces=YES;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width,9*2+340*self.numberArr.count+20*(self.numberArr.count-1)+90);
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (UIView *view in  [scrollView subviews]) {
        if ([view isKindOfClass:[MyTicketView class]]) {
            [view removeFromSuperview];
        }
    }    
    
    for (int i=0; i<self.numberArr.count; i++) {
        [self createMyTicket:CGRectMake(4, 9+i*(340+20), 310, 340) index:i];
    }
}

#pragma mark--
#pragma mark--选择银行
-(void)buttonPress{
    self.navigationController.navigationBar.hidden = NO;
    
//    isLocation = YES;
    
    SelectBankViewController  *selectBankVC = [[SelectBankViewController alloc]init];
    selectBankVC.delegate=self;
    [self.navigationController pushViewController:selectBankVC animated:YES];
    
}

-(void)createMyTicket:(CGRect)rect index:(NSInteger)i{

    
    MyTicketView *myTicketView =[[MyTicketView alloc] initWithFrame:rect index:i type:myTicket];
    myTicketView.number=[self.numberArr objectAtIndex:i];
    myTicketView.delegate=self;
    myTicketView.tag=i+10;
    [scrollView addSubview:myTicketView];

}

#pragma mark--
#pragma mark--MyTicketRefreshDelegate
//刷新票数据----刷新单张还是多张
- (void)refreshTicketsDelegate:(Number *)number btnIndex:(NSInteger)index{
    //number.numberId 票据id  网络请求
    
    //模拟数据
    Number *_number  = [[Number alloc] init];
    _number.bankName = @"光大银行";
    _number.bankNumber = @"H009";
    _number.business = @"贷款";
    _number.presentNumber = @"B007";
    _number.peopleNumber = 18;
    _number.time = @"2013/4/10  17:32";
    _number.status=1;

    MyTicketView *myTicketView = (MyTicketView *)[scrollView viewWithTag: index+10];
    myTicketView.number = _number;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
