//
//  DDTabBarController.m
//  bs
//
//  Created by dt on 16/3/5.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDTabBarController.h"
#import "DDEssenceViewController.h"
#import "DDNewViewController.h"
#import "DDFriendTrendsViewController.h"
#import "DDViewController.h"
#import "DDTabBar.h"
#import "DDNavigationController.h"
@interface DDTabBarController ()

@end

@implementation DDTabBarController

+ (void)initialize{

    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont   systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary  dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor  darkGrayColor];
    
    UITabBarItem  *item = [UITabBarItem  appearance];
    
    
    [item  setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item  setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];





}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self  setupChildVc:[[DDEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self  setupChildVc:[[DDNewViewController  alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self  setupChildVc:[[DDFriendTrendsViewController  alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self  setupChildVc:[[DDViewController   alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    
    
    [self  setValue:[[DDTabBar alloc] init] forKeyPath:@"tabBar"];
    
    
    
}


- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{


    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    
    DDNavigationController *nav = [[DDNavigationController alloc]   initWithRootViewController:vc
                                   ];
    
    [self  addChildViewController:nav];




}







@end
