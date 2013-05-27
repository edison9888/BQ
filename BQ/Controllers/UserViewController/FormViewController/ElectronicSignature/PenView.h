//
//  PenView.h
//  HtmlText
//
//  Created by Zoe on 13-5-24.
//  Copyright (c) 2013年 Zoe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PenTool.h"

#define kDefaultLineColor       [UIColor blackColor]
#define kDefaultLineWidth       3.0f;
#define kDefaultLineAlpha       1.0f

@interface PenView : UIView

@property (nonatomic, assign) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat lineAlpha;

// get the current drawing
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, readonly) NSUInteger undoSteps;


@property (nonatomic, strong) PenTool *currentTool;

@end
