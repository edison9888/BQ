//
//  UserViewController.m
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "UserViewController.h"
#import "AppDelegate.h"

#define NavigationHeight 44

@interface UserViewController ()

@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isFisrt=YES;
    }
    return self;
}

- (void)timer{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd EEEE HH:mm:ss a"];
    [formatter setDateFormat:@"HH"];
    NSString *locationString=[formatter stringFromDate: [NSDate date]];

    if ([locationString isEqualToString:@"24"]) {
        [self performSelector:@selector(updateSqliteDataWhichTicketIsInvalid) withObject:self afterDelay:1.0f]; 
    }
    
    if (debug) {
        NSLog(@"str===%@",locationString);
    }
}

//一天修改一次状态
-(void)updateSqliteDataWhichTicketIsInvalid{
    
    [Number updateNumbersStatusBeforeTodayFromDatabase];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [Number deleteNumbersFromSqlite];
       
    
    myhomeBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-57)];
    [self.view addSubview:myhomeBG];
    
    scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.bounds.size.height-57)];
    scrollView.bounces=YES;
    scrollView.delegate=self;
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width, scrollView.frame.size.height);
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];
    
    refreshTableView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0,-scrollView.bounds.size.height, scrollView.frame.size.width,scrollView.frame.size.height)];
    refreshTableView.delegate=self;
    [scrollView addSubview:refreshTableView];
    
    selectBankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBankButton addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchUpInside];
    [selectBankButton setImage:[UIImage imageNamed:@"mapBtn"] forState:UIControlStateNormal];
    [selectBankButton setFrame:CGRectMake(self.view.bounds.size.width/2-102/2,self.view.bounds.size.height-50, 102, 50)];
    [self.view addSubview:selectBankButton];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //判断是否到每日0点，更新票status
    [self timer];

    //判读是否联网
    self.isNetWork = [AppDelegate isNetworkReachable];
    
    //回到初始位置
    [scrollView setContentOffset:CGPointMake(0, 0)];
    
    [[AppDelegate getAppdelegate] setNavigateBarHidden:YES];
   
    //移除原来的票
    [self removePastNumbers];
    
    if (isFisrt) {
        isFisrt=NO;
        [self nullTicketView:0];

    }else{
        //获取我的号码
        [self getMyNumbersFromNet];
    }
    
}

- (void)removePastNumbers{    
    for (UIView *view in  [scrollView subviews]) {
        if ([view isKindOfClass:[MyTicketView class]]) {
            [view removeFromSuperview];
        }
    }
}

//无票时显示
- (void)nullTicketView:(NSInteger) count{

    if (count==0) {
        MyTicketView *myTicketView =[[MyTicketView alloc] initWithFrame:CGRectMake(16, 45, 290, 342) index:111 type:myTicket];
        myTicketView.delegate=self;
        [scrollView addSubview:myTicketView];
    }else{
        MyTicketView *myTicket =(MyTicketView *)[scrollView viewWithTag:111];
        [myTicket removeFromSuperview];
    }
   
}

//获取我的所有号码
-(void)getMyNumbersFromNet{
    
    NSArray *idsArr = [Number selectNumbersInfoFromDatabase];
        
    NSString *idsStr = [idsArr componentsJoinedByString:@","];
    
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:idsStr,@"ids", nil];
    
    [Number refreshBankNumbers:dic WithBlock:^(NSArray *arr) {
        
        [self changeBgImageView];
        [self nullTicketView:arr.count];

        if (arr.count!=0) {
            NSArray* reversedArray = [[arr reverseObjectEnumerator] allObjects];
            _numberArr=(NSMutableArray *)reversedArray;
//            NSLog(@"_numberArr%@",_numberArr);
            for (int i=0; i<_numberArr.count; i++) {
                [self createMyTicket:CGRectMake(16, 45+i*(342+20), 310, 342) index:i];
            }
            
            scrollView.contentSize = CGSizeMake(self.view.bounds.size.width,45+362*self.numberArr.count);
        }

    }];
    
}


