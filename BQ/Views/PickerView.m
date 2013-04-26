//
//  PickerView.m
//  BQ
//
//  Created by Zoe on 13-4-7.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "PickerView.h"
#import "DatabaseOperations.h"

#define pickerViewHeight 215


@implementation PickerView

- (id)init{

    self =[super init];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    _isSelectPV=NO;
//    self.pickerArrs = [NSMutableArray arrayWithObjects:@"松江",@"闵行",@"黄浦",@"普陀",@"宝山", nil];
    // 获取pickerViewArr
    self.pickerArrs = [DatabaseOperations selectCountryFromDatabase:ProId];

    _county = [[Country alloc] init];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, 45+pickerViewHeight)];
    [self.view addSubview:bgView];
    
    UIImageView *toolBarBg = [[UIImageView alloc] initWithFrame:CGRectMake(-2, 1,323,45)];
    [toolBarBg setImage:[UIImage imageNamed:@"pickerToolBar"]];
    toolBarBg.userInteractionEnabled=YES;
    [bgView addSubview:toolBarBg];
    
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setFrame:CGRectMake(7, 7.5, 45, 30)];
    [dismissBtn setTitle:@"取消" forState:UIControlStateNormal];
    [dismissBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [dismissBtn addTarget:self.viewController action:@selector(dismissPickerView) forControlEvents:UIControlEventTouchUpInside];
    [dismissBtn setBackgroundImage:[UIImage imageNamed:@"okButton"] forState:UIControlStateNormal];
    [toolBarBg addSubview:dismissBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(270, 7.5, 45, 30)];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [confirmBtn addTarget:self.viewController action:@selector(confirmPickerView) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"okButton"] forState:UIControlStateNormal];
    [toolBarBg addSubview:confirmBtn];

    _pickerView =[[UIPickerView alloc] initWithFrame:CGRectMake(0, 43.5, self.view.bounds.size.width, pickerViewHeight)];
    _pickerView.delegate=self;
    _pickerView.dataSource=self;
    _pickerView.showsSelectionIndicator = YES; //显示选中框
    [_pickerView selectRow:(NSInteger)SelectComponent inComponent:0 animated:YES];

    [bgView addSubview:_pickerView];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.pickerArrs.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    Country *con  = [self.pickerArrs objectAtIndex:row];
    return con.countryName;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _isSelectPV=YES;
    _county = [self.pickerArrs objectAtIndex:row];
    
    NSLog(@"_cityId%d===%@",_county.countyId,_county.countryName);

}

@end
