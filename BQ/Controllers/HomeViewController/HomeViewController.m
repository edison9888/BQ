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
#import "Business.h"
#import "UIImage+UIImageName.h"

#import "FXButton.h"


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
    self.title = @"选择业务";
        
    //背景图
//    [self bankbackGroundImageView];
    
    UIImageView *logoImageView =[[UIImageView alloc] initWithFrame:CGRectMake(52,73, 37, 38)];
    [logoImageView setImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:logoImageView];    
    
    _bankNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(logoImageView.frame.size.width+logoImageView.frame.origin.x+7,77, 185, 35)];
    if (_bank.bankName!=nil) {
        _bankNameLabel.text=_bank.bankTypeName;
    }else{
        _bankNameLabel.text=@"中国工商银行";
    }
    _bankNameLabel.backgroundColor=[UIColor clearColor];
    _bankNameLabel.font = [UIFont systemFontOfSize:28];
    _bankNameLabel.textColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0];
//    [_bankNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_bankNameLabel sizeThatFits:CGSizeMake(239, 35)];
    [self.view addSubview:_bankNameLabel];
    
    UILabel *detailBankAddress = [[UILabel alloc] initWithFrame:CGRectMake(55,_bankNameLabel.frame.size.height+_bankNameLabel.frame.origin.y+10,210,15)];
    [detailBankAddress setBackgroundColor:[UIColor clearColor]];
    [detailBankAddress setTextAlignment:NSTextAlignmentCenter];
    detailBankAddress.textColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0];
    [detailBankAddress setText:_bank.address];
    [detailBankAddress setFont:[UIFont systemFontOfSize:14.0f]];
    [detailBankAddress setNumberOfLines:0];
    [self.view addSubview:detailBankAddress];
    
//    FXButton *fxBtn = [FXButton buttonWithType:UIButtonTypeCustom];
//    [fxBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
//    [fxBtn setFrame:CGRectMake(42, self.view.frame.size.height-206, 251, 65.5)];
//    [fxBtn setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
//    [fxBtn setBackgroundImage:[UIImage imageFromMainBundleFile:@"personalButton@2x"] forState:UIControlStateNormal];
//    [fxBtn setBackgroundImage:[UIImage imageFromMainBundleFile:@"personalButtonSelected@2x"] forState:UIControlStateSelected];
//    [fxBtn setTitle:@"个人业务" forState:UIControlStateNormal];
//    [fxBtn setTitleColor:[UIColor colorWithRed:119/255.0f green:68/255.0f blue:39/255.f alpha:1.0f] forState:UIControlStateNormal];
//    [fxBtn setDefaults];
////    fxBtn.titleLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
////    fxBtn.titleLabel.shadowOffset = CGSizeMake(1.0f, 2.0f);
//    fxBtn.shadowBlur = 1.0f;
//    fxBtn.innerShadowColor = [UIColor colorWithRed:82/255.0f green:180/255.0f blue:57/255.f alpha:1.0f];
//    fxBtn.innerShadowOffset = CGSizeMake(1.0f, 2.0f);
//    [self.view addSubview:fxBtn];
    
    
    UIButton *personalBusinessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    personalBusinessBtn.enabled=NO;
//    [personalBusinessBtn setTitle:@"个人业务" forState:UIControlStateNormal];
    [personalBusinessBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
    [personalBusinessBtn setFrame:CGRectMake(42, self.view.frame.size.height-206, 251, 65.5)];
    [personalBusinessBtn setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [personalBusinessBtn addTarget:self action:@selector(personalBusinessClick:) forControlEvents:UIControlEventTouchUpInside];
    [personalBusinessBtn setBackgroundImage:[UIImage imageFromMainBundleFile:@"personalButton@2x"] forState:UIControlStateNormal];
    [personalBusinessBtn setBackgroundImage:[UIImage imageFromMainBundleFile:@"personalButtonSelected@2x"] forState:UIControlStateSelected];
    [personalBusinessBtn setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f] forState:UIControlStateNormal];
    [personalBusinessBtn setTitleColor:[UIColor colorWithRed:119/255.0f green:68/255.0f blue:39/255.f alpha:1.0f] forState:UIControlStateHighlighted];
//    [personalBusinessBtn setTitleShadowColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5f] forState:UIControlStateHighlighted];
    [personalBusinessBtn setTitleShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f] forState:UIControlStateHighlighted];
    [personalBusinessBtn.titleLabel setShadowOffset:CGSizeMake(0.3f,0.1f)];
    personalBusinessBtn.tag=11;
    [self.view addSubview:personalBusinessBtn];
    
    UIButton *enterpriseBusinessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    enterpriseBusinessBtn.enabled=NO;
