//
//  MyTicketView.m
//  BQ
//
//  Created by Zoe on 13-4-11.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "MyTicketView.h"
#import <QuartzCore/QuartzCore.h>
#import "Bundle.h"

#define BetweenHeight 12
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


@implementation MyTicketView
@synthesize refreshImageView;

- (id)initWithFrame:(CGRect)frame index:(NSInteger)index type:(TicketType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        qrView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 326)];
        qrView.hidden=YES;
        qrView.layer.masksToBounds = YES;
        qrView.layer.cornerRadius = 6;
        qrView.backgroundColor = [UIColor whiteColor];
        [self addSubview:qrView];
        
        qrImageView =[[UIImageView alloc] initWithFrame:CGRectMake((qrView.frame.size.width-QR_WIDTH)/2, 70, QR_WIDTH, QR_WIDTH)];
        qrImageView.userInteractionEnabled=YES;
        [qrView addSubview:qrImageView];
        
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270, 326)];
        if (type==myTicket) {
            [bgView setImage:[UIImage imageNamed:@"myTicketBg"]];
        }else if(type==getTicket)
            [bgView setImage:[UIImage imageNamed:@"ticket@2x"]];
        else
            [bgView setImage:[UIImage imageNamed:@"abandonTicket@2x"]];
        bgView.userInteractionEnabled=YES;
        [self addSubview:bgView];
        
        //二维码翻页按钮
        qrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        qrBtn.hidden=YES;
        [qrBtn setFrame:CGRectMake(230.5, 283, 34, 22)];
        [qrBtn setBackgroundImage:[UIImage imageNamed:@"erWeiMa@2x"] forState:UIControlStateNormal];
        [qrBtn addTarget:self action:@selector(turnToQR:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:qrBtn];

        
        breakPaperImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"breakPaper@2x"]];
        breakPaperImg.hidden=YES;
        [breakPaperImg setFrame:CGRectMake(0, 62,bgView.frame.size.width,66)];
        [bgView addSubview:breakPaperImg];
               
        //过期戳
        stampImageView = [[UIImageView alloc] initWithFrame:CGRectMake(47,65,188,58)];
        [stampImageView setImage:[UIImage imageNamed:@"stamp"]];
        stampImageView.hidden=YES;
        [bgView addSubview:stampImageView];
        
        bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(48-10, 20, 194, 30)];
        bankNameLabel.text = @"";
        bankNameLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:22];
        bankNameLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        bankNameLabel.backgroundColor = [UIColor clearColor];
        [bankNameLabel setTextAlignment:NSTextAlignmentCenter];
        [bgView addSubview:bankNameLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(104-10,50, 80, 12)];
        timeLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        timeLabel.font=[UIFont fontWithName:@"Helvetica" size:10];
        timeLabel.text = @"";
        timeLabel.backgroundColor = [UIColor clearColor];
        [timeLabel setTextAlignment:NSTextAlignmentCenter];
        [timeLabel setLineBreakMode:NSLineBreakByClipping];
        [bgView addSubview:timeLabel];
        
