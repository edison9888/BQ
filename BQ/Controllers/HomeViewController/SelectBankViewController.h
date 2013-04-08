//
//  SelectBankViewController.h
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SelectBankViewControllerDelegate<NSObject>

-(void)hidenTabbar:(BOOL)ishide;

@end


@interface SelectBankViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) NSArray *banksArr;
@property(nonatomic,weak) id<SelectBankViewControllerDelegate> delegate;
@end
