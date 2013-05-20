//
//  AboutUsViewController.m
//  BQ
//
//  Created by Zoe on 13-4-16.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "AboutUsViewController.h"
#import "Helper.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (id)init
{
    self = [super init];
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

    self.title = @"关于我们";
    
    //背景图
    UIImageView *homeBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-NavigationHeight)];
    homeBG.userInteractionEnabled =YES;
    if (iPhone5) {
        homeBG.image = [UIImage imageNamed:@"aboutIp5"];
    }else
        homeBG.image = [UIImage imageNamed:@"aboutIphone4@2x"];
    [self.view addSubview:homeBG];

}


#pragma mark--
#pragma mark--release memory
- (void)viewDidUnload
{
    [super viewDidUnload];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && self.view.window == nil) {
        self.view = nil;
    }

}

@end
