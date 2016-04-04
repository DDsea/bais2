//
//  DDRecommendCategory.h
//  bs
//
//  Created by dt on 16/3/4.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDRecommendCategory : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger currentPage;
@end
