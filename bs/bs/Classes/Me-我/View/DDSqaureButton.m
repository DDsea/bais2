//
//  DDSqaureButton.m
//  bs
//
//  Created by dt on 16/4/2.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDSqaureButton.h"
#import "DDSquare.h"
#import "UIButton+WebCache.h"
@implementation DDSqaureButton
- (void)setup{

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont  systemFontOfSize:15];
    
    [self   setBackgroundImage:[UIImage imageNamed:@"mainCellBackgrund"] forState:UIControlStateNormal];



}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }

    return self;
}


- (void)awakeFromNib{
    [self  setup];

}


- (void)layoutSubviews{


    [super layoutSubviews];
    
    self.imageView.y = self.height * 0.15;
    
    self.imageView.width = self.width * 0.5;
    
    self.imageView.height = self.imageView.width;
    
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.x = 0;
    
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y ;



}

- (void)setSquare:(DDSquare *)square{


    _square = square;
    
    [self  setTitle:square.name forState:UIControlStateNormal];

    [self  sd_setImageWithURL:[NSURL  URLWithString:square.icon] forState:UIControlStateNormal];

}







@end
