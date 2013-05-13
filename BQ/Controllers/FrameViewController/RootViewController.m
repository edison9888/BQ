//
//  RootViewController.m
//  BQ
//
//  Created by Zoe on 13-5-10.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "RootViewController.h"
#import "Helper.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Helper leftBarButtonItem:self];
}

//返回上一层
- (void)backToLastVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
