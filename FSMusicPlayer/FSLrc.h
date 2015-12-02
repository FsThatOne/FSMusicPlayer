//
//  FSLrc.h
//  FSMusicPlayer
//
//  Created by FS小一 on 15/12/3.
//  Copyright © 2015年 FSxiaoyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSLrc : NSObject
//歌词的时间
@property (nonatomic, assign) NSTimeInterval time;
//歌词的内容
@property (nonatomic, copy) NSString* text;

@end
