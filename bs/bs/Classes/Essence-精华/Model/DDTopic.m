//
//  DDTopic.m
//  bs
//
//  Created by dt on 16/3/9.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDTopic.h"
#import "MJExtension.h"
#import "DDComment.h"
#import "DDUser.h"
@implementation DDTopic

{
    CGFloat _cellHeight;
    
    CGRect _pictureF;
}


+ (NSDictionary *)replacedKeyFromPropertyName{

    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };

}

+ (NSDictionary *)objectClassInArray{

    return @{@"top_cmt": @"DDComment" };

}



- (NSString *)create_time{

    NSDateFormatter *fmt = [[NSDateFormatter  alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *create = [fmt  dateFromString:_create_time];
    
    if (create.isThisYear) {
        if (create.isToday) {
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour>= 1) {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1){
            
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{
            return @"刚刚";
            }
        }else if (create.isYesterday){
        fmt.dateFormat = @"昨天 HH:mm:ss";
            
            return [fmt   stringFromDate:create];
        
        }else {
        fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt  stringFromDate:create];
        
        }
    }else{
    
        return _create_time;
    }




}



- (CGFloat)cellHeight{

    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * DDTopicCellMargin, MAXFLOAT);
        CGFloat textH = [self.text  boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont  systemFontOfSize:14]} context:nil].size.height;
        
        _cellHeight = DDTopicCellTextY + textH + DDTopicCellMargin;
        
        if (self.type == DDTopicTypePicture) {
            CGFloat pictureW = maxSize.width;
            
            CGFloat pictureH = pictureW * self.height / self.width;
            
            
            if (pictureH >= DDTopicCellPictureMaxH) {
                pictureH = DDTopicCellPictureBreakH;
                self.bigPicture = YES;
            }
            
            
            
            CGFloat pictureX = DDTopicCellMargin;
            CGFloat pictureY = DDTopicCellTextY + textH + DDTopicCellMargin;
            
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + DDTopicCellMargin;
        }else if (self.type == DDTopicTypeVoice) {
            
            CGFloat voiceX = DDTopicCellMargin;
            CGFloat voiceY = DDTopicCellTextY + textH + DDTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            
            _cellHeight += voiceH + DDTopicCellMargin;
        
        } else if (self.type == DDTopicTypeVideo){
        
            CGFloat videoX = DDTopicCellMargin;
            CGFloat videoY = DDTopicCellTextY + textH + DDTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            
            _voiceF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + DDTopicCellMargin;
        
        
        }
        
       // DDComment *cmt = [self.top_cmt firstObject];
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
            
            CGFloat contentH = [content  boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont  systemFontOfSize:13]} context:nil].size.height;
            
            _cellHeight += DDTopicCellTopCmtTitleH + contentH + DDTopicCellMargin;
        }
        
        
        
        _cellHeight += DDTopicCellBottomBarH + DDTopicCellMargin;
    }
    return _cellHeight;
}













@end
