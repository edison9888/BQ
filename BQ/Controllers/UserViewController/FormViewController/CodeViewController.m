//
//  CodeViewController.m
//  BQ
//
//  Created by Zoe on 13-5-22.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "CodeViewController.h"
#import "QRCodeGenerator.h"

@interface CodeViewController ()

@end

@implementation CodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(0, 0, 100, 50)];
    [btn addTarget:self action:@selector(qrCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)qrCodeClick:(id)sender{
    NSString *infoStr = @"今天星期3";
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,50, 200, 200)];
    imageView.backgroundColor = [UIColor yellowColor];
    imageView.image = [QRCodeGenerator qrImageForString:infoStr imageSize:imageView.bounds.size.width];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
