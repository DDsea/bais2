//
//  DDRecommendTagsViewController.m
//  bs
//
//  Created by dt on 16/3/4.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDRecommendTagsViewController.h"
#import "DDRecommendTag.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "DDRecommendTagCell.h"
@interface DDRecommendTagsViewController ()
@property (nonatomic, strong) NSArray *tags;
@end

@implementation DDRecommendTagsViewController

static NSString * const DDTagsId = @"tag";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self   setupTableView];
    [self  loadTags];

}


- (void)loadTags{

    [SVProgressHUD  showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
   [[AFHTTPSessionManager   manager]  GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
       self.tags = [DDRecommendTag   objectArrayWithKeyValuesArray:responseObject];
       [self.tableView   reloadData];
       [SVProgressHUD   dismiss];
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
       [SVProgressHUD  showErrorWithStatus:@"加载精华标签数据失败"];
   }];
    

}

- (void)setupTableView {

self.title = @"推荐标签";
    [self.tableView   registerNib:[UINib  nibWithNibName:NSStringFromClass([DDRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:DDTagsId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = XMGGlobalBg;




}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.tags.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    DDRecommendTagCell *cell = [tableView  dequeueReusableCellWithIdentifier:DDTagsId];
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;


}


@end
