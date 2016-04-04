//
//  DDLoginRegisterViewController.m
//  bs
//
//  Created by dt on 16/3/7.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDLoginRegisterViewController.h"

@interface DDLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation DDLoginRegisterViewController


- (IBAction)back {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    [self  dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister:(UIButton *)button {

    [self.view  endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        self.loginViewLeftMargin.constant = - self.view.width;
        [button  setTitle:@"已有账号?" forState:UIControlStateNormal];
    }else{
        self.loginViewLeftMargin.constant = 0;
        [button  setTitle:@"注册账号" forState:UIControlStateNormal];
    
    }
    
    [UIView  animateWithDuration:0.25 animations:^{
        [self.view  layoutIfNeeded];
    }];



}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//
//    return UIStatusBarStyleLightContent;
//}
//
//

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
