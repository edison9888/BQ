//
//  FeedBackViewController.m
//  BQ
//
//  Created by Zoe on 13-4-16.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "FeedBackViewController.h"
#import "Helper.h"
#import <QuartzCore/QuartzCore.h>

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//返回上一层
- (void)backToLastVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title=@"意见反馈";
    
    self.navigationItem.leftBarButtonItem = [Helper leftBarButtonItem:self];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20,150)];
    textView.delegate=self;
    [textView setKeyboardType:UIKeyboardTypeDefault];
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.layer.borderWidth =2.0;
    textView.layer.cornerRadius =5.0;
    [textView becomeFirstResponder];
    [self.view addSubview:textView];
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    NSLog(@"textView===%@",textView.text);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
