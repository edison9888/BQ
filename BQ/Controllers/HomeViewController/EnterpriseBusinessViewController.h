//
//  EnterpriseBusinessViewController.h
//  BQ
//
//  Created by Zoe on 13-4-1.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewController;

@protocol  EnterpriseBusinessViewControllerDelegate<NSObject>

- (void)OutOfEnterpriseBusinessTicketDelegate;
-(void)dismissPresentVC;

@end

@interface EnterpriseBusinessViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    BOOL isSelect;
    NSString *tickitInfo;

}

@property(nonatomic,strong) NSArray *businessArr;
@property(nonatomic,weak) id <EnterpriseBusinessViewControllerDelegate> delegate;
@property(nonatomic,weak) HomeViewController *homeVC;


@end
