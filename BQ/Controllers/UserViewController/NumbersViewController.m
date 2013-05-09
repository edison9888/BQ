//
//  NumbersViewController.m
//  BQ
//
//  Created by Zoe on 13-5-6.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "NumbersViewController.h"
#import "AppDelegate.h"

#define DownHeight 98

@interface NumbersViewController ()

@end

@implementation NumbersViewController

- (id)init
{
    self = [super init];
    if (self) {
        isFisrt=YES;
    }
    return self;
}

//- (void)timer{
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    //    [formatter setDateFormat:@"yyyy-MM-dd EEEE HH:mm:ss a"];
//    [formatter setDateFormat:@"HH"];
//    NSString *locationString=[formatter stringFromDate: [NSDate date]];
//    
//    if ([locationString isEqualToString:@"24"]) {
//        [self performSelector:@selector(updateSqliteDataWhichTicketIsInvalid) withObject:self afterDelay:1.0f];
//    }
////    NSLog(@"str===%@",locationString);
//}

//一天修改一次状态
-(void)updateSqliteDataWhichTicketIsInvalid{
    
    [Number updateNumbersStatusBeforeTodayFromDatabase];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myhomeBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-DownHeight)];
    if (iPhone5) {
        [myhomeBG setImage:[UIImage imageNamed:@"homeTicket5"]];
    }else{
        [myhomeBG setImage:[UIImage imageNamed:@"homeTicket4"]];
    }
    [self.view addSubview:selectBankButton];
    
    
    numberTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.bounds.size.height-DownHeight+16)];
    numberTableView.delegate=self;
    numberTableView.dataSource=self;
    numberTableView.backgroundView=nil;
    numberTableView.backgroundColor=[UIColor clearColor];
    numberTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:numberTableView];
    
    refreshTableView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0,-numberTableView.bounds.size.height, numberTableView.frame.size.width,numberTableView.frame.size.height)];
    refreshTableView.delegate=self;
    [numberTableView addSubview:refreshTableView];
    
    //背景图
    UIImageView *downTicketImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downTicket"]];
    [downTicketImage setFrame:CGRectMake(0,self.view.bounds.size.height-DownHeight, self.view.frame.size.width, DownHeight)];
    downTicketImage.userInteractionEnabled=YES;
    [self.view addSubview:downTicketImage];
    
    selectBankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBankButton addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchUpInside];
    [selectBankButton setImage:[UIImage imageNamed:@"mapBtn"] forState:UIControlStateNormal];
    [selectBankButton setImage:[UIImage imageNamed:@"mapBtnSelected"] forState:UIControlStateSelected];
    [selectBankButton setFrame:CGRectMake(self.view.bounds.size.width/2-75/2,25, 75, 73)];
    [downTicketImage addSubview:selectBankButton];   

}

- (void)viewWillAppear:(BOOL)animated{
    //更新票状态status=1
    [self updateSqliteDataWhichTicketIsInvalid];
    
    [[AppDelegate getAppdelegate] setNavigateBarHidden:YES];
    
//    //判断是否到每日0点，更新票status
//    [self timer];
    
    //判读是否联网
    self.isNetWork = [AppDelegate isNetworkReachable];
        
    if (isFisrt) {
        isFisrt=NO;
//        [self nullTicketView:0];
        [numberTableView reloadData];
    }else{
        //获取我的号码
        if (_isNetWork) {
            [self getMyNumbersFromNet];//有网
        }else{
            [self getNumbersFromSqliteWithoutNet];//无网络
        }
    }
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
#pragma mark--GetMyNumbers
//获取我的所有号码
-(void)getMyNumbersFromNet{
    
    NSArray *idsArr = [Number selectNumbersInfoFromDatabase];

    if (idsArr.count==0) {
        [numberTableView reloadData];
        return;
    }
//    else
//        [self nullTicketView:idsArr.count];
    
//    [self changeBgImageView];
    NSString *idsStr = [idsArr componentsJoinedByString:@","];
    
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:idsStr,@"ids", nil];
    
    [Number refreshBankNumbers:dic WithBlock:^(NSArray *arr) {
        
        if (arr.count!=0) {
            NSArray* reversedArray = [[arr reverseObjectEnumerator] allObjects];
            _numberArr=[NSMutableArray arrayWithArray:reversedArray];
            [numberTableView reloadData];
        }
    }];
    
}


//无网络情况下，获得数据
- (void)getNumbersFromSqliteWithoutNet{
    NSArray *regionArr = [NSMutableArray arrayWithArray:[Number getNumbersFromSqliteWithoutNet]];
    
    if (regionArr.count==0) {
//        [self changeBgImageView];
//        [self nullTicketView:regionArr.count];
        return;
    }
    
    NSArray* reversedArray = [[regionArr reverseObjectEnumerator] allObjects];
    _numberArr=[NSMutableArray arrayWithArray:reversedArray];;
    NSLog(@"withoutnet%@",_numberArr);
    [numberTableView reloadData];
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
            MyTicketView *_ticketView = (MyTicketView *)[numberTableView viewWithTag: index+10];
            _ticketView.number = [arr objectAtIndex:0];
        }else
            return;
    }];
}

