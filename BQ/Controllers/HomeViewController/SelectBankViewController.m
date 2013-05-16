//
//  SelectBankViewController.m
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "SelectBankViewController.h"
#import "MapViewController.h"
#import "Helper.h"
#import "FatherBank.h"
#import "AppDelegate.h"
#import "SetViewController.h"

@interface SelectBankViewController ()

@end

@implementation SelectBankViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
//        self.banksArr = [NSArray arrayWithObjects:@"中国工商银行",@"中国农业银行",@"浦发银行",@"中信银行",@"交通银行",@"中国邮政储蓄银行", nil];
        self.banksArr = [NSArray array];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[AppDelegate getAppdelegate] setNavigateBarHidden:NO];
    
    self.title =@"选择银行";
    
    self.tableView.backgroundView=nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
	
    self.navigationItem.leftBarButtonItem = [Helper leftBarButtonItem:self];
    self.navigationItem.rightBarButtonItem = [Helper rightBarButtonItemWithSetButton:self];
    
    //调用接口 获得banksArr 解析存放fatherBank类
    [FatherBank getAllBankInfo:nil WithBlock:^(NSArray *arr) {
        
        self.banksArr = arr;
        [self.tableView reloadData];
    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if([_delegate respondsToSelector:@selector(hidenTabbar:)])
//    {
//        [_delegate hidenTabbar:NO];
//    }
}

//返回上一层
- (void)backToLastVC{
    [self.navigationController popViewControllerAnimated:YES];
}

//跳转设置界面
-(void)turnToSetViewController{
    
    SetViewController *setVC = [[SetViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];

}

#pragma mark--
#pragma mark--TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.banksArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 315, 45)];
        [lineImageView setImage:[UIImage imageNamed:@"tableViewCell"]];
        [cell addSubview:lineImageView];
        
        UIImageView *selectImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableViewCellSelect"]];
        [selectImageView setFrame:CGRectMake(5, 8, 310, 45)];
        
        UIImageView*bgSelectImageView =[[UIImageView alloc] initWithFrame:cell.frame];
        [bgSelectImageView addSubview:selectImageView];
        
        cell.selectedBackgroundView = bgSelectImageView;
        
        FatherBank *fatherBank = [self.banksArr objectAtIndex:indexPath.row];
        
        UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, lineImageView.frame.size.width-30,lineImageView.frame.size.height)];
        [bankLabel setText:fatherBank.bankTypeName];
    //    [bankLabel setText:fatherBank.fatherBankName];
        [bankLabel setFont:[UIFont systemFontOfSize:15]];
        [bankLabel setBackgroundColor:[UIColor clearColor]];
        [bankLabel setTextColor:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1.0f]];
        [bankLabel setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:bankLabel];    
    
        if (cell.isSelected) {
            bankLabel.textColor=[UIColor colorWithRed:93/255 green:93/255 blue:93/255 alpha:1.0f];
        }
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FatherBank *fatherBank = [self.banksArr objectAtIndex:indexPath.row];

    MapViewController *mapVC = [[MapViewController alloc] init];
    mapVC.homeVC=(HomeViewController *)_delegate;
    mapVC.fatherBank=fatherBank;
    [self.navigationController pushViewController:mapVC animated:YES];
    
}

#pragma mark--
#pragma mark--release memory
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    _banksArr=nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