//        UIImageView *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(15, timeLabel.frame.size.height+timeLabel.frame.origin.y, 280, 7)];
//        imageView.image = [UIImage imageNamed:@"line"];
//        [bgView addSubview:imageView];

        asideLabel = [[UILabel alloc] initWithFrame:CGRectMake(25-10,86, 140, 18)];
        asideLabel.text = @"我的号码";
        asideLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:21];
        asideLabel.textColor = [UIColor colorWithRed:25.0f/255 green:135.0f/255 blue:130.0f/255 alpha:1.0f];
        asideLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:asideLabel];
        
        numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(asideLabel.frame.size.width+asideLabel.frame.origin.x, asideLabel.frame.origin.y-4, 130, 25)];
        numberLabel.textColor = [UIColor colorWithRed:25.0f/255 green:135.0f/255 blue:130.0f/255 alpha:1.0f];
        numberLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:30];
        numberLabel.text=@"A000";
        numberLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:numberLabel];
        
        UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(asideLabel.frame.origin.x,numberLabel.frame.origin.y+numberLabel.frame.size.height+BetweenHeight*3 ,80, 16)];
        pointLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        pointLabel.text=@"主办业务   ";
        pointLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
        pointLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:pointLabel];
        
        businessLabel = [[UILabel alloc] initWithFrame:CGRectMake(pointLabel.frame.origin.x+pointLabel.frame.size.width,pointLabel.frame.origin.y-3 , 200, 19)];
        businessLabel.textColor = [UIColor colorWithRed:65.0f/255 green:75.0f/255 blue:85.0f/255 alpha:1.0f];
        businessLabel.text=@"";
        businessLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:18];
        businessLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:businessLabel];

        
        UILabel *preNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(asideLabel.frame.origin.x, pointLabel.frame.size.height+pointLabel.frame.origin.y+BetweenHeight, 80, 16)];
        preNumberLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
        preNumberLabel.text=@"目前叫号   ";
        preNumberLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        preNumberLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:preNumberLabel];
        
        presentNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(preNumberLabel.frame.origin.x+preNumberLabel.frame.size.width, preNumberLabel.frame.origin.y-3, 200, 18)];
        presentNumberLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
        presentNumberLabel.text=@"";
        presentNumberLabel.backgroundColor = [UIColor clearColor];
        presentNumberLabel.textColor = [UIColor colorWithRed:65.0f/255 green:75.0f/255 blue:85.0f/255 alpha:1.0f];
        [bgView addSubview:presentNumberLabel];

        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(asideLabel.frame.origin.x, preNumberLabel.frame.origin.y+preNumberLabel.frame.size.height+BetweenHeight, 150, 18)];
        numLabel.text = @"您所在的排列前还有";
        numLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
        numLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        numLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:numLabel];
        
        remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(numLabel.frame.origin.x+numLabel.frame.size.width, numLabel.frame.origin.y-4, 250, 18)];
        remindLabel.text = @"0";
        remindLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:23];
        remindLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        remindLabel.backgroundColor = [UIColor clearColor];
        [remindLabel sizeToFit];
        [bgView addSubview:remindLabel];
        

        appendLabel = [[UILabel alloc] initWithFrame:CGRectMake(remindLabel.frame.origin.x+remindLabel.frame.size.width+5, numLabel.frame.origin.y, 25, 18)];
        appendLabel.text = @"人";
        appendLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
        appendLabel.textColor = [UIColor colorWithRed:75.0f/255 green:85.0f/255 blue:95.0f/255 alpha:1.0f];
        appendLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:appendLabel];
        
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(numLabel.frame.origin.x, numLabel.frame.size.height+numLabel.frame.origin.y+BetweenHeight*2, 160, 30)];
        alertLabel.textColor = [UIColor colorWithRed:107.0f/255 green:107.0f/255 blue:107.0f/255 alpha:1.0f];
        alertLabel.font=[UIFont fontWithName:@"Helvetica" size:10];
        alertLabel.text = @"我们会于5个号码前发信息通知您请确保您的手机网络正常";
        alertLabel.backgroundColor= [UIColor clearColor];
        alertLabel.numberOfLines=0;
        [bgView addSubview:alertLabel];
                
        refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        refreshBtn.frame = CGRectMake(222-5,appendLabel.frame.origin.y-8, 40, 40);
        [refreshBtn setBackgroundImage:[UIImage imageNamed:@"refreshButton"] forState:UIControlStateNormal];
        [refreshBtn addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventTouchUpInside];
        refreshBtn.tag = index;
        [bgView addSubview:refreshBtn];
        
        refreshImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refreshImage"]];
        refreshImageView.frame=CGRectMake(9, 9, 22, 22);
        [refreshBtn addSubview:refreshImageView];
        
        //添加手势
        singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView  =NO;
        
    }
    return self;
}

- (void)turnToQR:(id)sender{
    qrBtn.hidden=YES;
    qrView.hidden=NO;
    bgView.hidden=YES;
    [self turnBack:kCATransitionFromRight];
    
    [self addGestureRecognizer:singleTap];
}

- (void)rotateRefreshView:(UIImageView *)imageView{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    [UIView setAnimationDuration:1.0f];
//    [UIView setAnimationRepeatCount:2];
//    imageView.layer.anchorPoint = CGPointMake(0.5,0.5);
//    imageView.transform = CGAffineTransformMakeRotation([self radians:90]);
//    [UIView commitAnimations];

    CABasicAnimation* rotationAnimation =[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:(4 * M_PI)];// 3 is the number of 360 degree rotations
    rotationAnimation.duration = 0.5f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];//先慢后快
    [imageView.layer addAnimation:rotationAnimation forKey:@"animation"];
    
