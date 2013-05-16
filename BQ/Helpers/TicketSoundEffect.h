//
//  TicketSoundEffect.h
//  BQ
//
//  Created by zzlmilk on 13-5-16.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface TicketSoundEffect : NSObject

+ (void)playSoundWithName:(NSString *)name type:(NSString *)type;

+ (void)playTicketSound;
@end
