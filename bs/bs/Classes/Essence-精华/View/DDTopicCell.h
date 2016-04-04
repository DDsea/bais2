//
//  DDTopicCell.h
//  bs
//
//  Created by dt on 16/3/9.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDTopic;
@interface DDTopicCell : UITableViewCell
@property (nonatomic, strong) DDTopic *topic;

+ (instancetype)cell;
@end
