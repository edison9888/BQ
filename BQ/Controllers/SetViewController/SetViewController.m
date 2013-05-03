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
    self.title=@"设置";
    
//    //背景图
//    UIImageView *homeBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beiJing"]];
//    homeBG.frame  = self.view.bounds;
//    homeBG.userInteractionEnabled =YES;
//    [self.view addSubview:homeBG];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundView=nil;
    [self.view addSubview:tableView];
    
    setArr = [NSMutableArray arrayWithObjects:@"关于我们",@"意见反馈",@"给我们评分", nil];
}
#pragma mark--
#pragma mark--TableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50;
//    
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return setArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
//    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 310, 45)];
//    [lineImageView setImage:[UIImage imageNamed:@"tableViewCell"]];
//    [cell addSubview:lineImageView];
    
    //    FatherBank *fatherBank = [self.banksArr objectAtIndex:indexPath.row];
    
    UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0,self.view.bounds.size.width-20,cell.bounds.size.height)];
    [bankLabel setText:[setArr objectAtIndex:indexPath.row]];
    //    [bankLabel setText:fatherBank.fatherBankName];
    [bankLabel setFont:[UIFont systemFontOfSize:13]];
    [bankLabel setBackgroundColor:[UIColor clearColor]];
    [bankLabel setTextColor:[UIColor colorWithRed:65/255 green:75/255 blue:85/255 alpha:1.0f]];
    [bankLabel setTextAlignment:NSTextAlignmentLeft];
    [cell addSubview:bankLabel];
    
    
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
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    setArr=nil;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
