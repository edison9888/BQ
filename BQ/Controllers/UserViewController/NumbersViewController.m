//
//  NumbersViewController.m
//  BQ
//
//  Created by Zoe on 13-5-6.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "NumbersViewController.h"
#import "AppDelegate.h"
#import "NoTicketView.h"
#import "MyTicketTableViewCell.h"
#import "SVProgressHUD.h"

#import "Bundle.h"
#define DownHeight 98
#define NoTicketHeight 15


//#import "FormViewController.h"

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

#pragma mark--
#pragma mark--清理过期数据库中的状态--伪删除
//一天修改一次状态
-(void)updateSqliteDataWhichTicketIsInvalid{
    
    [Number updateNumbersStatusBeforeTodayFromDatabase];
    
    [self removeQrImageInDocument];
       
}

#pragma mark--
#pragma mark--清理沙盒中的过期二维码image
- (void)removeQrImageInDocument{
    NSArray *nmbIdsArr = [Number getExpiredNumbersIdsFromDatabase];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    NSError *error;
    for (int i=0;i<nmbIdsArr.count;i++) {
        NSString *path = [[Bundle docoumentRootPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[nmbIdsArr objectAtIndex:i]]];
        
        if ([fm fileExistsAtPath:path]) {
            BOOL succeeded =[fm removeItemAtPath:path error:&error];
            
            if (debug) {
                NSLog(@"succeeded--%d,%@",succeeded,error);
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    reloadOneTicketIndex=0;
    
    
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
    
    refreshTableView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0,-numberTableView.bounds.size.height, numberTableView.frame.size.width,numberTableView.frame.size.height) arrowImageName:@"lightGrayArrow" textColor:[UIColor colorWithRed:131/255.0f green:131/255.0f blue:131/255.0f alpha:1.0f]];
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
    
    //判读是否联网
    _isNetWork = [AppDelegate isNetworkReachable];
    
    //获取我的号码
    if (_isNetWork) {
        [self getMyNumbersFromNet];//有网
    }else{
        [self getNumbersFromSqliteWithoutNet];//无网络
    }
    
//    [self getNumbersFromSqliteWithoutNet];//无网络
//
//    [self getMyNumbersFromNet];//有网

}

#pragma mark--
#pragma mark--选择银行
-(void)buttonPress{
    self.navigationController.navigationBar.hidden = NO;
    
    SelectBankViewController  *selectBankVC = [[SelectBankViewController alloc]init];
    //    selectBankVC.delegate=self;
    [self.navigationController pushViewController:selectBankVC animated:YES];
//    FormViewController *formVC = [[FormViewController alloc] init];
//    [self.navigationController pushViewController:formVC animated:YES];
    
}


#pragma mark--
#pragma mark--GetMyNumbers
//获取我的所有号码
-(void)getMyNumbersFromNet{
    
    NSArray *idsArr = [Number selectNumbersInfoFromDatabase];

    [self nullTicketView:idsArr.count];

    if (idsArr.count==0) {
//        _numberArr=[NSMutableArray array];
//        [numberTableView reloadData];
        //无票提醒

        return;
    }


    NSString *idsStr = [idsArr componentsJoinedByString:@","];
    
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:idsStr,@"ids", nil];
    
    [SVProgressHUD show];

    [Number refreshBankNumbers:dic WithBlock:^(NSArray *arr) {
        
        if (arr.count!=0) {
            //消失
            
            NSArray* reversedArray = [[arr reverseObjectEnumerator] allObjects];
            _numberArr=[NSMutableArray arrayWithArray:reversedArray];
            [numberTableView reloadData];
        }
        [SVProgressHUD dismiss];
    }];
    
}

//测试
- (void)tempNumberArr{
    Number *number1 = [[Number alloc] init];
    number1.bankTypeName=@"中国建设银行";
    number1.myNum = @"A002";
    number1.numDate = @"2013 05-14 15:33";
    number1.numStatus = 2;
    number1.presentNumber = @"A001";
    number1.serviceName=@"理财";
    
    Number *number2 = [[Number alloc] init];
    number2.bankTypeName=@"中国招商银行";
    number2.myNum = @"B002";
    number2.numDate = @"2013 05-14 16:33";
    number2.numStatus = 1;
    number2.presentNumber = @"A001";
    number2.serviceName=@"理财";

    Number *number3 = [[Number alloc] init];
    number3.bankTypeName=@"中国农业银行";
    number3.myNum = @"C002";
    number3.numDate = @"2013 05-14 16:33";
    number3.numStatus = 4;
    number3.presentNumber = @"C001";
    number3.serviceName=@"理财";

    _numberArr=[NSMutableArray arrayWithObjects:number1,number2,number3, nil];

    [numberTableView reloadData];
}


