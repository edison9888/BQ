//
//  NumbersViewController.h
//  BQ
//
//  Created by Zoe on 13-5-6.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Number.h"
#import "MyTicketView.h"
#import "SelectBankViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface NumbersViewController : UIViewController<MyTicketViewDelegate,EGORefreshTableHeaderDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    @private
        UITableView *numberTableView;
        BOOL isFisrt,isReload;
        UIImageView *myhomeBG;
        UIButton *selectBankButton;
        EGORefreshTableHeaderView *refreshTableView;
        NSArray *idsArr;
        MyTicketView *myTicketView;
}

@property(nonatomic,strong) NSMutableArray *numberArr;
@property(nonatomic,assign) BOOL isNetWork;
//定时器
- (void)timer;
@end
