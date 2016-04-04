//
//  NSDate+DDExtension.m
//  bs
//
//  Created by dt on 16/3/9.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "NSDate+DDExtension.h"

@implementation NSDate (DDExtension)

- (NSDateComponents *)deltaFrom:(NSDate *)from{

    NSCalendar *calendar = [NSCalendar  currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar   components:unit fromDate:from toDate:self options:0];


}


- (BOOL)isThisYear{

    NSCalendar *calendar = [NSCalendar  currentCalendar];
    
    NSInteger nowYear = [calendar  component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar  component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;


}


- (BOOL)isToday{

    NSDateFormatter *fmt = [[NSDateFormatter   alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt   stringFromDate:[NSDate date]];
    NSString *selfString = [fmt  stringFromDate:self];
    
    
    return [nowString    isEqualToString:selfString];

}


- (BOOL)isYesterday{

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt  dateFromString:[fmt  stringFromDate:[NSDate  date]]];
    NSDate *selfDate = [fmt  dateFromString:[fmt  stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar  currentCalendar];
    NSDateComponents *cmps = [calendar  components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;





}





@end
