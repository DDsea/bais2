//
//  DDFriendTrendsViewController.m
//  bs
//
//  Created by dt on 16/3/4.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDFriendTrendsViewController.h"
#import "DDRecommendViewController.h"
#import "DDLoginRegisterViewController.h"
@interface DDFriendTrendsViewController ()

@end

@implementation DDFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
 self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    self.view.backgroundColor = XMGGlobalBg;
    
}


- (void)friendsClick{

    DDRecommendViewController *vc = [[DDRecommendViewController  alloc] init];
    
    [self.navigationController   pushViewController:vc
                                           animated:YES];


}

- (IBAction)loginRegister {
    
    DDLoginRegisterViewController *login = [[DDLoginRegisterViewController alloc] init];
    [self  presentViewController:login animated:YES completion:nil];
    
}



@end
