//
//  PickerView.h
//  BQ
//
//  Created by Zoe on 13-4-7.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapViewController;
@interface PickerView : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    
}

@property(nonatomic,strong) NSMutableArray *pickerArrs;
@property(nonatomic,strong) UIPickerView *pickerView;
@property(nonatomic,strong) NSString *cityId;

@property(nonatomic,weak) MapViewController *viewController;
@end
