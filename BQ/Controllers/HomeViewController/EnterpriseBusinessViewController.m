//
//  EnterpriseBusinessViewController.m
//  BQ
//
//  Created by Zoe on 13-4-1.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "EnterpriseBusinessViewController.h"

@interface EnterpriseBusinessViewController ()

@end

@implementation EnterpriseBusinessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.businessArr = [NSArray arrayWithObjects:@"转 账",@"汇 款",@"办 卡",nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor clearColor]];

    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25]];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alertWindow"]];
    bgImageView.userInteractionEnabled=YES;
    [bgImageView setBackgroundColor:[UIColor clearColor]];
    [bgImageView setFrame:CGRectMake(50, 160,  449/2, 345/2)];
    [self.view addSubview:bgImageView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(1, 1, bgImageView.frame.size.width-2, 346/2) style:UITableViewStylePlain];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [bgImageView addSubview:_tableView];
    
//    UIButton *getTicketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [getTicketBtn setBackgroundImage:[UIImage imageNamed:@"numberButton"] forState:UIControlStateNormal];
//    [getTicketBtn setFrame:CGRectMake(75, 180, 105, 42)];
//    [getTicketBtn addTarget:self action:@selector(getTicketClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bgImageView addSubview:getTicketBtn];

}

-(void)getTicketClick:(id)sender{
    if ([self.delegate respondsToSelector:@selector(OutOfEnterpriseBusinessTicketDelegate)]) {
        [self.delegate performSelector:@selector(OutOfEnterpriseBusinessTicketDelegate)];
        NSLog(@"出票");
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",tickitInfo] forKey:@"tickitInfo"];
        
    } ;
    
}


#pragma mark--
#pragma mark--TableViewDelegate---TableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116/2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.businessArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //    if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 516/2-2,116/2)];
    [bankLabel setText:[self.businessArr objectAtIndex:indexPath.row]];
    [bankLabel setFont:[UIFont systemFontOfSize:20]];
    [bankLabel setBackgroundColor:[UIColor clearColor]];
    [bankLabel setTextColor:[UIColor colorWithRed:75/255 green:85/255 blue:95/255 alpha:1.0f]];
    [bankLabel setTextAlignment:NSTextAlignmentCenter];
    [cell addSubview:bankLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(335/2,23, 37/2, 33/2)];
    [imageView setImage:[UIImage imageNamed:@"button"]];
    imageView.tag=indexPath.row+100;
    [cell addSubview:imageView];
    
    
//    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 116/2-4, cell.frame.size.width, 4)];
//    [lineImageView setImage:[UIImage imageNamed:@"fenGeXxian"]];
//    [cell addSubview:lineImageView];
    
    //    if (isSelect) {
    //        isSelect=NO;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:_tableView didSelectRowAtIndexPath:selectedIndexPath];
    //    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    for (int i=0; i<self.businessArr.count; i++) {
        
        UIImageView *imageView = (UIImageView *)[tableView viewWithTag:i+100];
        
        if (i==indexPath.row) {
            imageView.image = [UIImage imageNamed:@"buttonSelect"];
            
            tickitInfo = [self.businessArr objectAtIndex:indexPath.row];
            NSLog(@"出票--%@",[self.businessArr objectAtIndex:indexPath.row]);
            
        }else
            imageView.image = [UIImage imageNamed:@""];
        
    }
    
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if ([self.delegate respondsToSelector:@selector(dismissPresentVC)]) {
        [self.delegate performSelector:@selector(dismissPresentVC)];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
