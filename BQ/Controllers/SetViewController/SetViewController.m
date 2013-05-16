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

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, self.view.bounds.size.width-10, self.view.bounds.size.height) style:UITableViewStylePlain];
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
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
//    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 310, 45)];
//    [lineImageView setImage:[UIImage imageNamed:@"tableViewCell"]];
//    [cell addSubview:lineImageView];
    
    //    FatherBank *fatherBank = [self.banksArr objectAtIndex:indexPath.row];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 310, 45)];
    [lineImageView setImage:[UIImage imageNamed:@"tableViewCell"]];
    [cell addSubview:lineImageView];
    
    UIImageView *selectImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableViewCellSelect"]];
    [selectImageView setFrame:CGRectMake(0, 8, 310, lineImageView.frame.size.height)];
    UIImageView*bgSelectImageView =[[UIImageView alloc] initWithFrame:cell.frame];
    [bgSelectImageView addSubview:selectImageView];
    
    cell.selectedBackgroundView = bgSelectImageView;

    
    UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 8,self.view.bounds.size.width-20,selectImageView.bounds.size.height)];
    [bankLabel setText:[setArr objectAtIndex:indexPath.row]];
    [bankLabel setFont:[UIFont systemFontOfSize:13]];
    [bankLabel setBackgroundColor:[UIColor clearColor]];
    [bankLabel setTextColor:[UIColor whiteColor]];
    [bankLabel setTextAlignment:NSTextAlignmentLeft];
    [cell addSubview:bankLabel];
    
    if (cell.isSelected) {
        bankLabel.textColor=[UIColor colorWithRed:93/255 green:93/255 blue:93/255 alpha:1.0f];
    }
    }
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
        FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
        [self.navigationController pushViewController:feedBackVC animated:YES];
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
    // Dispose of any resources that can be recreated.
}

@end
