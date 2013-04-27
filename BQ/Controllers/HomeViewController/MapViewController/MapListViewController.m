//
//  MapListViewController.m
//  BQ
//
//  Created by Zoe on 13-4-8.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MapListViewController.h"
#import "HomeViewController.h"

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
    
    _bankTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleImgView.frame.size.width,titleImgView.frame.size.height)];
    if (SubLocality ==NULL) {
        [_bankTitleLabel setText:@"上海市"];
    }else
        [_bankTitleLabel setText:SubLocality];
    [_bankTitleLabel setFont:[UIFont systemFontOfSize:11]];
    [_bankTitleLabel setBackgroundColor:[UIColor clearColor]];
    [_bankTitleLabel setTextColor:[UIColor whiteColor]];
    [_bankTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleImgView addSubview:_bankTitleLabel];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleImgView.frame.origin.y+titleImgView.frame.size.height-4, self.view.frame.size.width, self.view.frame.size.height-44-49-titleImgView.frame.size.height+4) style:UITableViewStylePlain];
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
    
    Bank *bank = [self.locationArrs objectAtIndex:indexPath.row];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 310, 45)];
    [lineImageView setImage:[UIImage imageNamed:@"banktableViewCell"]];
    [cell addSubview:lineImageView];
    
    UILabel *_bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, lineImageView.frame.size.width-160,lineImageView.frame.size.height)];
    [_bankLabel setText:bank.bankName];
    [_bankLabel setFont:[UIFont systemFontOfSize:15]];
    [_bankLabel setBackgroundColor:[UIColor clearColor]];
    [_bankLabel setTextColor:[UIColor colorWithRed:65/255 green:75/255 blue:85/255 alpha:1.0f]];
    [_bankLabel setTextAlignment:NSTextAlignmentLeft];
    [cell addSubview:_bankLabel];
    
    //距离需要动态获取--协调
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(310-85, 20, 50,lineImageView.frame.size.height)];
    [distanceLabel setText:[NSString stringWithFormat:@"%0.2fkm",bank.distance]];
    [distanceLabel setFont:[UIFont systemFontOfSize:15]];
    [distanceLabel setBackgroundColor:[UIColor clearColor]];
    [distanceLabel setTextColor:[UIColor colorWithRed:65/255 green:75/255 blue:85/255 alpha:1.0f]];
    [distanceLabel setTextAlignment:NSTextAlignmentLeft];
    [distanceLabel sizeThatFits:CGSizeMake(50,lineImageView.frame.size.height)];
    [cell addSubview:distanceLabel];

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Bank *bank;
    bank = [self.locationArrs objectAtIndex:indexPath.row];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.bank = bank;
    [self.navigationController pushViewController:homeVC animated:YES];
    
}

#pragma mark--
#pragma mark--LocationManagerDelegate
- (void)locationReceivedFromLocationManagerDelegate:(NSString *)SubLocalityName{
    if (SubLocalityName!=NULL) {
        [_bankTitleLabel setText:[NSString stringWithFormat:@"%@",SubLocalityName]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
