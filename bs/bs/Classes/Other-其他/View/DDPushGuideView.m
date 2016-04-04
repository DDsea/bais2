//
//  DDPushGuideView.m
//  bs
//
//  Created by dt on 16/3/8.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDPushGuideView.h"

@implementation DDPushGuideView

+ (void)show{

NSString *key = @"CFBundleShortVersionString";
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    NSString *sanboxVersion = [[NSUserDefaults  standardUserDefaults] stringForKey:key];
    
    if (![currentVersion  isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication  sharedApplication].keyWindow;
        DDPushGuideView *guideView = [DDPushGuideView  guideView];
        guideView.frame = window.bounds;
        [window  addSubview:guideView];
        
        [[NSUserDefaults  standardUserDefaults]  setObject:currentVersion forKey:key];
        [[NSUserDefaults  standardUserDefaults] synchronize];
        
    }



}


+ (instancetype)guideView{


    return [[[NSBundle mainBundle]  loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];

}

- (IBAction)dd {
    
    [self  removeFromSuperview];
}




@end
