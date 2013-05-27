//
//  FormViewController.h
//  BQ
//
//  Created by Zoe on 13-5-22.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "Number.h"
@interface FormViewController : RootViewController<UIWebViewDelegate>
{
    UIWebView *webView ;

}

@property(nonatomic,strong) Number *number;
@end
