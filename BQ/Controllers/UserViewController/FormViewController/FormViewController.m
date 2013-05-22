//
//  FormViewController.m
//  BQ
//
//  Created by Zoe on 13-5-22.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "FormViewController.h"
#import "BQNetClient.h"
#import "Form.h"
#import "GTMBase64.h"

@interface FormViewController ()

@end

@implementation FormViewController

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
//    NSString *bundle = [[NSBundle mainBundle] pathForResource:@"1.txt" ofType:nil];
//    NSData *data = [[NSData alloc]initWithContentsOfFile:bundle];
    NSURLRequest *request = [BQNetClient getHtmlUrl];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(setPersonalInfo:)];

    webView =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.delegate=self;
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
}

//获取信息并加密
- (void)getHtmlInfomationWithEncode{
    
    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('text').value"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:str,@"name",nil];
    
    NSString *dicStr =[NSString stringWithFormat:@"%@", dic];
    
    NSData *data = [dicStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString* encoded = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    NSLog(@"encoded:%@", encoded);
    NSString* decoded = [[NSString alloc] initWithData:[GTMBase64 decodeString:encoded] encoding:NSUTF8StringEncoding];
    NSLog(@"decoded:%@", decoded);
    
}


- (void)setPersonalInfo:(id)sender{
        
    [self getHtmlInfomationWithEncode];
    
    
    [Form sendPersonalInfo:nil WithBlock:^{
        
    }];
   
}

- (BOOL)webView:(UIWebView *)_webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)_webView{
//    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    
//    NSLog(@"title=%@",title);
//    //NSString *st = [ webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('field_1').value"];
//    
//    NSString *st = [_webView stringByEvaluatingJavaScriptFromString:@"document.myform.input1.value"];
//    NSLog(@"st =%@",st);
//    //添加数据
//    NSString *str1 = [_webView stringByEvaluatingJavaScriptFromString:@"var field = document.getElementById('field_2');"
//                      "field.value='通过OC代码写入';"];
//    
//    NSLog(@"str1%@",str1);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
