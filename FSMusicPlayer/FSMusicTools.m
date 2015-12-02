//
//  FSMusicTools.m
//  FSMusicPlayer
//
//  Created by FS小一 on 15/12/3.
//  Copyright © 2015年 FSxiaoyi. All rights reserved.
//

#import "FSMusicTools.h"

@interface FSMusicTools()
@property (nonatomic, copy)NSString *currentMusicName;
@end

@implementation FSMusicTools

+ (instancetype)shareMusicTool
{
    static FSMusicTools *_INTENCE;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _INTENCE = [[FSMusicTools alloc]init];
    });
    return _INTENCE;
}


- (void)playWithName:(NSString *)name
{
    //nil
    if (name == nil) {
        return;
    }
    
    //月半小夜曲.mp3
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:nil];
    if (path == nil) { //找不到这首歌曲
        return;
    }
    
    //如果正在播放月半小夜曲
    if ([self.currentMusicName isEqualToString:name]) {
        
        if (!self.player.isPlaying) {
            
        }else
        {
            return;
        }
        
    }else{
        
        NSURL *url = [NSURL fileURLWithPath:path];
        
        self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil] ;
        
        self.currentMusicName = name;
    }
    
    
    [self.player play];
    
}

- (NSTimeInterval)currentTime
{
    return self.player.currentTime;
}

- (NSTimeInterval)totalTime
{
    return self.player.duration;
}

- (CGFloat)progress
{
    //当前播放时间/总时间
    
    return self.player.currentTime/self.player.duration;
}

- (void)pause
{
    if (self.player.isPlaying) {
        [self.player pause];
    }
}

@end
