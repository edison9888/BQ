//
//  HomeViewController.m
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "HomeViewController.h"
#import "MapViewController.h"

#import "TestView.h"

#import "GetTicketViewController.h"

#import "Helper.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

static HomeViewController *instance = nil;

+ (HomeViewController *)instance  {
    static HomeViewController *instance;
    
    @synchronized(self) {
        if(!instance) {
            instance = [[HomeViewController alloc] init];
        }
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        instance=self;
    }
    return self;
}



#pragma mark--
#pragma mark--隐藏tabbar
- (void)hidenTabbar:(BOOL) hidden{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    [UIView setAnimationDuration:0.3f];
    
//    NSLog(@"%@",self.tabBarController.view.subviews);
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, iPhone5?568:480, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, iPhone5?568-49:480-49, view.frame.size.width, view.frame.size.height)];
            }
        }
        else
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, iPhone5?568:480)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width,  iPhone5?568-49:480-49)];
            }
        }
    }
    
    [UIView commitAnimations];

}

#pragma mark--
#pragma mark--viewdidload
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"首页";
    
    isLocation=NO;    

    
    [self bankbackGroundImageView];

    UIImageView *bankButtonBg = [[UIImageView alloc]initWithFrame:CGRectMake(37, 50, 493/2, 103/2)];
    bankButtonBg.image=[UIImage imageNamed:@"bankButtonBg"];
    bankButtonBg.userInteractionEnabled=YES;
    [self.view addSubview:bankButtonBg];
    
    UIButton *selectBankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBankButton addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchUpInside];
    [selectBankButton setImage:[UIImage imageNamed:@"mapBtn"] forState:UIControlStateNormal];
    [selectBankButton setFrame:CGRectMake(bankButtonBg.frame.size.width-57,1, 56, 50)];
    [bankButtonBg addSubview:selectBankButton];

        
    _bankNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(48,155, 219, 22)];
    _bankNameLabel.text=@"中国工商银行";
    _bankNameLabel.backgroundColor=[UIColor clearColor];
    _bankNameLabel.font = [UIFont systemFontOfSize:18];
//    _bankNameLabel.textColor = [UIColor colorWithRed:173/255.f green:172/255.f blue:172/255.f alpha:1.0];
    [_bankNameLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_bankNameLabel];
    
    
       
    UIButton *personalBusinessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    personalBusinessBtn.enabled=NO;
    [personalBusinessBtn setTitle:@"个人业务" forState:UIControlStateNormal];
    [personalBusinessBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [personalBusinessBtn setFrame:CGRectMake(48, 213, 222, 95/2)];
    [personalBusinessBtn addTarget:self action:@selector(personalBusinessClick:) forControlEvents:UIControlEventTouchUpInside];
    [personalBusinessBtn setBackgroundImage:[UIImage imageNamed:@"busButton"] forState:UIControlStateNormal];
    personalBusinessBtn.tag=11;
    [self.view addSubview:personalBusinessBtn];
    
    UIButton *enterpriseBusinessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterpriseBusinessBtn.enabled=NO;
    [enterpriseBusinessBtn setTitle:@"企业业务" forState:UIControlStateNormal];
    [enterpriseBusinessBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [enterpriseBusinessBtn setFrame:CGRectMake(personalBusinessBtn.frame.origin.x, personalBusinessBtn.frame.size.height+personalBusinessBtn.frame.origin.y+10, 222, 95/2)];
    [enterpriseBusinessBtn addTarget:self action:@selector(enterpriseBusinessClick:) forControlEvents:UIControlEventTouchUpInside];
    [enterpriseBusinessBtn setBackgroundImage:[UIImage imageNamed:@"busButton"] forState:UIControlStateNormal];
    enterpriseBusinessBtn.tag=12;
    [self.view addSubview:enterpriseBusinessBtn];
    
}

-(void)bankbackGroundImageView{
//    UIImage *image = [[UIImage imageNamed:@"backGround"] resizableImageWithCapInsets:UIEdgeInsetsMake(360, 0, self.view.bounds.size.height, 0)];
    
    UIImage *image;
    if (iPhone5)
        image= [UIImage imageNamed:@"backGroundIp5"];
    else
        image= [UIImage imageNamed:@"backGround"];

    UIImageView *homeBG = [[UIImageView alloc]initWithImage:image];
    homeBG.userInteractionEnabled =YES;
    homeBG.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44-49);
    [self.view addSubview:homeBG];
}

//更改首页银行提示
- (void)setBank:(Bank *)bank{
    [_bankNameLabel setText:bank.title];
    
    [self changeBtnState];
}

//改变按钮状态--个人业务/企业业务
-(void)changeBtnState{

    UIButton *personalBusinessBtn,*enterpriseBusinessBtn;
    if (isLocation) {
        personalBusinessBtn =(UIButton*)[self.view viewWithTag:11];
        enterpriseBusinessBtn =(UIButton*)[self.view viewWithTag:12];
        personalBusinessBtn.enabled=YES;
        enterpriseBusinessBtn.enabled=YES;
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self hidenTabbar:NO];
    
}

#pragma mark--
#pragma mark--选择银行
-(void)buttonPress{
    
    isLocation = YES;
    
    SelectBankViewController  *selectBankVC = [[SelectBankViewController alloc]init];
    selectBankVC.delegate=self;
    [self.navigationController pushViewController:selectBankVC animated:YES];
    
}

#pragma mark--
#pragma mark--业务按钮事件
//个人业务
- (void)personalBusinessClick:(id)sender{
    personalVC = [[PersonalBusinessViewController alloc] init];
    personalVC.delegate=self;
    [self addChildViewController:personalVC];
    personalVC.view.frame=self.view.frame;
    [self.view addSubview:personalVC.view];
}

//企业业务
- (void)enterpriseBusinessClick:(id)sender{

    enterpriseVC = [[EnterpriseBusinessViewController alloc] init];
    enterpriseVC.homeVC=self;
    enterpriseVC.delegate=self;
    [self addChildViewController:enterpriseVC];
    enterpriseVC.view.frame=self.view.frame;
    [self.view addSubview:enterpriseVC.view];
    
}


//调转领票界面
- (void)pushToGetTicketVC{
    
    GetTicketViewController *ticketVC = [[GetTicketViewController alloc] init];
    [self.navigationController pushViewController: ticketVC animated:YES];
    
}

#pragma mark--
#pragma mark--出票隐藏
- (void)OutOfTheTicketDelegate{
    //个人业务消失
    [personalVC removeFromParentViewController];
    [personalVC.view removeFromSuperview];
    
    [self pushToGetTicketVC];

}

- (void)OutOfEnterpriseBusinessTicketDelegate{
    //企业业务
    [enterpriseVC removeFromParentViewController];
    [enterpriseVC.view removeFromSuperview];
    
    [self pushToGetTicketVC];

}

//消失业务视图
-(void)dismissPresentVC{

    //个人业务消失
    [personalVC removeFromParentViewController];
    [personalVC.view removeFromSuperview];
    
    //企业业务
    [enterpriseVC removeFromParentViewController];
    [enterpriseVC.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
