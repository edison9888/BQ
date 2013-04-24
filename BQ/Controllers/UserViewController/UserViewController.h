//
//  UserViewController.h
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Number.h"
#import "MyTicketView.h"
#import "SelectBankViewController.h"

@interface UserViewController : UIViewController<MyTicketViewDelegate>
{
    @private
    UIScrollView *scrollView;
    BOOL isFisrt;
    UIImageView *myhomeBG;
    UIButton *selectBankButton;
}

@property(nonatomic,strong) NSMutableArray *numberArr;
@property(nonatomic,assign) BOOL isNetWork;
@end
