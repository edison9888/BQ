//
//  TicketSoundEffect.m
//  BQ
//
//  Created by zzlmilk on 13-5-16.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "TicketSoundEffect.h"

@implementation TicketSoundEffect

+ (void)playSoundWithName:(NSString *)name type:(NSString *)type{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSURL *url = [NSURL fileURLWithPath:path];
        SystemSoundID sound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &sound);
        AudioServicesPlaySystemSound(sound);
    }
    else {
        NSLog(@"**** Sound Error: file not found: %@", path);
    }
}
+(void)playTicketSound{
    [TicketSoundEffect playSoundWithName:@"TicketSound" type:@"mp3"];
}
@end
