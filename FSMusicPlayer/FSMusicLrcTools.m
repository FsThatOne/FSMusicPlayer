//
//  FSMusicLrcTools.m
//  FSMusicPlayer
//
//  Created by FS小一 on 15/12/3.
//  Copyright © 2015年 FSxiaoyi. All rights reserved.
//

#import "FSMusicLrcTools.h"

@implementation FSMusicLrcTools

+ (NSArray *)lrcWithName:(NSString *)lrcName
{
    NSString *path = [[NSBundle mainBundle]pathForResource:lrcName ofType:nil];
    
    NSString *lrcstr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *allStr = [lrcstr componentsSeparatedByString:@"\n"];
    
    //有几个时间 就创建几个模型 放在数组中返回
    NSMutableArray *allResult = [NSMutableArray array];
    
    
    for (NSString *line in allStr) {
        //[04:02.00][01:05.00]这晚夜没有吻别
        //匹配规则 [[0-9][0-9]:[0-9][0-9].[0-9][0-9]]
        NSString *pattern = @"\\[[0-9][0-9]:[0-9][0-9].[0-9][0-9]\\]";
        NSRegularExpression *regular = [ NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
        
        NSArray *allCheckResult =  [regular matchesInString:line options:NSMatchingReportCompletion range:NSMakeRange(0, line.length)];
        
        NSTextCheckingResult *lastResult = [allCheckResult lastObject];
        NSString *strText =  [line substringFromIndex:lastResult.range.location + lastResult.range.length];
        NSLog(@"strText = %@",strText);
        for (NSTextCheckingResult *result in allCheckResult) { //有几个时间就遍历几遍  -> 创建一个模型
            //找到是时间
            //[04:02.00][01:05.00]这晚夜没有吻别
            //[04:02.00]
            NSString *strTime = [line substringWithRange:result.range];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"[mm:ss.SS]";
            
            NSDate *dateZero = [formatter dateFromString:@"[00:00.00]"];
            NSDate *newDate = [formatter dateFromString:strTime];
            
            NSTimeInterval timeR =  [newDate timeIntervalSinceDate:dateZero];
            
            
            NSLog(@"-----%@",strTime);
            
            FSLrc *lrc = [[FSLrc alloc]init];
            lrc.time = timeR;
            lrc.text = strText;
            
            [allResult addObject:lrc];
            
        }
    }
    
    NSLog(@"%@",allStr);
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    
    NSArray *allData =  [allResult sortedArrayUsingDescriptors:@[sort]];
    
    return allData;
    
}

@end
