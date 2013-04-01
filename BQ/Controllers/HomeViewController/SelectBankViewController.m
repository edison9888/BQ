//
//  SelectBankViewController.m
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "SelectBankViewController.h"

@interface SelectBankViewController ()

@end

@implementation SelectBankViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.banksArr = [NSArray arrayWithObjects:@"中国工商银行",@"中国农业银行",@"浦发银行",@"中信银行",@"交通银行",@"中国邮政储蓄银行", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title =@"选择银行";
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
	// Do any additional setup after loading the view.
    /*
    UIImageView *homeBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectBank"]];
    homeBG.frame  = self.view.bounds;    
    [self.view addSubview:homeBG];
    
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame =CGRectMake(0, 0, 100, 100);
    [self.view addSubview:backButton];
     
     [self.navigationItem setHidesBackButton:YES];
     
     UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     //  backBtn.backgroundColor = [UIColor yellowColor];
     backBtn.frame = CGRectMake(30, 0, 30, 20);
     [backBtn setBackgroundImage:[UIImage imageNamed:@"backArrows"] forState:UIControlStateNormal];
     [backBtn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
     backBtn.backgroundColor = [UIColor blackColor];
     UIBarButtonItem*back=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
     
     self.navigationItem.leftBarButtonItem=back;
     
     */

    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"backArrows"] forState:UIControlStateNormal];
    [_button setFrame:CGRectMake(0, 0, 38/2, 20)];
    [_button addTarget:self action:@selector(backToLastVC) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:_button];
    self.navigationItem.leftBarButtonItem = barItem;


}

//返回上一层
- (void)backToLastVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116/2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.banksArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    if (!cell) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
//    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,116/2)];
    [bankLabel setText:[self.banksArr objectAtIndex:indexPath.row]];
    [bankLabel setFont:[UIFont systemFontOfSize:20]];
    [bankLabel setBackgroundColor:[UIColor clearColor]];
    [bankLabel setTextColor:[UIColor colorWithRed:75/255 green:85/255 blue:95/255 alpha:1.0f]];
    [bankLabel setTextAlignment:NSTextAlignmentCenter];
    [cell addSubview:bankLabel];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 116/2-2, cell.frame.size.width, 4)];
    [lineImageView setImage:[UIImage imageNamed:@"fenGeXxian"]];
    [cell addSubview:lineImageView];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
