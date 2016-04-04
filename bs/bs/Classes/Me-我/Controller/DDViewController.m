//
//  DDViewController.m
//  bs
//
//  Created by dt on 16/3/5.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDViewController.h"
#import "DDMeCell.h"
#import "DDMeFooterView.h"
@interface DDViewController ()

@end

@implementation DDViewController

static NSString *DDMeId = @"me";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self  setupNav];
    [self  setupTableView];
}


- (void)setupTableView{

    self.tableView.backgroundColor = XMGGlobalBg;
    

    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView  registerClass:[DDMeCell  class] forCellReuseIdentifier:DDMeId];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = DDTopicCellMargin;
    
    self.tableView.contentInset = UIEdgeInsetsMake(DDTopicCellMargin + 35, 0, 0, 0);
    
    
    self.tableView.tableFooterView = [[DDMeFooterView  alloc] init];

    
}





- (void)setupNav{


    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem = [UIBarButtonItem  itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem  itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
    
    



}





- (void)settingClick{
    NSLogFunc;
}

- (void)moonClick{
    NSLogFunc;

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    DDMeCell *cell = [tableView  dequeueReusableCellWithIdentifier:DDMeId];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    }else if (indexPath.section == 1) {
    
    cell.textLabel.text = @"离线下载";
    
    }


    return cell;

}







@end
