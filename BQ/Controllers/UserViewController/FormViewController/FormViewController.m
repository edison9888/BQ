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

#import "SignViewController.h"
#import "CodeViewController.h"

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

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100, 0, 100, 30)];
    [btn setBackgroundColor:[UIColor yellowColor]];
    [btn addTarget:self action:@selector(signClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar  addSubview:btn];
      
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(setPersonalInfo:)];

    webView =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.delegate=self;
//    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    //加载html界面
    [self getHtmlData];
    
}

- (void)getHtmlData{

    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys: _number.numId,@"numid", nil];
    
    [Form getPersonalForm:dic WithBlock:^(NSData *data) {
        
        [webView loadData:data MIMEType:nil textEncodingName:nil baseURL:nil];
    }];

}

//获取信息并加密
- (NSString *)getHtmlInfomationWithEncode{
    
    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('text').value"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:str,@"name",nil];
    
    NSString *dicStr =[NSString stringWithFormat:@"%@", dic];
    
    NSData *data = [dicStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString* encoded = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    NSLog(@"encoded:%@", encoded);
//    NSString* decoded = [[NSString alloc] initWithData:[GTMBase64 decodeString:encoded] encoding:NSUTF8StringEncoding];
//    NSLog(@"decoded:%@", decoded);
    return encoded;
}

//个人信息
- (void)setPersonalInfo:(id)sender{
        
    NSString *encoded = [self getHtmlInfomationWithEncode];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:encoded,@"formcon",_number.numId,@"numid", nil];
    
    [Form sendPersonalInfo:dic WithBlock:^{
        
        
    }];
   
}

//签名
-(void)signClick{
    SignViewController *signVC = [[SignViewController alloc] init];
    [self.navigationController pushViewController:signVC animated:YES];
    
//    CodeViewController *signVC = [[CodeViewController alloc] init];
//    [self.navigationController pushViewController:signVC animated:YES];
    
}

#pragma mark--
#pragma mark--WebViewDelegate
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
