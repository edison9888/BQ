//
//  SelectBankViewController.m
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "SelectBankViewController.h"

@interface SelectBankViewController ()

@end

@implementation SelectBankViewController

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
    
    self.title =@"选择银行";
    
	// Do any additional setup after loading the view.
    /*
    UIImageView *homeBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectBank"]];
    homeBG.frame  = self.view.bounds;    
    [self.view addSubview:homeBG];
    
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame =CGRectMake(0, 0, 100, 100);
    [self.view addSubview:backButton];
     
     [self.navigationItem setHidesBackButton:YES];
     
     UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     //  backBtn.backgroundColor = [UIColor yellowColor];
     backBtn.frame = CGRectMake(30, 0, 30, 20);
     [backBtn setBackgroundImage:[UIImage imageNamed:@"backArrows"] forState:UIControlStateNormal];
     [backBtn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
     backBtn.backgroundColor = [UIColor blackColor];
     UIBarButtonItem*back=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
     
     self.navigationItem.leftBarButtonItem=back;
     
     */
    
    
    
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
