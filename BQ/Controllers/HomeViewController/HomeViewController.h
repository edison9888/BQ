//
//  HomeViewController.h
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalBusinessViewController.h"
#import "EnterpriseBusinessViewController.h"

typedef enum {
    personal,
    enterprise
} BusinessType;


@interface HomeViewController : UIViewController<PersonalBusinessViewControllerDelegate,EnterpriseBusinessViewControllerDelegate>
{
    PersonalBusinessViewController *personalVC;
    EnterpriseBusinessViewController *enterpriseVC;
}

@property(nonatomic,strong)UILabel *bankNameLabel;


@end
