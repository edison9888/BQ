//
//  EnterpriseBusinessViewController.h
//  BQ
//
//  Created by Zoe on 13-4-1.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  EnterpriseBusinessViewControllerDelegate<NSObject>

- (void)OutOfEnterpriseBusinessTicketDelegate;

@end

@interface EnterpriseBusinessViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    BOOL isSelect;
    NSString *tickitInfo;
}

@property(nonatomic,strong) NSArray *businessArr;
@property(nonatomic,weak) id <EnterpriseBusinessViewControllerDelegate> delegate;

@end
