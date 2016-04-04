//
//  DDTextField.m
//  bs
//
//  Created by dt on 16/3/7.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDTextField.h"
static NSString * const DDPlacerholderColorKeyPath = @"_placeholderLabel.textColor";
@implementation DDTextField

- (void)awakeFromNib{
    self.tintColor = self.textColor;

    [self   resignFirstResponder];
}


- (BOOL)becomeFirstResponder{

    [self  setValue:self.textColor forKeyPath:DDPlacerholderColorKeyPath];
    
    return [super   becomeFirstResponder];

}


- (BOOL)resignFirstResponder{

    [self  setValue:[UIColor  grayColor] forKeyPath:DDPlacerholderColorKeyPath];
    
    return [super  resignFirstResponder];



}




@end
