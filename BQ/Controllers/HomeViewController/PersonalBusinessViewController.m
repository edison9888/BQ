//
//  PersonalBusinessViewController.m
//  BQ
//
//  Created by Zoe on 13-4-1.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "PersonalBusinessViewController.h"
#import "Business.h"
#define CellHeight 56

@interface PersonalBusinessViewController ()

@end

@implementation PersonalBusinessViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.businessArr = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    isSelect=YES;
    
    
    bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alertWindow"]];
    bgImageView.userInteractionEnabled=YES;
    [bgImageView setBackgroundColor:[UIColor clearColor]];
    [bgImageView setFrame:CGRectMake(50, 160,  220, 170)];
    [self.view addSubview:bgImageView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, bgImageView.frame.size.width-2, bgImageView.frame.size.height) style:UITableViewStylePlain];
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

-(void)getChildServiceFromData{
    
    NSDictionary *dic =[NSDictionary dictionaryWithObject:_busniess.serviceId forKey:@"id"];
    
    [Business getChildService:dic WithBlock:^(NSArray *arr) {
        
        if (arr.count==0) {
            [self getTicketClick:_busniess];
            
        }else{
            self.businessArr=arr;
            [_tableView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //调接口获取子业务
//    if (_businessType==EnterPriseType) {
//        bgImageView.hidden=YES;
//        return;
//    }
    [self getChildServiceFromData];

}

-(void)getTicketClick:(Business *)bus{
    if ([self.delegate respondsToSelector:@selector(OutOfTheTicketDelegate:)]) {
        [self.delegate OutOfTheTicketDelegate:bus];

//        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",tickitInfo] forKey:@"tickitInfo"];

    } ;
}



#pragma mark--
#pragma mark--TableViewDelegate---TableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
    
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
    
    if (self.businessArr.count==0){
        return nil;
    }
    
    Business *bus = [self.businessArr objectAtIndex:indexPath.row];
        
    UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 224,CellHeight)];
    [bankLabel setText:[NSString stringWithFormat:@"%@",bus.serviceName]];
    [bankLabel setFont:[UIFont systemFontOfSize:20]];
    [bankLabel setBackgroundColor:[UIColor clearColor]];
    [bankLabel setTextColor:[UIColor colorWithRed:75/255 green:85/255 blue:95/255 alpha:1.0f]];
    [bankLabel setTextAlignment:NSTextAlignmentCenter];
    [cell addSubview:bankLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, cell.frame.size.width, CellHeight)];
   [imageView setImage:[UIImage imageNamed:@"buttonSelected"]];
    cell.selectedBackgroundView = imageView;
    
    if (indexPath.row!=self.businessArr.count-1) {
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,CellHeight-4, cell.frame.size.width, 4)];
        [lineImageView setImage:[UIImage imageNamed:@"fenGeXxian"]];
        [cell addSubview:lineImageView];
    }
       
//    if (isSelect) {
//        isSelect=NO;
//        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [self tableView:_tableView didSelectRowAtIndexPath:selectedIndexPath];
//    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Business *bus = [self.businessArr objectAtIndex:indexPath.row];
    NSLog(@"出票--%@",bus.serviceName);
    
    [self getTicketClick:bus];

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self getTicketClick:nil];
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
