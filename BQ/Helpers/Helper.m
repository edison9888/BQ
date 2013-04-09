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
    [_button setFrame:CGRectMake(0, 0, 54, 35)];
    [_button addTarget:sender action:@selector(backToLastVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:_button];

    return barItem;
}

+ (UIBarButtonItem *)rightBarButtonItem:(id)sender{
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"mapListButton"] forState:UIControlStateNormal];
    [_button setFrame:CGRectMake(0, 0, 54, 35)];
    [_button addTarget:sender action:@selector(turnToListVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:_button];
    
    return barItem;
}

+ (UIBarButtonItem *)rightBarButtonItemListIcon:(id)sender{
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"mapButton"] forState:UIControlStateNormal];
    [_button setFrame:CGRectMake(0, 0, 54,35)];
    [_button addTarget:sender action:@selector(turnToListVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:_button];
    
    return barItem;
}

@end
