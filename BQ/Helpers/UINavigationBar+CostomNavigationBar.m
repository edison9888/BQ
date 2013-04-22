//
//  UINavigationBar+CostomNavigationBar.m
//  BQ
//
//  Created by Zoe on 13-4-1.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//backArrows


#import "UINavigationBar+CostomNavigationBar.h"

@implementation UINavigationBar (CostomNavigationBar)

- (UIImage *)barBackground
{
    return [UIImage imageNamed:@"navigationBarQ"];
}


- (void)didMoveToSuperview
{
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self setBackgroundImage:[self barBackground] forBarMetrics:UIBarMetricsDefault];
    }
    
    

//    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_button setBackgroundImage:[UIImage imageNamed:@"backArrows"] forState:UIControlStateNormal];
//    [_button setFrame:CGRectMake(0, 0, 38/2, 20)];
//    [_button addTarget:self action:@selector(backToLastVC) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:_button];

    
//    UIColor *color = [UIColor groupTableViewBackgroundColor];
//    self.tintColor = color;

    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    NSDictionary *attr = [[NSDictionary alloc] initWithObjectsAndKeys:font, UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil];
    [self setTitleTextAttributes:attr];
    
}



@end
