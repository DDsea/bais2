//
//  NSDate+DDExtension.h
//  bs
//
//  Created by dt on 16/3/9.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DDExtension)

- (NSDateComponents *)deltaFrom:(NSDate *)from;

- (BOOL)isThisYear;

- (BOOL)isToday;

- (BOOL)isYesterday;


@end
