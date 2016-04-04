//
//  DDNavigationController.m
//  bs
//
//  Created by dt on 16/3/5.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDNavigationController.h"

@interface DDNavigationController ()

@end

@implementation DDNavigationController

+ (void)initialize{

    UINavigationBar *bar = [UINavigationBar appearance];
    
    [bar  setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];



}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{


    if (self.childViewControllers.count > 0) {
        UIButton *button = [UIButton  buttonWithType:UIButtonTypeCustom];
        [button  setTitle:@"返回" forState:UIControlStateNormal];
        [button  setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button  setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button  setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button  addTarget:self  action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];

}


- (void)back{
    [self popViewControllerAnimated:YES];


}






@end
