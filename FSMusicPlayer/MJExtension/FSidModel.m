//
//  FSidModel.m
//  FSMusicPlayer
//
//  Created by FS小一 on 15/12/3.
//  Copyright © 2015年 FSxiaoyi. All rights reserved.
//

#import "FSidModel.h"
#import "MJExtension.h"

@implementation FSidModel
- (NSDictionary*)replacedKeyFromPropertyName
{
    return @{ @"idNum" : @"id" };
}
@end
