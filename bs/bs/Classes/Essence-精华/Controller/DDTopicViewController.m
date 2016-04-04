//
//  DDTopicViewController.m
//  bs
//
//  Created by dt on 16/3/10.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDTopicViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "DDTopic.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "DDTopicCell.h"
#import "DDCommentViewController.h"
#import "DDNewViewController.h"
@interface DDTopicViewController ()
@property (nonatomic, strong) NSMutableArray *topics;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString *maxtime;

@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, assign) NSInteger lastSelectedIndex;
@end

@implementation DDTopicViewController

- (NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }

    return _topics;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setupTableView];
    [self  setupRefresh];
    

}

static NSString *const DDTopicCellId = @"topic";



- (void)setupTableView{


    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = DDTitilesViewY + DDTitilesViewH;
    
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor  clearColor];
    
    
    [self.tableView  registerNib:[UINib   nibWithNibName:NSStringFromClass([DDTopicCell  class]) bundle:nil] forCellReuseIdentifier:DDTopicCellId];

    [DDNoteCenter  addObserver:self selector:@selector(tabBarSelect) name:DDTabBarDidSelectNotification object:nil];
}

- (void)tabBarSelect{

    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        [self.tableView.header  beginRefreshing];
    }
    
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}


- (void)setupRefresh
{

    self.tableView.header = [MJRefreshNormalHeader   headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    self.tableView.header.autoChangeAlpha = YES;
    
    [self.tableView.header  beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter    footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    




}

- (NSString *)a{


return [self.parentViewController   isKindOfClass:[DDNewViewController class]] ?  @"newlist":@"list";
}





- (void)loadNewTopics{

    [self.tableView.footer  endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    
    [[AFHTTPSessionManager  manager]  GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (self.params != params) {
            return ;
        }
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [DDTopic  objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView  reloadData];
        
        [self.tableView.header  endRefreshing];
        
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) {
            return ;
        }
        
        [self.tableView.header  endRefreshing];
    }];




}



- (void)loadMoreTopics{

    [self.tableView.header  endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    
    
    
   [[AFHTTPSessionManager manager]  GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
       if (self.params != params) {
           return ;
       }
       
       self.maxtime = responseObject[@"info"][@"maxtime"];
       
       NSArray *newTopics = [DDTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
       [self.topics  addObjectsFromArray:newTopics];
       [self.tableView  reloadData];
       
       [self.tableView.footer  endRefreshing];
       self.page = page;
       
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
       if (self.params != params) {
           return ;
       
           
       }
       
       [self.tableView.footer  endRefreshing];
   }];
    
    
    
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    self.tableView.footer.hidden = (self.topics.count == 0);
    
    return self.topics.count;



}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    DDTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:DDTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;


}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    DDTopic *topic = self.topics[indexPath.row];
    
    
    return topic.cellHeight;

}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DDCommentViewController *commentVc = [[DDCommentViewController alloc] init];
    
    commentVc.topic = self.topics[indexPath.row];
    
    [self.navigationController  pushViewController:commentVc animated:YES];

}





@end
