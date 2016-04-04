//
//  DDProgressView.m
//  bs
//
//  Created by dt on 16/3/12.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDProgressView.h"

@implementation DDProgressView

- (void)awakeFromNib{

    self.roundedCorners = 2;
    
    self.progressLabel.textColor = [UIColor blackColor];



}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{

    [super  setProgress:progress animated:animated];
    
    NSString *text = [NSString  stringWithFormat:@"%.0f%%",progress * 100];
    
    self.progressLabel.text = [text  stringByReplacingOccurrencesOfString:@"-" withString:@""];



}







@end
