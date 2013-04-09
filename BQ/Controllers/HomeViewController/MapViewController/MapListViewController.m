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
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

#pragma mark--
#pragma mark--TableViewDelegate
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
    
    UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,116/2)];
    [bankLabel setText:bank.title];
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
