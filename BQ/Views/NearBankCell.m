//
//  NearBankCell.m
//  BQ
//
//  Created by Zoe on 13-5-16.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "NearBankCell.h"

@implementation NearBankCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [super layoutSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = CGRectMake(15, 0, 310-130, self.frame.size.height);
    self.textLabel.frame = frame;
    [self.textLabel setTextAlignment:NSTextAlignmentLeft];
    self.textLabel.contentMode = UIViewContentModeScaleAspectFit;
    
//    CGRectMake(310-100, 20, 50,lineImageView.frame.size.height)
    self.detailTextLabel.frame = CGRectMake(310-110, 0, 70, self.frame.size.height);
    [self.detailTextLabel setTextAlignment:NSTextAlignmentLeft];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
