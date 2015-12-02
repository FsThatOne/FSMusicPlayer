//
//  FSMusicTools.h
//  FSMusicPlayer
//
//  Created by FS小一 on 15/12/3.
//  Copyright © 2015年 FSxiaoyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface FSMusicTools : NSObject

@property (nonatomic, strong) AVAudioPlayer *player;

- (void)playWithName:(NSString *)name;

- (void)pause;

- (CGFloat )progress;

- (NSTimeInterval)currentTime;

- (NSTimeInterval)totalTime;

+ (instancetype)shareMusicTool;

@end
