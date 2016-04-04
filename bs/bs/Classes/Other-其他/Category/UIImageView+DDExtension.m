//
//  UIImageView+DDExtension.m
//  bs
//
//  Created by dt on 16/4/1.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "UIImageView+DDExtension.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (DDExtension)
- (void)setHeader:(NSString *)url{

    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"]   circleImage];
    
    [self  sd_setImageWithURL:[NSURL  URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];


}
@end
