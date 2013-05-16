//
//  MyTicketTableViewCell.m
//  BQ
//
//  Created by Zoe on 13-5-16.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MyTicketTableViewCell.h"

@implementation MyTicketTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id)delegate index:(NSInteger)index type:(TicketType)type;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _myTicketView =[[MyTicketView alloc] initWithFrame:CGRectMake(16+10,20, 310, 342) index:index type:type];
//        _myTicketView.number=_number;
        _myTicketView.delegate=delegate;
        _myTicketView.tag=index;
        [self.contentView addSubview:_myTicketView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
