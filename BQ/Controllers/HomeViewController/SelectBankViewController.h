//
//  SelectBankViewController.h
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBankViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) NSArray *banksArr;
@end
