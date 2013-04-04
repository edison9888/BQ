//
//  HomeViewController.m
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "HomeViewController.h"
#import "MapViewController.h"
#import "SelectBankViewController.h"

#import "TestView.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        /*
        UIImageView *homeBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home"]];
        homeBG.frame  = self.view.bounds;
        
        [self.view addSubview:homeBG];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(224, 200, 100, 100)];
        [self.view addSubview:button];
        */
    }
    return self;
}

-(void)buttonPress{
    
   
    SelectBankViewController  *selectBankVC = [[SelectBankViewController alloc]init];
    [self.navigationController pushViewController:selectBankVC animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"首页";
    
    UIImageView *homeBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beiJing"]];
    homeBG.frame  = self.view.bounds;
    homeBG.userInteractionEnabled =YES;
    [self.view addSubview:homeBG];

        
    UIImageView *no07BG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"07"]];
    no07BG.frame  = CGRectMake(80, 16, 150, 139);
    no07BG.alpha = 0.3f;
    [homeBG addSubview:no07BG];
    
    
    
    UIImageView *bankNameImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 165, 327/2, 65/2)];
    bankNameImageView.image=[UIImage imageNamed:@"bankName"];
    [homeBG addSubview:bankNameImageView];
    
    
    
    _bankNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,2, 150, 30)];
    _bankNameLabel.text=@"选择您所需要的银行";
    _bankNameLabel.backgroundColor=[UIColor clearColor];
    _bankNameLabel.font = [UIFont systemFontOfSize:14];
    _bankNameLabel.textColor = [UIColor colorWithRed:173/255.f green:172/255.f blue:172/255.f alpha:1.0];
    
    [bankNameImageView addSubview:_bankNameLabel];
    
    
    UIButton *selectBankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBankButton addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchUpInside];
    [selectBankButton setImage:[UIImage imageNamed:@"mapBtn"] forState:UIControlStateNormal];
    [selectBankButton setFrame:CGRectMake(bankNameImageView.frame.size.width+bankNameImageView.frame.origin.x,bankNameImageView.frame.origin.y-10, 33, 42)];
    [homeBG addSubview:selectBankButton];
    
    UIButton *personalBusinessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [personalBusinessBtn setFrame:CGRectMake(118/2, selectBankButton.frame.size.height+selectBankButton.frame.origin.y+30, 390/2, 87/2)];
    [personalBusinessBtn addTarget:self action:@selector(personalBusinessClick:) forControlEvents:UIControlEventTouchUpInside];
    [personalBusinessBtn setBackgroundImage:[UIImage imageNamed:@"xuanZeYeWuAnNiu"] forState:UIControlStateNormal];
    [self.view addSubview:personalBusinessBtn];
    
    UIButton *enterpriseBusinessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [enterpriseBusinessBtn setFrame:CGRectMake(personalBusinessBtn.frame.origin.x, personalBusinessBtn.frame.size.height+personalBusinessBtn.frame.origin.y+15, 390/2, 87/2)];
    [enterpriseBusinessBtn addTarget:self action:@selector(enterpriseBusinessClick:) forControlEvents:UIControlEventTouchUpInside];
    [enterpriseBusinessBtn setBackgroundImage:[UIImage imageNamed:@"xuanZeQiYeYeWuAnNiu"] forState:UIControlStateNormal];
    [self.view addSubview:enterpriseBusinessBtn];
    
    
    
}

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
    enterpriseVC.delegate=self;
    [self addChildViewController:enterpriseVC];
    enterpriseVC.view.frame=self.view.frame;
    [self.view addSubview:enterpriseVC.view];
    
}

#pragma mark--
#pragma mark--出票隐藏
- (void)OutOfTheTicketDelegate{
    //个人业务消失
    [personalVC.view removeFromSuperview];
    [personalVC removeFromParentViewController];

}

- (void)OutOfEnterpriseBusinessTicketDelegate{
    //企业业务
    [enterpriseVC.view removeFromSuperview];
    [enterpriseVC removeFromParentViewController];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
