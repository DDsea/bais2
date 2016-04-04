//
//  DDMeFooterView.m
//  bs
//
//  Created by dt on 16/4/2.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDMeFooterView.h"
#import "AFNetworking.h"
#import "DDSquare.h"
#import "MJExtension.h"
#import "DDSqaureButton.h"
#import "DDWebViewController.h"
@implementation DDMeFooterView


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor  clearColor];
        
        NSMutableDictionary *params = [NSMutableDictionary  dictionary];
        
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        [[AFHTTPSessionManager  manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *squaures = [DDSquare  objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            [self  createSauares:squaures];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }

    return self;


}

- (void)createSauares:(NSArray *)sqaures{

    int maxCols = 4;
    
    CGFloat buttonW = DDScreenW / maxCols;
    CGFloat buttonH  = buttonW;
    
    for (int i = 0; i< sqaures.count; i++) {
        DDSqaureButton *button= [DDSqaureButton  buttonWithType:UIButtonTypeCustom];
        
        [button  addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.square = sqaures[i];
        [self  addSubview:button];
        
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
    }

    NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
    
    self.height = rows * buttonH;
    
    

   // [self  setNeedsDisplay];

}


- (void)buttonClick:(DDSqaureButton *)button{
    if (![button.square.url  hasPrefix:@"http"]) return;
    
    
    DDWebViewController *web = [[DDWebViewController alloc] init];
    
    web.url = button.square.url;
    web.title = button.square.name;
    
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication   sharedApplication].keyWindow.rootViewController;
    
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
    
    [nav  pushViewController:web animated:YES];
       



}






@end
