//
//  MapListViewController.m
//  BQ
//
//  Created by Zoe on 13-4-8.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MapListViewController.h"

@interface MapListViewController ()

@end

@implementation MapListViewController

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
	// Do any additional setup after loading the view.
    
    UIImageView *titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 27)];
    [titleImgView setImage:[UIImage imageNamed:@"districtAlert"]];
    [self.view addSubview:titleImgView];
    
    UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleImgView.frame.size.width,titleImgView.frame.size.height)];
    [bankLabel setText:@"闵行区"];
    [bankLabel setFont:[UIFont systemFontOfSize:11]];
    [bankLabel setBackgroundColor:[UIColor clearColor]];
    [bankLabel setTextColor:[UIColor whiteColor]];
    [bankLabel setTextAlignment:NSTextAlignmentCenter];
    [titleImgView addSubview:bankLabel];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleImgView.frame.origin.y+titleImgView.frame.size.height-8, self.view.frame.size.width, self.view.frame.size.height-44-49-26) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark--
#pragma mark--TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.locationArrs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //    if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    Bank *bank = [[Bank alloc] init];
    bank = [self.locationArrs objectAtIndex:indexPath.row];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 310, 45)];
    [lineImageView setImage:[UIImage imageNamed:@"tableViewCell"]];
    [cell addSubview:lineImageView];
    
    UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, lineImageView.frame.size.width-30,lineImageView.frame.size.height)];
    [bankLabel setText:bank.title];
    [bankLabel setFont:[UIFont systemFontOfSize:15]];
    [bankLabel setBackgroundColor:[UIColor clearColor]];
    [bankLabel setTextColor:[UIColor colorWithRed:65/255 green:75/255 blue:85/255 alpha:1.0f]];
    [bankLabel setTextAlignment:NSTextAlignmentLeft];
    [cell addSubview:bankLabel];
    
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Bank *bank;
    bank = [self.locationArrs objectAtIndex:indexPath.row];
    
    _homeVC.bankNameLabel.text = bank.title;

    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
