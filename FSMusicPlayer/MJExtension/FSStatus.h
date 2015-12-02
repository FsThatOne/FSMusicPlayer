//
//  FSStatus.h
//  FSMusicPlayer
//
//  Created by FS小一 on 15/12/3.
//  Copyright © 2015年 FSxiaoyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface FSStatus : NSObject
//1.id  关键字 拿什么替代 id
//2.数组中存放什么模型

@property (nonatomic, strong) NSNumber* total_number;
@property (nonatomic, strong) NSArray* ad;
@property (nonatomic, strong) NSArray* statuses;
@end
