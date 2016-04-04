//
//  DDRecommendCategory.m
//  bs
//
//  Created by dt on 16/3/4.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDRecommendCategory.h"

@implementation DDRecommendCategory
- (NSMutableArray *)users{

    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
