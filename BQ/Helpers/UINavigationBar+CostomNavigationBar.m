//
//  UINavigationBar+CostomNavigationBar.m
//  BQ
//
//  Created by Zoe on 13-4-1.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "UINavigationBar+CostomNavigationBar.h"

@implementation UINavigationBar (CostomNavigationBar)

- (void)drawRect:(CGRect)rect{

    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"backArrows"] forState:UIControlStateNormal];
    [_button setFrame:CGRectMake(0, 0, 38/2, 20)];
    [_button addTarget:self action:@selector(backToLastVC) forControlEvents:UIControlEventTouchUpInside];
    
    

}

@end
