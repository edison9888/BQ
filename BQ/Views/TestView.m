//
//  TestView.m
//  BQ
//
//  Created by zzlmilk on 13-3-27.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "TestView.h"
#import "UIColor+REXDebug.h"
@implementation TestView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       // self.backgroundColor = [UIColor randomColor];
        
        
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //这四行代码只是简单的测试drawRect中context的坐标系
    CGContextSetRGBFillColor(context, 1, 0, 1, 1);
    CGContextFillRect(context, CGRectMake(0, 200, 200, 100));
    

    CGContextSetTextMatrix(context, CGAffineTransformIdentity);//设置字形变换矩阵为CGAffineTransformIdentity，也就是说每一个字形都不做图形变换
    
    //    CGAffineTransform flipVertical = CGAffineTransformMake(1,0,0,-1,0,self.bounds.size.height);


    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0,0,-1,0, self.bounds.size.height);
    CGContextConcatCTM(context, flipVertical);//将当前context的坐标系进行flip
    
    
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
