//
//  DDComment.h
//  bs
//
//  Created by dt on 16/3/21.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDUser;
@interface DDComment : NSObject
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger voicetime;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger like_count;

@property (nonatomic, copy) NSString *voiceuri;

@property (nonatomic, strong) DDUser *user;
@end
