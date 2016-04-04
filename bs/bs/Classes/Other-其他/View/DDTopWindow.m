//
//  DDTopWindow.m
//  bs
//
//  Created by dt on 16/3/22.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDTopWindow.h"

@implementation DDTopWindow

static UIWindow *window_;

+ (void)initialize{

    window_ = [[UIWindow  alloc] init];
    window_.frame = CGRectMake(0, 0, DDScreenW, 20);
    
    UIViewController *vc = [[UIViewController alloc] init];
    window_.backgroundColor = [UIColor  whiteColor];
    vc.view.backgroundColor = [UIColor  whiteColor];
    vc.view.alpha = 0.3;
    window_.rootViewController = vc;
    window_.alpha = 0.3;
    window_.windowLevel = UIWindowLevelAlert;
    
    [window_  addGestureRecognizer:[[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(windowClick)]];



}


+ (void)show{

    window_.hidden = NO;

}

+ (void)hide{

    window_.hidden = YES;

}



+ (void)windowClick{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self  searchScrollViewInView:window];



}



+ (void)searchScrollViewInView:(UIView *)superview{

    for (UIScrollView *subview in superview.subviews) {
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y  = - subview.contentInset.top;
            [subview  setContentOffset:offset animated:YES];
        }
        
        [self  searchScrollViewInView:subview];
    }
}


@end
