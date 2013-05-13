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
    [_button setBackgroundImage:[UIImage imageNamed:@"backArrowsSelect"] forState:UIControlStateSelected];
    [_button setFrame:CGRectMake(0, 0, 54, 35)];
    [_button addTarget:sender action:@selector(backToLastVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:_button];

    return barItem;
}

+ (UIBarButtonItem *)rightBarButtonItem:(id)sender{
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"mapButton"] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageNamed:@"mapButtonSelected"] forState:UIControlStateSelected];
    [_button setFrame:CGRectMake(0, 0, 54, 35)];
    [_button addTarget:sender action:@selector(turnToListVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:_button];
    
    return barItem;
}

+ (UIBarButtonItem *)rightBarButtonItemListIcon:(id)sender{
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"maplistButton@2x"] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageNamed:@"maplistButtonSelected@2x"] forState:UIControlStateSelected];
    [_button setFrame:CGRectMake(0, 0, 54,35)];
    [_button addTarget:sender action:@selector(turnToListVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:_button];
    
    return barItem;
}

+ (UIBarButtonItem *)rightBarButtonItemWithSetButton:(id)sender{
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"setButton@2x"] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageNamed:@"setButtonSelected@2x"] forState:UIControlStateSelected];
    [_button setFrame:CGRectMake(0, 0, 54,35)];
    [_button addTarget:sender action:@selector(turnToSetViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:_button];
    
    return barItem;
}


@end