//    [enterpriseBusinessBtn setTitle:@"企业业务" forState:UIControlStateNormal];
    [enterpriseBusinessBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
    [enterpriseBusinessBtn setFrame:CGRectMake(personalBusinessBtn.frame.origin.x,self.view.frame.size.height-128, personalBusinessBtn.frame.size.width, personalBusinessBtn.frame.size.height)];
    [enterpriseBusinessBtn setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [enterpriseBusinessBtn addTarget:self action:@selector(enterpriseBusinessClick:) forControlEvents:UIControlEventTouchUpInside];
    [enterpriseBusinessBtn setBackgroundImage:[UIImage imageFromMainBundleFile:@"businessButton@2x"] forState:UIControlStateNormal];
    [enterpriseBusinessBtn setBackgroundImage:[UIImage imageFromMainBundleFile:@"businessButtonSelected@2x"] forState:UIControlStateSelected];
    [enterpriseBusinessBtn setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f] forState:UIControlStateNormal];
    [enterpriseBusinessBtn setTitleColor:[UIColor colorWithRed:119/255.0f green:68/255.0f blue:39/255.f alpha:1.0f] forState:UIControlStateHighlighted];
    [enterpriseBusinessBtn setTitleShadowColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5f] forState:UIControlStateHighlighted];
    [enterpriseBusinessBtn setTitleShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f] forState:UIControlStateHighlighted];
    [enterpriseBusinessBtn.titleLabel setShadowOffset:CGSizeMake(0.3f,0.1f)];
    enterpriseBusinessBtn.tag=12;
    [self.view addSubview:enterpriseBusinessBtn];
    
//    self.navigationItem.leftBarButtonItem = [Helper leftBarButtonItem:self];
    
    //调用接口
    [self getBusinessFromNet:personalBusinessBtn :enterpriseBusinessBtn];
}

//初始化子业务控制器
- (void)initPersonalVC{
    if (personalVC==nil) {
        personalVC = [[PersonalBusinessViewController alloc] init];
        personalVC.delegate=self;
        [self addChildViewController:personalVC];

    }
}

//调用接口
- (void)getBusinessFromNet:(UIButton *)personalBtn :(UIButton *)enterpriseBtn{
    
    [Business getfatherService:nil WithBlock:^(NSArray *arr) {
        
        _fatherBusinessArr=arr;

        Business *business;
        for (int i=0; i<_fatherBusinessArr.count; i++) {
            business=[_fatherBusinessArr objectAtIndex:i];
            if (i==0) 
                [personalBtn setTitle:business.serviceName forState:UIControlStateNormal];
            else
                [enterpriseBtn setTitle:business.serviceName forState:UIControlStateNormal];
        }
        
    }];
}



//返回上一层
- (void)backToLastVC{
    [self.navigationController popViewControllerAnimated:YES];
}

//#pragma mark--
//#pragma mark--MyTicketRefreshDelegate
////刷新票数据----刷新单张还是多张
- (void)refreshTicketsDelegate:(Number *)number btnIndex:(NSInteger)index{
//
}

//-(void)bankbackGroundImageView{
//    UIImage *image;
//    if (iPhone5)
//        image= [UIImage imageNamed:@"back4"];
//    else
//        image= [UIImage imageNamed:@"back5"];
//
//    UIImageView *homeBG = [[UIImageView alloc]initWithImage:image];
//    homeBG.userInteractionEnabled =YES;
//    homeBG.frame = self.view.bounds;
//    [self.view addSubview:homeBG];
//}

////更改首页银行提示
//- (void)setBank:(Bank *)bank{
//    [_bankNameLabel setText:bank.title];
//    
//    //[self changeBtnState];
//}

