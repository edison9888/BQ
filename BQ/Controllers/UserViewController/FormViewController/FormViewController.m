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
//#import "NSData+Encryption.h"
//#import "FBEncryptorAES.h"//加密
//#import "NSData+AES256.h"
#import "NSString+DES.h"

#import "SignViewController.h"
#import "CodeViewController.h"
#import "QRCodeGenerator.h"


#define AES_BASE64_KEY @"20120401"


@interface FormViewController ()

@end

@implementation FormViewController

- (id)init
{
    self = [super init];
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

//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setFrame:CGRectMake(100, 0, 100, 30)];
//    [btn setBackgroundColor:[UIColor yellowColor]];
//    [btn addTarget:self action:@selector(signClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.navigationBar  addSubview:btn];
    
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

- (UIImage *)createQrCode:(NSString *)formStr{
    
    formStr =@"formStr";
    
    UIImage *image = [QRCodeGenerator qrImageForString:formStr imageSize:QR_WIDTH];
    
    [self imageSavedToDocument:image];
    
    return image;
}

- (void)imageSavedToDocument:(UIImage *)image{
    //保存到沙盒中
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",_number.numId]];   // 保存文件的名称
    BOOL result = [UIImagePNGRepresentation(image)writeToFile:filePath atomically:YES];
    NSLog(@"保存沙盒成功===%d",result);
    
    //保存相册
    //UIImageWriteToSavedPhotosAlbum( image, self, @selector(image:didFinishSavingWithError:contextInfo:) , nil ) ;
}

//获取信息并加密des+base64
- (NSString *)getEncode{
    
    NSString *formStr = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('text').value"];

//    formStr = [NSString stringWithFormat:@"{name:邹露,age:24,sex:女}"];
    
    if (formStr.length) {
        NSLog(@"填写信息不能为空");
        return 0;
    }else{
        
        _number.image = [self createQrCode:formStr];
        
        NSString *data64 = [NSString encryptUseDES:formStr key:AES_BASE64_KEY];
        NSLog(@"textEncode: %@", data64);
        
        NSString *decode = [NSString decryptUseDES:data64 key:AES_BASE64_KEY];
        NSLog(@"textDecode: %@", decode);    
        
        return data64;
    }
}

//个人信息
- (void)setPersonalInfo:(id)sender{
    //获得加密信息
    NSString *encoded = [self getEncode];
    if (encoded==0) {
        return;
    }

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