//无网络情况下，获得数据
- (void)getNumbersFromSqliteWithoutNet{
    NSArray *regionArr = [NSMutableArray arrayWithArray:[Number getNumbersFromSqliteWithoutNet]];
    
    [self nullTicketView:regionArr.count];

    if (regionArr.count==0) {
        //假数据测试
        if (debug) {
            [self tempNumberArr];
            [self nullTicketView:_numberArr.count];
        }
        return;
    }
    
    NSArray* reversedArray = [[regionArr reverseObjectEnumerator] allObjects];
    _numberArr=[NSMutableArray arrayWithArray:reversedArray];
    
    if (debug) {
        NSLog(@"withoutnet%@",_numberArr);
    }
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
//            MyTicketView *_ticketView = (MyTicketView *)[numberTableView viewWithTag:index+10];
//            _ticketView.number = [arr objectAtIndex:0];
            reloadOneTicketIndex=index;
            if (debug) {
                NSLog(@"refresh %d",reloadOneTicketIndex);
            }
            reloadOneTicketArr=arr;
            [numberTableView reloadData];
        }else{
            return;
        }
    }];
}

//无票时显示
//- (void)nullTicketView:(NSInteger)count :(UITableViewCell *)cell{
//    NoTicketView *noTicketView =(NoTicketView *)[cell viewWithTag:120];
//
//    if (count==0) {
//        if (iPhone5)
//            heightIphone5=HeightIphone5;
//        else
//            heightIphone5=0;
//
//        NoTicketView *noTicketView =[[NoTicketView alloc] initWithFrame:CGRectMake(5, NoTicketHeight,310,400+heightIphone5*2) heightIphone5:heightIphone5];
//        noTicketView.tag=120;
//        [cell addSubview:noTicketView];
//    }else{
//        [noTicketView removeFromSuperview];
//    }
//}


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

//无票时显示
- (void)nullTicketView:(NSInteger)count{

      NoTicketView *noTicketView =(NoTicketView *)[numberTableView viewWithTag:120];
    
      if (count==0) {
          if (iPhone5)
              heightIphone5=HeightIphone5;
          else
              heightIphone5=0;
    
          NoTicketView *noTicketView =[[NoTicketView alloc] initWithFrame:CGRectMake(5, NoTicketHeight,310,400+heightIphone5*2) heightIphone5:heightIphone5];
          noTicketView.tag=120;
          [numberTableView addSubview:noTicketView];
          
          //draw tableView contentSize
          [numberTableView layoutSubviews];
          numberTableView.contentSize= CGSizeMake(self.view.frame.size.width, 400+heightIphone5*2+15);
          
        }else{
          
          [noTicketView removeFromSuperview];
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

    return self.numberArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomCellIdentifier";
    MyTicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    TicketType type = myTicket;

    Number *number;
    if (_numberArr.count!=0) {
        number=[_numberArr objectAtIndex:indexPath.row];
    }
    if (number.numStatus==1 || number.numStatus==4) {
        type=abandonTicket;
    }
    
    if (_numberArr.count!=0) {
        if (reloadOneTicketIndex==0) {
            //            if (!cell) {
            cell = [[MyTicketTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier delegate:self index:indexPath.row+10 type:type];
            cell.myTicketView.number=number;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            //            }
            return cell;
        }
        else{
            if (indexPath.row==reloadOneTicketIndex-10) {
                
                Number *number = [reloadOneTicketArr objectAtIndex:0];
                
                [_numberArr replaceObjectAtIndex:indexPath.row withObject:number];
                
                cell = [[MyTicketTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier delegate:self index:indexPath.row+10 type:type];
                cell.myTicketView.number=number;
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                
                [self rotateRefreshView:cell.myTicketView.refreshImageView];
                
                reloadOneTicketIndex=0;
            }
            
            return cell;
        }
    }
    return cell;
}

//动画
- (void)rotateRefreshView:(UIImageView *)imageView{
    CABasicAnimation* rotationAnimation =[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:(3 * M_PI)];// 3 is the number of 360 degree rotations
    rotationAnimation.duration = 0.7f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];//先慢后快
    [imageView.layer addAnimation:rotationAnimation forKey:@"animation"];
}

#pragma mark--
#pragma mark--release memory
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    numberTableView=nil;
    myhomeBG=nil;
    selectBankButton=nil;
    refreshTableView=nil;

    _numberArr=nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && self.view.window == nil) {
        self.view = nil;
    }
    _numberArr=nil;

}

@end