//#pragma mark--
//#pragma mark--ChangeViews
////改变背景图
//- (void)changeBgImageView{
//    if (myhomeBG.image !=nil) {
//        NSLog(@"有图");
//        return;
//    }
//    float height;
//    if (isReload) {
//        height=0;
//    }else
//        height=NavigationHeight;
//    
//    //背景图
//    UIImageView *downTicketImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downTicket"]];
//    [downTicketImage setFrame:CGRectMake(0,self.view.frame.size.height+height-DownHeight, self.view.frame.size.width, DownHeight)];
//    [self.view addSubview:downTicketImage];
//}

//无票时显示
- (void)nullTicketView:(NSInteger) count :(UITableViewCell *)cell{
    if (count==0) {
        MyTicketView *myTicketView =[[MyTicketView alloc] initWithFrame:CGRectMake(16+10, 20, 290, 342) index:120 type:myTicket];
        myTicketView.tag=120;
        myTicketView.delegate=self;
        [cell addSubview:myTicketView];
    }else{
        MyTicketView *myTicketView =(MyTicketView *)[self.view viewWithTag:120];
        [myTicketView removeFromSuperview];
    }
}


#pragma mark--
#pragma mark--NetWork
- (void)setIsNetWork:(BOOL)isNetWork{
    
    _isNetWork=isNetWork;
    if (!isNetWork) {
        
        UILabel *netStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-60)/2, 10,60, 15)];
        [netStatusLabel setFont:[UIFont systemFontOfSize:13]];
        [netStatusLabel setBackgroundColor:[UIColor clearColor]];
        [netStatusLabel setText:@"网络异常"];
        [netStatusLabel setTextColor:[UIColor colorWithRed:42/255.0f green:180/255.0f blue:173/255.0f alpha:1.0f]];
        netStatusLabel.tag=12;
        [self.view addSubview:netStatusLabel];
        
        UIImageView *statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-202.5)/2,25 , 202.5, 20)];
        [statusImageView setImage:[UIImage imageNamed:@"noNetwork"]];
        statusImageView.tag=13;
        [self.view addSubview:statusImageView];
    }else{//有网络时不显示
        UILabel *label =(UILabel *)[self.view viewWithTag:12];
        [label removeFromSuperview];
        
        UIImageView *imageView =(UIImageView *)[self.view viewWithTag:13];
        [imageView removeFromSuperview];
    }
}


#pragma mark--
#pragma mark-- egoRefreshDelegate
- (void)reloadTableViewDataSource{
    //刷新评论
    isReload = YES;
    [self getMyNumbersFromNet];

}

- (void)doneLoadingTableViewData{
    isReload = NO;
    
	[refreshTableView egoRefreshScrollViewDataSourceDidFinishedLoading:numberTableView];
    
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
        
        [refreshTableView egoRefreshScrollViewDidEndDragging:numberTableView];
        
    }
}


#pragma mark--
#pragma mark--TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, numberTableView.frame.size.width, 20)];
    headerView.backgroundColor=[UIColor clearColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 362;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_numberArr.count==0) {
        return 2;
    }
    else
        return self.numberArr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    int i=indexPath.row;
    
    UIButton *btn = (UIButton *)[cell viewWithTag:12];
    [btn removeFromSuperview];

    if (_numberArr.count==0) {
        if (indexPath.row==0) {
            [self nullTicketView:0 :cell];
            return cell;
            
        }else if(indexPath.row==1){
            UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [setBtn setBackgroundColor:[UIColor yellowColor]];
            [setBtn setFrame:CGRectMake(0, 0, cell.frame.size.width, 362)];
            setBtn.tag=12;
            [cell addSubview:setBtn];
            return cell;
        }            
    }else{
        [self nullTicketView:_numberArr.count :nil];
        if (indexPath.row!=_numberArr.count) {
            MyTicketView *ticketView =[[MyTicketView alloc] initWithFrame:CGRectMake(16+10,0, 310, 342) index:i type:myTicket];
            ticketView.number=[self.numberArr objectAtIndex:i];
            ticketView.delegate=self;
            ticketView.tag=i+10;
            [cell addSubview:ticketView];
            return cell;
        }else{
            UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [setBtn setBackgroundColor:[UIColor yellowColor]];
            [setBtn setFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
            setBtn.tag=12;
            [cell addSubview:setBtn];
            return cell;        
        }
    }
    return nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end