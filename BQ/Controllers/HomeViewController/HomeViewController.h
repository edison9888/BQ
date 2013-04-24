//
//  HomeViewController.h
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalBusinessViewController.h"
//#import "EnterpriseBusinessViewController.h"

#import "MainViewController.h"
#import "SelectBankViewController.h"
#import "MyTicketView.h"


@class Bank;
@interface HomeViewController : UIViewController<PersonalBusinessViewControllerDelegate,MyTicketViewDelegate>
{
    BOOL isLocation;
    PersonalBusinessViewController *personalVC;
//    EnterpriseBusinessViewController *enterpriseVC;
    UILabel *_bankNameLabel;
}

@property(nonatomic,weak) MainViewController *viewController;
@property(nonatomic,strong) Bank *bank;
@property(nonatomic,strong) NSArray *fatherBusinessArr;

+ (HomeViewController *)instance;

@end
