//
//  SetViewController.m
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "SetViewController.h"
#import "AboutUsViewController.h"
#import "FeedBackViewController.h"
#import "NearBankCell.h"

@interface SetViewController ()

@end

@implementation SetViewController

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
    self.title=@"设置";
    
//    //背景图
//    UIImageView *homeBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beiJing"]];
//    homeBG.frame  = self.view.bounds;
//    homeBG.userInteractionEnabled =YES;
//    [self.view addSubview:homeBG];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundView=nil;
    tableView.backgroundColor=[UIColor clearColor];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    setArr = [NSMutableArray arrayWithObjects:@"关于我们",@"意见反馈",@"给我们评分", nil];
}
#pragma mark--
#pragma mark--TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return setArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
    
        cell = [[NearBankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    }
    
    UIImageView *bgImageView =[[UIImageView alloc] initWithFrame:cell.frame];
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 311, 45)];
    [lineImageView setImage:[UIImage imageNamed:@"tableViewCell"]];
    [bgImageView addSubview:lineImageView];
    
    UIImageView *selectImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableViewCellSelect"]];
    [selectImageView setFrame:CGRectMake(5, 5, 311, 45)];
    UIImageView*bgSelectImageView =[[UIImageView alloc] initWithFrame:cell.frame];
    [bgSelectImageView addSubview:selectImageView];
    
    cell.backgroundView=bgImageView;
    cell.selectedBackgroundView = bgSelectImageView;
    
    cell.textLabel.text = [NSString stringWithFormat:@" %@", [setArr objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:93/255 green:93/255 blue:93/255 alpha:1.0f];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //关于我们
    if (indexPath.row==0) {
        AboutUsViewController *aboutVC = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    //意见反馈
    if (indexPath.row==1) {
//        FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
//        [self.navigationController pushViewController:feedBackVC animated:YES];
    }
    //给我们评分
    if (indexPath.row==2) {
        
    }
}


#pragma mark--
#pragma mark--release memory
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    setArr=nil;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && self.view.window == nil) {
        self.view = nil;
    }
    setArr=nil;

}

@end
