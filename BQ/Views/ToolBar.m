//
//  ToolBar.m
//  BQ
//
//  Created by Zoe on 13-4-3.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "ToolBar.h"

@implementation ToolBar

//#define TabBarHeight 49

- (id)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController
{
    self = [super initWithFrame:frame];
    if (self) {
    
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBar"]];
        [bgImageView setFrame:CGRectMake(0, 0, 320, TabBarHeight)];
        bgImageView.userInteractionEnabled=YES;
        [self addSubview:bgImageView];
        
        UIButton *areaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [areaBtn setFrame:CGRectMake(6, 9, 54, 35)];
        [areaBtn setTitle:@"" forState:UIControlStateNormal];
        [areaBtn setBackgroundImage:[UIImage imageNamed:@"tabBarButton"] forState:UIControlStateNormal];
        [areaBtn setBackgroundImage:[UIImage imageNamed:@"tabBarButtonSelected"] forState:UIControlStateSelected];
        [areaBtn addTarget:viewController action:@selector(selectAreas) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView addSubview:areaBtn];
        
        UIButton *location = [UIButton buttonWithType:UIButtonTypeCustom];
        [location setFrame:CGRectMake(245+18, areaBtn.frame.origin.y, 54, 35)];
        [location setBackgroundImage:[UIImage imageNamed:@"tabBarButtonLocation"] forState:UIControlStateNormal];
        [location setBackgroundImage:[UIImage imageNamed:@"tabBarButtonLocationSelected"] forState:UIControlStateSelected];
        [location addTarget:viewController action:@selector(locationSelf) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView addSubview:location];
        
    }
    return self;
}




@end