//改变按钮状态--个人业务/企业业务
//-(void)changeBtnState{
//
//    UIButton *personalBusinessBtn,*enterpriseBusinessBtn;
//    if (isLocation) {
//        personalBusinessBtn =(UIButton*)[self.view viewWithTag:11];
//        enterpriseBusinessBtn =(UIButton*)[self.view viewWithTag:12];
//        personalBusinessBtn.enabled=YES;
//        enterpriseBusinessBtn.enabled=YES;
//        
//    }
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

   // [self hidenTabbar:NO];
}



#pragma mark--
#pragma mark--业务按钮事件
//个人业务
- (void)personalBusinessClick:(id)sender{
//    UIButton *btn =(UIButton *)sender;
//    btn.selected=!btn.selected;
//    
//    if (btn.selected) {
//        [btn setTitleColor:[UIColor colorWithRed:119/255.0f green:68/255.0f blue:39/255.f alpha:1.0f] forState:UIControlStateNormal];
//        [btn setTitleShadowColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5f] forState:UIControlStateNormal];
////        [btn setTitleShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f] forState:UIControlStateSelected];
//        [btn.titleLabel setShadowOffset:CGSizeMake(0.5f, 0)];
//        btn.selected=NO;
//    }
    
    //初始化子业务控制器
    [self initPersonalVC];
    
    personalVC.busniess=[_fatherBusinessArr objectAtIndex:0];
    
    if (debug) {
        NSLog(@"_fatherBusinessArr %@,service==%@==%@==%@",_fatherBusinessArr,personalVC.busniess,personalVC.busniess.serviceId,personalVC.busniess.serviceName);
    }
   
    personalVC.businessType=PersonalType;
    [self.view addSubview:personalVC.view];
}

//企业业务
- (void)enterpriseBusinessClick:(id)sender{
//    UIButton *btn =(UIButton *)sender;
//    btn.selected=!btn.selected;
//    
//    if (btn.selected) {
//        [btn setTitleColor:[UIColor colorWithRed:119/255.0f green:68/255.0f blue:39/255.f alpha:1.0f] forState:UIControlStateNormal];
//        [btn setTitleShadowColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5f] forState:UIControlStateNormal];
//        [btn.titleLabel setShadowOffset:CGSizeMake(0.5f, 0)];
//        
//        btn.selected=NO;
//    }
////    [self initPersonalVC];
//
//    personalVC.busniess=[_fatherBusinessArr objectAtIndex:1];
//    personalVC.businessType=EnterPriseType;
//    [self.view addSubview:personalVC.view];
//    personalVC.view.frame=self.view.frame;
    Business *business = [_fatherBusinessArr objectAtIndex:1];
    [self pushToGetTicketVC:business];
}


//调转领票界面
- (void)pushToGetTicketVC:(Business *)bus{
    
    GetTicketViewController *ticketVC = [[GetTicketViewController alloc] init];
    ticketVC.busniess=bus;
    ticketVC.bank=_bank;
    [self.navigationController pushViewController: ticketVC animated:YES];
    
}

#pragma mark--
#pragma mark--出票隐藏
- (void)OutOfTheTicketDelegate:(Business *)bus{
    //个人业务消失
    [personalVC removeFromParentViewController];
    [personalVC.view removeFromSuperview];
    
    [self pushToGetTicketVC:(Business *)bus];

}

//- (void)OutOfEnterpriseBusinessTicketDelegate{
//    //企业业务
//    [enterpriseVC removeFromParentViewController];
//    [enterpriseVC.view removeFromSuperview];
//    
//    [self pushToGetTicketVC];
//
//}

//消失业务视图
-(void)dismissPresentVC{

    //个人业务消失
    [personalVC removeFromParentViewController];
    [personalVC.view removeFromSuperview];
    
//    //企业业务
//    [enterpriseVC removeFromParentViewController];
//    [enterpriseVC.view removeFromSuperview];
}

#pragma mark--
#pragma mark--release memory
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    personalVC=nil;
    _bankNameLabel=nil;

    _viewController=nil;
    _bank=nil;
    _fatherBusinessArr=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && self.view.window == nil) {
        self.view = nil;
    }
    _fatherBusinessArr=nil;

}

@end