//    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    //角度转弧度
//    rotationAnimation.toValue = [NSNumber numberWithFloat:(DEGREES_TO_RADIANS(180))];
//    rotationAnimation.duration = 1.0f;
//    //动画开始结束的快慢，设置为加速
//    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [imageView.layer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
}

//-(double)radians:(double)degrees
//{
//    return degrees * M_PI/180;
//}

//刷新
- (void)refreshClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    //refresh按钮动画
    if ([self.delegate respondsToSelector:@selector(refreshTicketsDelegate:btnIndex:)]) {
        [self.delegate refreshTicketsDelegate:_number btnIndex:btn.tag];
    }
}

- (void)setNumber:(Number *)number{
    _number=number;
    
    bankNameLabel.text = number.bankTypeName;
    numberLabel.text = number.myNum;
    businessLabel.text = [NSString stringWithFormat:@"%@",number.serviceName];
    presentNumberLabel.text = [NSString stringWithFormat:@"%@",number.presentNumber];
    
    if (number.beforeCount!=0) {
        
        remindLabel.text = number.beforeCount;
        [remindLabel sizeToFit];
        [remindLabel setTextColor:[UIColor colorWithRed:233/255.0f green:100/255.0f blue:163/255.0f alpha:1.0f]];
        appendLabel.frame = CGRectMake(remindLabel.frame.origin.x+remindLabel.frame.size.width+5,numLabel.frame.origin.y,appendLabel.frame.size.width, appendLabel.frame.size.height);
        
    }
    timeLabel.text = number.numDate;
    
    //1:作废    2：未办理  3：正在办理 4：已办理
    if (number.numStatus==2||number.numStatus==3){
        stampImageView.hidden=YES;
        breakPaperImg.hidden=YES;
    }
    
    if (number.numStatus==1||number.numStatus==4) {
        
        stampImageView.hidden = NO;
        breakPaperImg.hidden=NO;

        bgView.image = [UIImage imageNamed:@"abandonTicket"];
        
        asideLabel.hidden=YES;
        numberLabel.hidden=YES;
        refreshBtn.hidden=YES;
        
        for (UIView *view in [bgView subviews]) {
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *label =(UILabel *)view;
                label.textColor=[UIColor colorWithRed:179/255.f green:179/255.f blue:179/255.f alpha:1.0f];
            }
        }
    }
    else{
        [asideLabel setTextColor:[UIColor whiteColor]];
        [numberLabel setTextColor:[UIColor whiteColor]];
    }
    
    if (number.numStatus == 1) {
        stampImageView.image = [UIImage imageNamed:@"stamp"];
    }
    else if(number.numStatus==4){
        stampImageView.image = [UIImage imageNamed:@"stamp1"];
    }
    
    if (_number.isNeedForm==1) {
        imageFileStr = [self getPath];
        qrImageView.image = [UIImage imageWithContentsOfFile:imageFileStr];
        if (imageFileStr) {
            qrBtn.hidden=NO;
        }else
            qrBtn.hidden=YES;
    }
}

- (NSString *)getPath{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
     NSString *filePath = [[Bundle docoumentRootPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",_number.numId]];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        return filePath;
    }else
        return nil;

}

#pragma mark ---UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    
    return YES;
}

-(void)handleSingleTap:(id)sender{
    
    [self removeGestureRecognizer:singleTap];

//    if (_number.isNeedForm==2 || imageFileStr ==nil) {
//        return;
//    }
    
//    if (coverInt) {
//        coverInt=0;
        qrBtn.hidden=NO;
        bgView.hidden=NO;
        qrView.hidden=YES;
        [self turnBack:kCATransitionFromLeft];
//    }else{
//        coverInt=1;
//        qrView.hidden=NO;
//        bgView.hidden=YES;
//        [self turnBack:kCATransitionFromRight];
//    }
}

- (void)turnBack:(NSString * const)leftOrRight{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = @"oglFlip";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.layer  addAnimation:transition forKey:@"revert"];

}

@end
