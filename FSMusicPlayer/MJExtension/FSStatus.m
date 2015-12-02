//
//  FSStatus.m
//  FSMusicPlayer
//
//  Created by FS小一 on 15/12/3.
//  Copyright © 2015年 FSxiaoyi. All rights reserved.
//

#import "FSStatus.h"
#import "FSidModel.h"
#import "FSStatusModel.h"

@implementation FSStatus
- (NSDictionary *)objectClassInArray
{
    return @{@"ad" : [FSidModel class],@"statuses" : [FSStatusModel class]};
}
@end
