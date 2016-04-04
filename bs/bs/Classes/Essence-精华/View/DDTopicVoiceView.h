//
//  DDTopicVoiceView.h
//  bs
//
//  Created by dt on 16/3/16.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDTopic;
@interface DDTopicVoiceView : UIView
+ (instancetype)voiceView;

@property (nonatomic, strong) DDTopic *topic;
@end
