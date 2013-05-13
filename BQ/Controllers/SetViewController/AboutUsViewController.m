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
    
//    //背景图
//    UIImageView *homeBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beiJing"]];
//    homeBG.frame  = self.view.bounds;
//    homeBG.userInteractionEnabled =YES;
//    [self.view addSubview:homeBG];
    

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
    // Dispose of any resources that can be recreated.
}

@end
