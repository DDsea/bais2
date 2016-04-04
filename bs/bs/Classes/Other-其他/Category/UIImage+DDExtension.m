//
//  UIImage+DDExtension.m
//  bs
//
//  Created by dt on 16/4/1.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "UIImage+DDExtension.h"

@implementation UIImage (DDExtension)
- (UIImage *)circleImage{

    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    
    [self  drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    



    return image;

}
@end
