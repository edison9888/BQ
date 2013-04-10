//
//  PersonalBusinessViewController.h
//  BQ
//
//  Created by Zoe on 13-4-1.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HomeViewController;
@protocol  PersonalBusinessViewControllerDelegate<NSObject>

- (void)OutOfTheTicketDelegate;

@end

@interface PersonalBusinessViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    BOOL isSelect;
    NSString *tickitInfo;
}

@property(nonatomic,strong) NSArray *businessArr;
@property(nonatomic,weak) id <PersonalBusinessViewControllerDelegate> delegate;
@property(nonatomic,weak) HomeViewController *homeVC;
@end
