//
//  FastCell.h
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FastCell : UITableViewCell
{
    
}

@property(nonatomic,strong) UIView *backView;
@property(nonatomic,strong) UIView *contentView;

-(void)drawContentView:(CGRect)r;


@end
