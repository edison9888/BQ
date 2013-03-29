//
//  FastCell.m
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "FastCell.h"

@interface ContentView : UIView
@end

@implementation ContentView

-(void)drawRect:(CGRect)rect
{
    [(FastCell*)[self superview] drawContentView:rect];
}

@end


@implementation FastCell

@synthesize contentView;
@synthesize backView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        backView = [[UIView alloc]initWithFrame:CGRectZero];
        backView.opaque = YES;
        [self addSubview:backView];
        
        contentView = [[ContentView alloc]initWithFrame:CGRectZero];
        contentView.opaque =YES;
        [self addSubview:contentView];
        
      
        
      
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    CGRect b = [self bounds];
    b.size.height -=1;
    
    [backView setFrame:b];
    [contentView setFrame:b];
    [self setNeedsDisplay];
}

-(void)setNeedsDisplay{
    [super setNeedsDisplay];
    [backView setNeedsDisplay];
    [contentView setNeedsDisplay];
}


-(void)drawContentView:(CGRect)r{
    // subclasses should implement this
}

@end
