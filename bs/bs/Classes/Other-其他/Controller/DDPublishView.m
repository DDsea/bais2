//
//  DDPublishView.m
//  bs
//
//  Created by dt on 16/3/12.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDPublishView.h"
#import "DDVerticalButton.h"
#import "POP.h"
static CGFloat const DDAnimationDelay = 0.1;
static CGFloat const DDSpringFactor = 10;
@interface DDPublishView ()

@end

@implementation DDPublishView


+ (instancetype)publishView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];

}


static UIWindow *window_;


+ (void)show{
    window_ = [[UIWindow alloc] init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    window_.hidden = NO;
    
    DDPublishView *publishView = [DDPublishView publishView];
    publishView.frame = window_.bounds;
    [window_  addSubview:publishView];


}



- (void)awakeFromNib {
    self.userInteractionEnabled = NO;
    
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    int maxCols = 3;
    
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (DDScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (DDScreenW - 2*buttonStartX - maxCols * buttonW) / (maxCols -1);
    
    for (int i = 0; i<images.count; i++) {
        DDVerticalButton *button = [[DDVerticalButton alloc] init];
        button.tag = i;
        [button  addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self   addSubview:button];
        
        button.titleLabel.font = [UIFont  systemFontOfSize:14];
        [button  setTitle:titles[i] forState:UIControlStateNormal];
        [button  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button  setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
//        button.width = buttonW;
//        button.height = buttonH;
        
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - DDScreenH;
        
        POPSpringAnimation *anim = [POPSpringAnimation  animationWithPropertyNamed:kPOPViewFrame];
        
        anim.fromValue = [NSValue  valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = DDSpringFactor;
        anim.springSpeed = DDSpringFactor;
        anim.beginTime = CACurrentMediaTime() + DDAnimationDelay * i;
        
        [button  pop_addAnimation:anim forKey:nil];
        
    }
    
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage  imageNamed:@"app_slogan"]];
    
    [self  addSubview:sloganView];
    
    POPSpringAnimation *anim = [POPSpringAnimation  animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = DDScreenW * 0.5;
    CGFloat centerEndY = DDScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - DDScreenH;
    
    anim.fromValue = [NSValue  valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue  valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * DDAnimationDelay;
    anim.springBounciness = DDSpringFactor;
    anim.springSpeed = DDSpringFactor;
    
    [anim setCompletionBlock:^(POPAnimation *anim , BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    
    [sloganView  pop_addAnimation:anim forKey:nil];

    
}


- (void)buttonClick:(UIButton *)button{
[self  cancelWithCompletionBlock:^{
    if (button.tag == 0) {
        NSLog(@"发视频");
    }else if (button.tag == 1){
    
        NSLog(@"发图片");
    }
}];


}

- (void)cancelWithCompletionBlock:(void(^)())completionBlock{
    self.userInteractionEnabled = NO;
    
    int beginIndex = 1;
    
    for (int i = beginIndex; i<self.subviews.count; i++) {
        UIView *subview = self.subviews[i];
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + DDScreenH;
        anim.toValue = [NSValue  valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * DDAnimationDelay;
        [subview  pop_addAnimation:anim forKey:nil];
        
        if (i == self.subviews.count - 1) {
            [anim  setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                window_ = nil;
                
                !completionBlock ? : completionBlock();
                
            }];
        }
    }


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self  cancelWithCompletionBlock:nil];
}

- (IBAction)cancel {
    
    [self  cancelWithCompletionBlock:nil];


}


@end
