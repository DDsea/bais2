//
//  DDTopicPictureView.h
//  bs
//
//  Created by dt on 16/3/12.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDTopic;

@interface DDTopicPictureView : UIView
+ (instancetype)pictureView;

@property (nonatomic, strong) DDTopic *topic;
@end
