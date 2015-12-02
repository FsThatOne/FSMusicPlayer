//
//  FSStatusModel.h
//  FSMusicPlayer
//
//  Created by FS小一 on 15/12/3.
//  Copyright © 2015年 FSxiaoyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSUser.h"

@interface FSStatusModel : NSObject
@property (nonatomic, copy) NSString* created_at;
@property (nonatomic, strong) NSNumber* idStr;
@property (nonatomic, strong) FSUser* user;
@end
