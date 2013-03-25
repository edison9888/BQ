//
//  MainViewController.m
//  BQ
//
//  Created by zzlmilk on 13-3-25.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
    label.text =@"排队";
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    
}
@end
