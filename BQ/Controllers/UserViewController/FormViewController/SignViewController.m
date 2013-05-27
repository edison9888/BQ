//
//  SignViewController.m
//  BQ
//
//  Created by Zoe on 13-5-27.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "SignViewController.h"

#import "UIImage+ImageExt.h"
@interface SignViewController ()

@end

@implementation SignViewController

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(imageSavedToAlum)];

    penView =[[PenView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:penView];
    
}

- (void)imageSavedToAlum{
    
    UIImage *image = [UIImage imageFromView:self.view];
    UIImageWriteToSavedPhotosAlbum( image, self, @selector(image:didFinishSavingWithError:contextInfo:) , nil ) ;
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        NSLog(@"error%@",error);
    }
    else  // No errors
    {
        NSLog(@"seccess");
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alerView show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
