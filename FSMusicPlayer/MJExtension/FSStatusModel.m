//
//  FSStatusModel.m
//  FSMusicPlayer
//
//  Created by FS小一 on 15/12/3.
//  Copyright © 2015年 FSxiaoyi. All rights reserved.
//

#import "FSStatusModel.h"
#import "MJExtension.h"

@implementation FSStatusModel
- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"idStr" : @"id"};
}
@end
