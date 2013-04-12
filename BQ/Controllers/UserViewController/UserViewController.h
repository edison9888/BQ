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

@interface UserViewController : UIViewController<MyTicketViewDelegate>
{
    UIScrollView *scrollView;
}

@property(nonatomic,strong) NSMutableArray *numberArr;
@end
