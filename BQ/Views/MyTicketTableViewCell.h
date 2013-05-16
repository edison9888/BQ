//
//  MyTicketTableViewCell.h
//  BQ
//
//  Created by Zoe on 13-5-16.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Number.h"
#import "MyTicketView.h"

@interface MyTicketTableViewCell : UITableViewCell

@property(nonatomic,strong) Number *number;
@property(nonatomic,strong) MyTicketView *myTicketView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id)delegate index:(NSInteger)index type:(TicketType)type;

@end
