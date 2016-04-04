//
//  DDTopic.h
//  bs
//
//  Created by dt on 16/3/9.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDComment;
@interface DDTopic : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否为新浪加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) NSString *small_image;

@property (nonatomic, copy) NSString *middle_image;

@property (nonatomic, copy) NSString *large_image;

@property (nonatomic, assign) DDTopicType type;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, assign, readonly) CGRect pictureF;


@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

@property (nonatomic, assign) CGFloat pictureProgress;

@property (nonatomic, assign) NSInteger voicetime;

@property (nonatomic, assign) NSInteger videotime;

@property (nonatomic, assign) NSInteger playcount;

@property (nonatomic, assign, readonly) CGRect voiceF;

@property (nonatomic, assign, readonly) CGRect videoF;

@property (nonatomic, strong) DDComment *top_cmt;
@end
