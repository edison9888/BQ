//
//  MapListViewController.m
//  BQ
//
//  Created by Zoe on 13-4-8.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MapListViewController.h"
#import "HomeViewController.h"
#import "NearBankCell.h"

@interface MapListViewController ()

@end

@implementation MapListViewController

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
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.backgroundView=nil;
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

    if (!cell) {
        cell = [[NearBankCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    Bank *bank = [self.locationArrs objectAtIndex:indexPath.row];

    UIImageView *bgImageView =[[UIImageView alloc] initWithFrame:cell.frame];
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 310, 45)];
    [lineImageView setImage:[UIImage imageNamed:@"tableViewCell"]];
    [bgImageView addSubview:lineImageView];
    
    UIImageView *selectImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableViewCellSelect"]];
    [selectImageView setFrame:CGRectMake(5, 5, 310, 45)];
    UIImageView*bgSelectImageView =[[UIImageView alloc] initWithFrame:cell.frame];
    [bgSelectImageView addSubview:selectImageView];
    
    cell.backgroundView=bgImageView;
    cell.selectedBackgroundView = bgSelectImageView;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", bank.address];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:93/255 green:93/255 blue:93/255 alpha:1.0f];
    

    cell.detailTextLabel.text = [NSString stringWithFormat:@"%0.2fkm",bank.distance];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.highlightedTextColor = [UIColor colorWithRed:93/255 green:93/255 blue:93/255 alpha:1.0f];
    [cell.detailTextLabel sizeToFit];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Bank *bank;
    bank = [self.locationArrs objectAtIndex:indexPath.row];
    
    __autoreleasing HomeViewController *homeVC = [[HomeViewController alloc] init];
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

#pragma mark--
#pragma mark--release memory
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    _homeVC=nil;
    _locationArrs=nil;
    _bank=nil;
    _tableView=nil;
    _bankTitleLabel=nil;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
