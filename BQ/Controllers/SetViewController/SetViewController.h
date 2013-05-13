//
//  SetViewController.h
//  BQ
//
//  Created by zzlmilk on 13-3-26.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface SetViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *setArr;
}
@end
