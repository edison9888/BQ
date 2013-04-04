//
//  Helper.m
//  BQ
//
//  Created by Zoe on 13-4-3.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "Helper.h"

@implementation Helper


+ (UIBarButtonItem *)leftBarButtonItem:(UIViewController *)sender{

    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"backArrows"] forState:UIControlStateNormal];
    [_button setFrame:CGRectMake(0, 0, 38/2, 20)];
    [_button addTarget:sender action:@selector(backToLastVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:_button];

    return barItem;
}

+ (UIBarButtonItem *)rightBarButtonItem:(id)sender{
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"navBarIcon"] forState:UIControlStateNormal];
    [_button setFrame:CGRectMake(0, 0, 47/2, 16)];
    [_button addTarget:sender action:@selector(turnToListVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:_button];
    
    return barItem;
}


@end