#pragma mark--
#pragma mark--NetWork
- (void)setIsNetWork:(BOOL)isNetWork{
    
    if (!isNetWork) {
        
        UILabel *netStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-60)/2, 10,60, 15)];
        [netStatusLabel setFont:[UIFont systemFontOfSize:13]];
        [netStatusLabel setBackgroundColor:[UIColor clearColor]];
        [netStatusLabel setText:@"网络异常"];
        [netStatusLabel setTextColor:[UIColor colorWithRed:42/255.0f green:180/255.0f blue:173/255.0f alpha:1.0f]];
        netStatusLabel.tag=12;
        [scrollView addSubview:netStatusLabel];
        
        UIImageView *statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-202.5)/2,25 , 202.5, 20)];
        [statusImageView setImage:[UIImage imageNamed:@"noNetwork"]];
        statusImageView.tag=13;
        [scrollView addSubview:statusImageView];
    }else{//有网络时不显示
        UILabel *label =(UILabel *)[scrollView viewWithTag:12];
        [label removeFromSuperview];
        
        UIImageView *imageView =(UIImageView *)[scrollView viewWithTag:13];
        [imageView removeFromSuperview];
    }
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[AppDelegate getAppdelegate] setNavigateBarHidden:NO];
}

//改变背景图
- (void)changeBgImageView{
    //背景图
    UIImageView *downTicketImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downTicket"]];
    [downTicketImage setFrame:CGRectMake(0,self.view.frame.size.height-57, self.view.frame.size.width, 57)];
    [self.view addSubview:downTicketImage];
    
    if (iPhone5) {
        [myhomeBG setImage:[UIImage imageNamed:@"homeTicket5"]];
    }else{
        [myhomeBG setImage:[UIImage imageNamed:@"homeTicket4"]];
    }
    [self.view addSubview:selectBankButton];
}

//生成多个ticket
-(void)createMyTicket:(CGRect)rect index:(NSInteger)i{
    
    MyTicketView *myTicketView =[[MyTicketView alloc] initWithFrame:rect index:i type:myTicket];
    myTicketView.number=[self.numberArr objectAtIndex:i];
    myTicketView.delegate=self;
    myTicketView.tag=i+10;
    [scrollView addSubview:myTicketView];
    
}

#pragma mark--
#pragma mark--选择银行
-(void)buttonPress{
    self.navigationController.navigationBar.hidden = NO;
        
    SelectBankViewController  *selectBankVC = [[SelectBankViewController alloc]init];
//    selectBankVC.delegate=self;
    [self.navigationController pushViewController:selectBankVC animated:YES];
    
}

#pragma mark--
#pragma mark--MyTicketRefreshDelegate
//刷新票数据----刷新单张还是多张
- (void)refreshTicketsDelegate:(Number *)number btnIndex:(NSInteger)index{
    
    [self reloadOneTicket:number btnIndex:index];

}

//刷新单张数据
- (void)reloadOneTicket:(Number *)number btnIndex:(NSInteger)index{
    
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:number.numId,@"ids", nil];

    [Number refreshBankNumbers:dic WithBlock:^(NSArray *arr) {
        
        if (arr.count!=0) {
            MyTicketView *myTicketView = (MyTicketView *)[scrollView viewWithTag: index+10];
            myTicketView.number = [arr objectAtIndex:0];
        }else
            return;
    }];
    
}


#pragma mark--
#pragma egoRefreshDelegate
- (void)reloadTableViewDataSource{    
    //移除原来的票
    [self removePastNumbers];

    [self getMyNumbersFromNet];
    
    //刷新评论
    isReload = YES;
}

- (void)doneLoadingTableViewData{
    isReload = NO;
    
	[refreshTableView egoRefreshScrollViewDataSourceDidFinishedLoading:scrollView];
    
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0f];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return isReload;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date];
}

#pragma mark--
#pragma ScrollDelegete

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
	
	[refreshTableView egoRefreshScrollViewDidScroll:_scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    
    if(_scrollView.contentOffset.y >= -160)	{
        
        [refreshTableView egoRefreshScrollViewDidEndDragging:scrollView];
        
    }
}


#pragma mark--
#pragma mark--release memory
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    _numberArr=nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
